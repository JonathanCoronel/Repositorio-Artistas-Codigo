import 'package:flutter/material.dart';
import 'package:proyectoartistas/pages/conversation.dart';

class ChatArtista extends StatelessWidget {
  const ChatArtista({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.center,
          child: Text(
            'Chats',
            style: TextStyle(color: Color(0xFF004170)),
          ),
        ),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Barra de búsqueda
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.grey.shade300),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Buscar',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Contenedor con fondo gris medio para imagen, nombre y flecha
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                    255, 248, 248, 248), // Fondo gris medio
                borderRadius: BorderRadius.circular(50), // Bordes redondeados
              ),
              child: Row(
                children: [
                  // Imagen de perfil
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(
                      'https://i.pinimg.com/originals/77/dc/64/77dc6462a4e471e19cd76e6e18776949.jpg',
                    ), // Sustituye con la URL real
                  ),
                  const SizedBox(width: 12),
                  // Nombre del contacto
                  const Expanded(
                    child: Text(
                      'Laura Martínez',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Icono de flecha
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Conversation(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: Color(0xFFFFC107),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                    255, 248, 248, 248), // Fondo gris medio
                borderRadius: BorderRadius.circular(50), // Bordes redondeados
              ),
              child: Row(
                children: [
                  // Imagen de perfil
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(
                      'https://th.bing.com/th/id/OIP.ybDRaKPpzgwDAzSzoKJxmQHaLI?rs=1&pid=ImgDetMain',
                    ), // Sustituye con la URL real
                  ),
                  const SizedBox(width: 12),
                  // Nombre del contacto
                  const Expanded(
                    child: Text(
                      'Juan Pérez',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Icono de flecha
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Conversation(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: Color(0xFFFFC107),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                    255, 248, 248, 248), // Fondo gris medio
                borderRadius: BorderRadius.circular(50), // Bordes redondeados
              ),
              child: Row(
                children: [
                  // Imagen de perfil
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(
                      'https://i.pinimg.com/736x/d3/67/7b/d3677bd85aca84c1e651e497d82d80fb.jpg',
                    ), // Sustituye con la URL real
                  ),
                  const SizedBox(width: 12),
                  // Nombre del contacto
                  const Expanded(
                    child: Text(
                      'Carlos Fernández',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Icono de flecha
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Conversation(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: Color(0xFFFFC107),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                    255, 248, 248, 248), // Fondo gris medio
                borderRadius: BorderRadius.circular(50), // Bordes redondeados
              ),
              child: Row(
                children: [
                  // Imagen de perfil
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(
                      'https://th.bing.com/th/id/OIP.nOcMFyQfvCIkXt3elaDrAQHaJQ?rs=1&pid=ImgDetMain',
                    ), // Sustituye con la URL real
                  ),
                  const SizedBox(width: 12),
                  // Nombre del contacto
                  const Expanded(
                    child: Text(
                      'María López',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Icono de flecha
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Conversation(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: Color(0xFFFFC107),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
