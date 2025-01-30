import 'package:flutter/material.dart';

class Conversation extends StatelessWidget {
  const Conversation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset:
          true, // Esto asegura que la pantalla se reajuste
      appBar: AppBar(
        title: const Text(
          'Laura Martínez',
          style: TextStyle(color: Color(0xFF004170)),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
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

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  // Imagen del mural
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade200,
                    ),
                    child: Image.asset(
                      'images/image.png', // Asegúrate de agregar tu imagen a los assets
                      width: 100,
                      height: 120,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Mensajes
                  ChatBubble(
                    isUser: false,
                    text:
                        'Buenas tardes, me interesaría más información sobre la cotización para un mural similar.',
                    textColor: Colors.black, // Gris para el otro usuario
                    bgColor: Colors.grey.shade200, // Fondo gris
                    widthFactor: 0.7, // Ajuste del ancho
                  ),
                  ChatBubble(
                    isUser: true,
                    text:
                        'Buenas tardes, claro para ese tipo de estilo manejo con distintos precios, aquí te muestro un catálogo.\n\n- Murales en fachadas de edificios: \$50 - \$150\n- Murales en edificios históricos de alto perfil: \$150 - \$500\n- Murales estilo grafiti o arte urbano: \$50 - \$70\n- Murales de arte urbano: \$50 - \$90,000',
                    textColor: Colors.black, // Azul oscuro para el usuario
                    bgColor: Colors.blue.shade100, // Fondo azul claro
                    widthFactor: 0.8, // Ajuste del ancho
                  ),
                  ChatBubble(
                    isUser: false,
                    text:
                        '¿Eso incluye todo? ¿O hay costos adicionales, como materiales o transporte?',
                    textColor: Colors.black, // Gris para el otro usuario
                    bgColor: Colors.grey.shade200, // Fondo gris
                    widthFactor: 0.7, // Ajuste del ancho
                  ),
                ],
              ),
            ),
            // Input de mensaje
            Container(
              color: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Escribe un mensaje...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.send, color: Colors.blue),
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

class ChatBubble extends StatelessWidget {
  final bool isUser;
  final String text;
  final Color textColor;
  final Color bgColor;
  final double widthFactor; // Factor de ancho

  const ChatBubble({
    required this.isUser,
    required this.text,
    required this.textColor,
    required this.bgColor,
    required this.widthFactor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * widthFactor),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: bgColor, // Fondo con base de colores
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            text,
            style: TextStyle(color: textColor), // Color de texto
          ),
        ),
      ),
    );
  }
}
