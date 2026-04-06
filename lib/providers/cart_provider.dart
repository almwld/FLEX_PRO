import 'package:flutter/material.dart';
import '../models/cart_model.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItemModel> _items = [];
  
  List<CartItemModel> get items => List.unmodifiable(_items);
  int get itemCount => _items.length;
  double get total => _items.fold(0, (sum, item) => sum + item.total);
  
  void addItem(CartItemModel item) {
    _items.add(item);
    notifyListeners();
  }
  
  void removeItem(String itemId) {
    _items.removeWhere((item) => item.id == itemId);
    notifyListeners();
  }
  
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
  
  int getProductQuantity(String productId) {
    return _items.where((item) => item.productId == productId).fold(0, (sum, item) => sum + item.quantity);
  }
}
