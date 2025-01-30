import 'package:flutter/material.dart';
import 'package:proyectoartistas/pages/publicarTrabajo.dart';

class PerfilArtista extends StatelessWidget {
  const PerfilArtista({super.key, required this.userData});
  final Map<String, dynamic> userData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  userData['user']['name'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PublicarTrabajoScreen(userData: userData),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFC107),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 90,
                ),
              ),
              child: const Text(
                'Publicar un trabajo',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004170),
                ),
              ),
            ),
            const Divider(thickness: 1, color: Colors.grey),
            // ListTile(
            //   leading: const Icon(Icons.favorite, color: Colors.black),
            //   title: const Text(
            //     "Mis me gusta",
            //     style:
            //         TextStyle(color: Color(0xFF004170)), // Cambia el color aquí
            //   ),
            //   onTap: () {
            //     // Lógica para "Mis me gusta"
            //   },
            // ),
            // ListTile(
            //   leading: const Icon(Icons.people, color: Colors.black),
            //   title: const Text(
            //     "Artistas que sigo",
            //     style: TextStyle(color: Color(0xFF004170)),
            //   ),
            //   onTap: () {
            //     // Lógica para "Artistas que sigo"
            //   },
            // ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.black),
              title: const Text(
                "Cambiar correo",
                style: TextStyle(
                    color: Color(0xFF004170)), // Cambia el color del texto aquí
              ),
              onTap: () {
                // Navegar a la página para cambiar correo
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.black),
              title: const Text(
                "Cambiar contraseña",
                style: TextStyle(
                    color: Color(0xFF004170)), // Cambia el color del texto aquí
              ),
              onTap: () {
                // Navegar a la página para cambiar contraseña
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.black),
              title: const Text(
                "Eliminar cuenta",
                style: TextStyle(color: Color(0xFF004170)),
              ),
              onTap: () {
                // Lógica para eliminar cuenta
              },
            ),
            ListTile(
              leading: const Icon(Icons.info, color: Colors.black),
              title: const Text(
                "Acerca de la app",
                style: TextStyle(color: Color(0xFF004170)),
              ),
              onTap: () {
                // Lógica para "Acerca de la app"
              },
            ),
            const SizedBox(height: 20),
            const Divider(thickness: 1, color: Colors.grey),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Centra horizontalmente
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Centra verticalmente
              children: [
                Image.asset(
                  'images/logo.png', // Asegúrate de agregar tu logo a los assets
                  width: 120,
                  height: 120,
                ),
                const SizedBox(width: 10), // Espacio entre la imagen y el texto
                const Text(
                  "ArteLatino",
                  style: TextStyle(
                    fontSize: 32, // Tamaño más grande
                    fontWeight: FontWeight.w900, // Negrita más intensa
                    color: Color(
                        0xFF004170), // Color azul personalizado (puedes cambiar el valor)
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
