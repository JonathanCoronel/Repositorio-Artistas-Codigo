import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectoartistas/pages/carrito_compras.dart';
import 'package:proyectoartistas/pages/components/carrito_component.dart';
import 'package:proyectoartistas/pages/conversation.dart';
import 'package:proyectoartistas/pages/verPerfilArtista.dart';

class ProductDetailPage extends StatelessWidget {
  final String imageUrl;
  final String description;
  final String title;
  final String category;
  final String author;
  final String date;
  final double price;

  const ProductDetailPage({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.author,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            _buttonArrow(context),
            _scrollableContent(context),
          ],
        ),
      ),
    );
  }

  Widget _buttonArrow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.black.withOpacity(0.1),
              ),
              child: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _scrollableContent(BuildContext context) {
    final String buttonText = category == 'Prendas' ? 'Comprar' : 'Contactar';
    return DraggableScrollableSheet(
      initialChildSize: 0.3,
      maxChildSize: 0.6,
      minChildSize: 0.3,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 5,
                    width: 35,
                    margin: const EdgeInsets.only(bottom: 10),
                    color: Colors.black12,
                  ),
                ),
                Center(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    const CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage("images/avatar.png"),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      author,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        // Navegación a otra página
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerPerfilArtista(
                              artista: author,
                            ),
                          ),
                        );
                      },
                      child: const CircleAvatar(
                        radius: 25,
                        backgroundColor: Color(0xFFFFC107),
                        child: Icon(Icons.arrow_forward_rounded,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                const Divider(height: 30, thickness: 1),
                const Text(
                  "Fecha de Creación",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 13),
                const Text(
                  "Descripción",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(height: 30, thickness: 1),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (category == 'Prendas') {
                          final cartProvider =
                              Provider.of<CartProvider>(context, listen: false);
                          cartProvider.addItem({
                            'title': title,
                            'price': price,
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
                        category == 'Prendas'
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
      },
    );
  }

  Widget _detailRow(BuildContext context, String title, String value) {
    return Row(
      children: [
        Text(
          "$title: ",
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }
}
