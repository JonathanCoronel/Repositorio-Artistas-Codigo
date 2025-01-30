import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class VerPerfilArtista extends StatelessWidget {
  final String artista; // Agrega una propiedad para el artista

  const VerPerfilArtista({super.key, required this.artista});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(artista),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Perfil del Artista',
              style: TextStyle(color: Colors.white70),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Productos del Artista
              const Text(
                'Productos del Artista',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004170),
                ),
              ),
              const SizedBox(height: 16),
              CardProductosArtista(artista: artista),
              const SizedBox(height: 24),
              // Reseñas de Clientes
              const Text(
                'Reseñas de Clientes',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004170),
                ),
              ),
              const SizedBox(height: 16),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Card(
                    child: ListTile(
                      leading: const CircleAvatar(child: Text('C1')),
                      title: const Text('Cliente 1'),
                      subtitle: const Text(
                          'Excelente trabajo, me encantó la camiseta que compré'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          5,
                          (index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const CircleAvatar(child: Text('C2')),
                      title: const Text('Cliente 2'),
                      subtitle: const Text('Buen trabajo, recomendado'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          5,
                          (index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Entrevistas con Artistas
              const Text(
                'Entrevistas con Artistas',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004170),
                ),
              ),
              const SizedBox(height: 16),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.play_circle_fill, size: 40),
                      title: Text('Entrevista 1'),
                      subtitle: Text('Su infancia\nAutor: Roberto Encalada'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.play_circle_fill, size: 40),
                      title: Text('Entrevista 2'),
                      subtitle: Text('Su vida diaria\nAutor: Juan Peralta'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Botón de suscripción
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Acción del botón
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC107),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 120, vertical: 16),
                  ),
                  child: const Text(
                    'Suscribirse',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF004170),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class CardProductosArtista extends StatefulWidget {
  final String artista; // Recibe el artista

  const CardProductosArtista({super.key, required this.artista});

  @override
  State<CardProductosArtista> createState() => _CardProductosArtistaState();
}

class _CardProductosArtistaState extends State<CardProductosArtista> {
  Map<String, List<Map<String, dynamic>>> _productsByAuthor =
      {}; // Productos agrupados por autor

  // Cargar y procesar el archivo JSON
  Future<void> _loadProducts() async {
    try {
      final response = await http.get(Uri.parse(
          'http://172.17.170.54:5002/api/get_author_items?author=${widget.artista}'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        setState(() {
          _productsByAuthor[widget.artista] = data.map((item) {
            return {
              'title': item['title'],
              'url': item['url'],
              'author': item['author'],
              'category': item['category'],
              'description': item['description'],
              'price': item['price'],
            };
          }).toList();
        });
      } else {
        print('Error al cargar los productos');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    // Filtrar solo los productos del artista
    List<Map<String, dynamic>> productsForAuthor =
        _productsByAuthor[widget.artista] ?? [];

    return productsForAuthor.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              CarouselSlider(
                items: productsForAuthor
                    .map((item) => _buildCarouselItem(item))
                    .toList(),
                options: CarouselOptions(
                  height: 320,
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
              ),
            ],
          );
  }

  // Construye un ítem para el carrusel
  Widget _buildCarouselItem(Map<String, dynamic> item) {
    return Card(
      elevation: 5,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            item['url'] ?? '',
            height: 215,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10),
          Text(
            item['title'] ?? 'Sin título',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
