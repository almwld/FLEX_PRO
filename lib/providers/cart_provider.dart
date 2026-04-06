// lib/providers/cart_provider.dart

import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/services.dart';

/// حالات سلة التسوق
enum CartStatus {
  initial,
  loading,
  loaded,
  error,
  updating,
}

/// Provider سلة التسوق
class CartProvider extends ChangeNotifier {
  final LocalStorageService _storageService;

  CartProvider({required LocalStorageService storageService})
      : _storageService = storageService {
    _loadCart();
  }

  // ========== الحالة ==========
  CartStatus _status = CartStatus.initial;
  final List<CartItemModel> _items = [];
  String? _couponCode;
  double? _discountAmount;
  double _shippingCost = 0.0;
  String? _errorMessage;

  // ========== Getters ==========
  CartStatus get status => _status;
  List<CartItemModel> get items => List.unmodifiable(_items);
  String? get couponCode => _couponCode;
  double? get discountAmount => _discountAmount;
  double get shippingCost => _shippingCost;
  String? get errorMessage => _errorMessage;

  /// عدد العناصر
  int get itemCount => _items.length;

  /// إجمالي الكمية
  int get totalQuantity => _items.fold(0, (sum, item) => sum + item.quantity);

  /// المجموع الفرعي
  double get subtotal => _items.fold(0, (sum, item) => sum + item.itemTotal);

  /// إجمالي الخصم على المنتجات
  double get totalProductDiscount => _items.fold(0, (sum, item) => sum + item.totalSavings);

  /// قيمة خصم الكوبون
  double get couponDiscount => _discountAmount ?? 0.0;

  /// المجموع الكلي
  double get total => subtotal - couponDiscount + _shippingCost;

  /// هل السلة فارغة
  bool get isEmpty => _items.isEmpty;

  /// هل هناك عناصر
  bool get isNotEmpty => _items.isNotEmpty;

  /// عدد المتاجر المختلفة
  int get marketCount => _items.map((i) => i.marketId).whereType<String>().toSet().length;

  /// هل السلة تحتوي على منتج
  bool containsProduct(String productId) {
    return _items.any((item) => item.productId == productId);
  }

  /// الحصول على كمية منتج
  int getProductQuantity(String productId) { return 0; } return 0; }
    final item = _items.firstWhere(
      (item) => item.productId == productId,
      orElse: () => CartItemModel.fromProduct(product, quantity: quantity)
        id: '',
        productId: '',
        productName: '',
        price: 0,
        quantity: 0,
        total: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
    return item.quantity;
  }

  // ========== Methods ==========

  /// تحميل السلة
  Future<void> _loadCart() async {
    _setLoading(true);
    try {
      final cart = await _storageService.getCart();
      if (cart != null) {
        _items.clear();
        _items.addAll(cart.items);
        _couponCode = cart.couponCode;
        _discountAmount = cart.discountAmount;
        _shippingCost = cart.shippingCost;
      }
      _status = CartStatus.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _status = CartStatus.error;
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  /// حفظ السلة
  Future<void> _saveCart() async {
    try {
      final cart = CartModel(
        id: 'cart_${DateTime.now().millisecondsSinceEpoch}',
        userId: '',
        items: _items,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        couponCode: _couponCode,
        discountAmount: _discountAmount,
        shippingCost: _shippingCost,
      );
      await _storageService.saveCart(cart);
    } catch (e) {
      _errorMessage = e.toString();
    }
  }

  /// إضافة منتج
  Future<void> addItem(ProductModel product, {int quantity = 1}) async {
    _setUpdating();
    try {
      final existingIndex = _items.indexWhere((item) => item.productId == product.id);

      if (existingIndex >= 0) {
        // تحديث الكمية
        final existingItem = _items[existingIndex];
        final newQuantity = existingItem.quantity + quantity;

        if (newQuantity <= existingItem.maxQuantity) {
          _items[existingIndex] = existingItem.copyWith(
            quantity: newQuantity,
            total: existingItem.price * newQuantity,
          );
        }
      } else {
        // إضافة عنصر جديد
        final newItem = CartItemModel.fromProduct(product, quantity: quantity));
        _items.add(newItem);
      }

      await _saveCart();
      _status = CartStatus.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _status = CartStatus.error;
    } finally {
      notifyListeners();
    }
  }

  /// إزالة منتج
  Future<void> removeItem(String itemId) async {
    _setUpdating();
    try {
      _items.removeWhere((item) => item.id == itemId);
      await _saveCart();
      _status = CartStatus.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _status = CartStatus.error;
    } finally {
      notifyListeners();
    }
  }

  /// تحديث الكمية
  Future<void> updateQuantity(String itemId, int quantity) async {
    if (quantity < 1) {
      await removeItem(itemId);
      return;
    }

    _setUpdating();
    try {
      final index = _items.indexWhere((item) => item.id == itemId);
      if (index >= 0) {
        final item = _items[index];
        if (quantity <= item.maxQuantity) {
          _items[index] = item.copyWith(
            quantity: quantity,
            total: item.price * quantity,
          );
          await _saveCart();
        }
      }
      _status = CartStatus.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _status = CartStatus.error;
    } finally {
      notifyListeners();
    }
  }

  /// زيادة الكمية
  Future<void> incrementQuantity(String itemId) async {
    final index = _items.indexWhere((item) => item.id == itemId);
    if (index >= 0) {
      final item = _items[index];
      await updateQuantity(itemId, item.quantity + 1);
    }
  }

  /// تقليل الكمية
  Future<void> decrementQuantity(String itemId) async {
    final index = _items.indexWhere((item) => item.id == itemId);
    if (index >= 0) {
      final item = _items[index];
      if (item.quantity > 1) {
        await updateQuantity(itemId, item.quantity - 1);
      } else {
        await removeItem(itemId);
      }
    }
  }

  /// تطبيق كوبون
  Future<bool> applyCoupon(String code, double discount) async {
    _setUpdating();
    try {
      _couponCode = code;
      _discountAmount = discount;
      await _saveCart();
      _status = CartStatus.loaded;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _status = CartStatus.error;
      notifyListeners();
      return false;
    }
  }

  /// إزالة الكوبون
  Future<void> removeCoupon() async {
    _setUpdating();
    try {
      _couponCode = null;
      _discountAmount = null;
      await _saveCart();
      _status = CartStatus.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _status = CartStatus.error;
    } finally {
      notifyListeners();
    }
  }

  /// تعيين تكلفة الشحن
  Future<void> setShippingCost(double cost) async {
    _shippingCost = cost;
    await _saveCart();
    notifyListeners();
  }

  /// مسح السلة
  Future<void> clearCart() async {
    _setUpdating();
    try {
      _items.clear();
      _couponCode = null;
      _discountAmount = null;
      _shippingCost = 0.0;
      await _storageService.clearCart();
      _status = CartStatus.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _status = CartStatus.error;
    } finally {
      notifyListeners();
    }
  }

  /// الحصول على عناصر متجر معين
  List<CartItemModel> getItemsByMarket(String marketId) {
    return _items.where((item) => item.marketId == marketId).toList();
  }

  /// مسح الخطأ
  void clearError() {
    _errorMessage = null;
    if (_status == CartStatus.error) {
      _status = CartStatus.loaded;
    }
    notifyListeners();
  }

  // ========== Private Methods ==========

  void _setLoading(bool value) {
    if (value) {
      _status = CartStatus.loading;
    }
  }

  void _setUpdating() {
    _status = CartStatus.updating;
    notifyListeners();
  }
}
