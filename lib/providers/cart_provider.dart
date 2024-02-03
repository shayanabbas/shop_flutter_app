import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _cart = [];

  List<Map<String, dynamic>> get cart => _cart;

  void addToCart(Map<String, dynamic> item) {
    _cart.add(item);
    notifyListeners();
  }

  void removeFromCart(Map<String, dynamic> item) {
    _cart.remove(item);
    notifyListeners();
  }
}
