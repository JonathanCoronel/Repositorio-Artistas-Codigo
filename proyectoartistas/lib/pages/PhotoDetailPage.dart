import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectoartistas/pages/carrito_compras.dart';
import 'package:proyectoartistas/pages/components/carrito_component.dart';
import 'package:proyectoartistas/pages/conversation.dart';
import 'package:proyectoartistas/pages/verPerfilArtista.dart';

class PhotoDetailPage extends StatelessWidget {
  final String imageUrl;
  final String description;
  final String title;
  final String category;

  const PhotoDetailPage({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final String buttonText =
        category == 'Prendas de vestir' ? 'Comprar' : 'Contactar';
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF004170)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Color(0xFF004170),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.red),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imageUrl,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navegar a la pantalla VerPerfilArtista al presionar la columna
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const VerPerfilArtista(artista: 'Andres Socoto',),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 6,
                            spreadRadius: 2,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16), // Espacio para el título
                          const Row(
                            children: [
                              Text(
                                'Autor: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('Andrés Sacoto'),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Row(
                            children: [
                              Text(
                                'Fecha de creación: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('2 de junio de 2023'),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Descripción:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            description,
                            style: const TextStyle(height: 1.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: -20,
                    left: 16,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF004170),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Información de la obra',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (category == 'Prendas de vestir') {
                      final cartProvider =
                          Provider.of<CartProvider>(context, listen: false);
                      cartProvider.addItem({
                        'title': title,
                        'price': 25.0,
                        'imageUrl': imageUrl,
                        'description': description,
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CarritoCompras(),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Conversation(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC107),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: Icon(
                    category == 'Prendas de vestir'
                        ? Icons.shopping_cart
                        : Icons.chat_bubble_outline,
                    color: Colors.black,
                  ),
                  label: Text(
                    buttonText,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
