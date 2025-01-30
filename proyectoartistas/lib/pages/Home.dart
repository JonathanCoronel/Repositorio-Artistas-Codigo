import 'package:flutter/material.dart';
import 'CatalogPage.dart';

class Home extends StatelessWidget {
  const Home({super.key, required this.userData});
  final Map<String, dynamic> userData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ArteLatino'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CatalogPage(category: 'Murales', userData: userData),
                ),
              );
            },
            child: Card(
              child: Column(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                        image: NetworkImage(
                            'https://www.enelgreenpower.com/content/dam/enel-egp/immagini/articoli/storie/proyecto-murales-mexico_2400x1160.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text('Murales'),
                    trailing: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFC107),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CatalogPage(category: 'Pinturas', userData: userData),
                ),
              );
            },
            child: Card(
              child: Column(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                        image: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6aAAPvBm1Ur8KlNGm5fbgROTXLWGkUZM1IA&s'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text('Pinturas a mano'),
                    trailing: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFC107),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CatalogPage(category: 'Prendas', userData: userData),
                ),
              );
            },
            child: Card(
              child: Column(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                        image: NetworkImage(
                            'https://www.chio-lecca.edu.pe/cdn/shop/articles/chio-lecca-blog-prendas-de-vestir.jpg?v=1709925816'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text('Prendas de vestir'),
                    trailing: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFC107),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
