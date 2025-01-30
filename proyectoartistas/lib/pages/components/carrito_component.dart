import 'package:flutter/foundation.dart';

class CartProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];

  // Getter to access cart items
  List<Map<String, dynamic>> get items => _items;

  // Method to add an item
  void addItem(Map<String, dynamic> item) {
    _items.add(item);
    notifyListeners(); // Notify listeners of changes
  }

  // Method to remove an item
  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  // Method to clear the cart
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
