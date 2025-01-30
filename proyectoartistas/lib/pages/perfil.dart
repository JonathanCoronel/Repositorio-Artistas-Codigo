import 'package:flutter/material.dart';
import 'package:proyectoartistas/pages/perfilArtista.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key, required this.userData});
  final Map<String, dynamic> userData;

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  void initState() {
    super.initState();
  }

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
                  widget.userData['user']['name'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const Divider(thickness: 1, color: Colors.grey),
            // ListTile(
            //   leading: const Icon(Icons.favorite, color: Colors.black),
            //   title: const Text(
            //     "Mis me gusta",
            //     style: TextStyle(color: Color(0xFF004170)),
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
                style: TextStyle(color: Color(0xFF004170)),
              ),
              onTap: () {
                // Navegar a la página para cambiar correo
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.black),
              title: const Text(
                "Cambiar contraseña",
                style: TextStyle(color: Color(0xFF004170)),
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PerfilArtista(
                        userData: widget.userData), // Pasando userData
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFC107),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 30,
                ),
              ),
              child: const Text(
                'Conviertete en artista',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004170),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
