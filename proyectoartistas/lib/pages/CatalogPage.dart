import 'package:flutter/material.dart';
import 'package:proyectoartistas/pages/detail_prudct.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CatalogPage extends StatefulWidget {
  final String category;

  const CatalogPage(
      {super.key, required this.category, required this.userData});
  final Map<String, dynamic> userData;

  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  List<Map<String, dynamic>>? items;

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  Future<void> fetchItems() async {
    try {
      final response = await http.get(Uri.parse(
          'http://172.17.170.54:5002/api/get_category_items?category=${widget.category}'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          items = data.map((e) {
            final item = e as Map<String, dynamic>;
            item['isLiked'] = item['isLiked'] ?? false;
            return item;
          }).toList();
        });
      } else {
        print('Failed to load items: ${response.body}');
      }
    } catch (e) {
      print('Error fetching items: $e');
    }
  }

  Future<List<Map<String, dynamic>>> _fetchComments(String itemId) async {
    try {
      final response = await http.get(Uri.parse(
          'http://172.17.170.54:5002/api/get_comments?item_id=$itemId'));

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(json.decode(response.body));
      } else {
        print('Error al obtener comentarios: ${response.body}');
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<void> _addComment(String itemId, String comment) async {
    try {
      final response = await http.post(
        Uri.parse('http://172.17.170.54:5002/api/add_comment'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "item_id": itemId,
          "user_name": widget.userData['user']['name'],
          "comment": comment
        }),
      );

      if (response.statusCode == 201) {
        print('Comentario agregado exitosamente');
        setState(() {}); // Refresca la pantalla
      } else {
        print('Error al agregar comentario: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _showCommentsModal(BuildContext context, String itemId) {
    TextEditingController commentController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SingleChildScrollView(
          // Envuelve el contenido con SingleChildScrollView
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Comentarios',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: _fetchComments(itemId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No hay comentarios.'));
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final comment = snapshot.data![index];
                          return ListTile(
                            title: Text(comment['user_name']),
                            subtitle: Text(comment['comment']),
                            trailing: Text(comment['date'].substring(0, 10)),
                          );
                        },
                      );
                    },
                  ),
                ),
                TextField(
                  controller: commentController,
                  decoration: InputDecoration(
                    hintText: 'Escribe un comentario...',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.send, color: Colors.blue),
                      onPressed: () {
                        if (commentController.text.isNotEmpty) {
                          _addComment(itemId, commentController.text);
                          commentController.clear();
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF004170)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.category,
          style: const TextStyle(
            color: Color(0xFF004170),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: items == null
          ? const Center(child: CircularProgressIndicator())
          : items!.isEmpty
              ? const Center(
                  child: Text('No items available for this category'))
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 3 / 4,
                    ),
                    itemCount: items!.length,
                    itemBuilder: (context, index) {
                      final item = items![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailPage(
                                author: item['author']!,
                                date: item['date']!,
                                imageUrl: item['url']!,
                                description: item['description']!,
                                title: item['title']!,
                                category: item['category']!,
                                price: item['category'] == 'Prendas'
                                    ? item['price']
                                    : 0.0,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          elevation: 4,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Image.network(
                                  item['url'],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.6),
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(12.0),
                                      bottomRight: Radius.circular(12.0),
                                    ),
                                  ),
                                  child: Text(
                                    item['title'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: IconButton(
                                  icon: const Icon(Icons.comment,
                                      color: Colors.black),
                                  onPressed: () {
                                    _showCommentsModal(context, item['id']);
                                  },
                                ),
                              ),
                              // Positioned(
                              //   top: 8,
                              //   left: 8,
                              //   child: IconButton(
                              //     icon: Icon(
                              //       item['isLiked']
                              //           ? Icons.favorite
                              //           : Icons.favorite_border,
                              //       color: item['isLiked']
                              //           ? Colors.red
                              //           : Colors.white,
                              //     ),
                              //     onPressed: () {
                              //       setState(() {
                              //         item['isLiked'] =
                              //             !(item['isLiked'] ?? false);
                              //       });
                              //     },
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
