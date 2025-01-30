import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectoartistas/pages/components/carrito_component.dart';

import 'package:proyectoartistas/pages/compra_completada.dart';

class CarritoCompras extends StatelessWidget {
  const CarritoCompras({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtiene el proveedor del carrito
    final cartProvider = Provider.of<CartProvider>(context);

    // Calcula el total dinámicamente
    double total = cartProvider.items.fold(
      0,
      (sum, item) => sum + item['price'],
    );

    bool isCartEmpty = cartProvider.items.isEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.center,
          child: Text(
            'Mi Carrito',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Productos',
                  style: TextStyle(
                      color: Color(0xFF004170),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              cartProvider.items.isEmpty
                  ? const Center(
                      child: Text(
                        'No hay productos en el carrito',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cartProvider.items.length,
                      itemBuilder: (context, index) {
                        var item = cartProvider.items[index];
                        return Card(
                          color: Colors.white,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.grey.shade300),
                          ),
                          elevation: 5,
                          child: SizedBox(
                            height: 110, // Definir la altura de la tarjeta
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              leading: Image.network(
                                item['imageUrl'],
                                width: 100,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                              title: Text(
                                item['title'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                '\$${item['price'].toStringAsFixed(2)}',
                                style:
                                    const TextStyle(color: Color(0xFFFFC107)),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
              if (!isCartEmpty)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Subtotal:',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            '\$${total.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Cargo de Entrega:',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            '\$5.00',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '\$${(total + 5).toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CompraCompletada(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFC107),
                          foregroundColor: const Color(0xFF004170),
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 70),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        icon: const Icon(
                          Icons.shopping_cart,
                          color: Color(0xFF004170),
                        ),
                        label: const Text(
                          'Finalizar Compra',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
