import 'package:flutter/material.dart';

class CompraCompletada extends StatelessWidget {
  const CompraCompletada({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Compra Completada")),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "¡Compra Completada!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 100,
            ),
          ],
        ),
      ),
    );
  }
}
