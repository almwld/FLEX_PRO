// lib/providers/order_provider.dart

import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/services.dart';

/// حالات الطلبات
enum OrderStatusState {
  initial,
  loading,
  loaded,
  error,
  creating,
  updating,
}

/// Provider الطلبات
class OrderProvider extends ChangeNotifier {
  final OrderService _orderService;

  OrderProvider({required OrderService orderService})
      : _orderService = orderService;

  // ========== الحالة ==========
  OrderStatusState _status = OrderStatusState.initial;
  List<OrderModel> _orders = [];
  OrderModel? _selectedOrder;
  List<OrderModel> _pendingOrders = [];
  List<OrderModel> _activeOrders = [];
  List<OrderModel> _completedOrders = [];
  String? _errorMessage;
  bool _isLoadingMore = false;
  int _currentPage = 1;
  bool _hasMore = true;

  // ========== Getters ==========
  OrderStatusState get status => _status;
  List<OrderModel> get orders => _orders;
  OrderModel? get selectedOrder => _selectedOrder;
  List<OrderModel> get pendingOrders => _pendingOrders;
  List<OrderModel> get activeOrders => _activeOrders;
  List<OrderModel> get completedOrders => _completedOrders;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _status == OrderStatusState.loading;
  bool get isCreating => _status == OrderStatusState.creating;
  bool get isLoadingMore => _isLoadingMore;
  bool get hasMore => _hasMore;

  /// عدد الطلبات
  int get orderCount => _orders.length;

  /// عدد الطلبات النشطة
  int get activeOrderCount => _activeOrders.length;

  /// عدد الطلبات المعلقة
  int get pendingOrderCount => _pendingOrders.length;

  // ========== Methods ==========

  /// تحميل الطلبات
  Future<void> loadOrders({
    bool refresh = false,
    int page = 1,
    int limit = 20,
    OrderStatus? status,
  }) async {
    if (refresh) {
      _currentPage = 1;
      _orders = [];
      _hasMore = true;
    }

    if (page > 1) {
      _isLoadingMore = true;
    } else {
      _status = OrderStatusState.loading;
    }

    _clearError();
    notifyListeners();

    try {
      final orders = await _orderService.getOrders(
        page: page,
        limit: limit,
        status: status,
      );

      if (orders.isNotEmpty) {
        if (page == 1) {
          _orders = orders;
        } else {
          _orders.addAll(orders);
        }
        _currentPage++;
        _hasMore = orders.length >= limit;
      } else {
        _hasMore = false;
      }

      _status = OrderStatusState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _status = OrderStatusState.error;
    } finally {
      _isLoadingMore = false;
      notifyListeners();
    }
  }

  /// تحميل المزيد من الطلبات
  Future<void> loadMoreOrders() async {
    if (_isLoadingMore || !_hasMore) return;
    await loadOrders(page: _currentPage);
  }

  /// تحميل تفاصيل طلب
  Future<void> loadOrderDetails(String orderId) async {
    _status = OrderStatusState.loading;
    _clearError();
    notifyListeners();

    try {
      _selectedOrder = await _orderService.getOrderDetails(orderId);
      _status = OrderStatusState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _status = OrderStatusState.error;
    } finally {
      notifyListeners();
    }
  }

  /// إنشاء طلب جديد
  Future<OrderModel?> createOrder({
    required List<CartItemModel> items,
    required AddressModel address,
    required PaymentMethod paymentMethod,
    String? couponCode,
    String? notes,
  }) async {
    _status = OrderStatusState.creating;
    _clearError();
    notifyListeners();

    try {
      final order = await _orderService.createOrder(
        items: items,
        address: address,
        paymentMethod: paymentMethod,
        couponCode: couponCode,
        notes: notes,
      );

      if (order != null) {
        _orders.insert(0, order);
        _status = OrderStatusState.loaded;
        notifyListeners();
        return order;
      }
      return null;
    } catch (e) {
      _errorMessage = e.toString();
      _status = OrderStatusState.error;
      notifyListeners();
      return null;
    }
  }

  /// إلغاء طلب
  Future<bool> cancelOrder(String orderId, {String? reason}) async {
    _status = OrderStatusState.updating;
    _clearError();
    notifyListeners();

    try {
      final result = await _orderService.cancelOrder(orderId, reason: reason);

      if (result) {
        // تحديث الطلب في القائمة
        final index = _orders.indexWhere((o) => o.id == orderId);
        if (index >= 0) {
          _orders[index] = _orders[index].copyWith(
            status: OrderStatus.cancelled,
            cancellationReason: reason,
          );
        }

        // تحديث الطلب المحدد
        if (_selectedOrder?.id == orderId) {
          _selectedOrder = _selectedOrder!.copyWith(
            status: OrderStatus.cancelled,
            cancellationReason: reason,
          );
        }

        _status = OrderStatusState.loaded;
        notifyListeners();
      }

      return result;
    } catch (e) {
      _errorMessage = e.toString();
      _status = OrderStatusState.error;
      notifyListeners();
      return false;
    }
  }

  /// إعادة طلب
  Future<bool> reorder(String orderId) async {
    _status = OrderStatusState.updating;
    _clearError();
    notifyListeners();

    try {
      final result = await _orderService.reorder(orderId);
      _status = OrderStatusState.loaded;
      notifyListeners();
      return result;
    } catch (e) {
      _errorMessage = e.toString();
      _status = OrderStatusState.error;
      notifyListeners();
      return false;
    }
  }

  /// تحميل الطلبات حسب الحالة
  Future<void> loadOrdersByStatus(OrderStatus status) async {
    _status = OrderStatusState.loading;
    _clearError();
    notifyListeners();

    try {
      final orders = await _orderService.getOrdersByStatus(status);

      switch (status) {
        case OrderStatus.pending:
          _pendingOrders = orders;
          break;
        case OrderStatus.processing:
        case OrderStatus.shipped:
          _activeOrders = orders;
          break;
        case OrderStatus.delivered:
        case OrderStatus.completed:
          _completedOrders = orders;
          break;
        default:
          break;
      }

      _status = OrderStatusState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _status = OrderStatusState.error;
    } finally {
      notifyListeners();
    }
  }

  /// تتبع طلب
  Future<List<OrderTracking>> trackOrder(String orderId) async {
    try {
      return await _orderService.trackOrder(orderId);
    } catch (e) {
      _errorMessage = e.toString();
      return [];
    }
  }

  /// إضافة تقييم
  Future<bool> addReview({
    required String orderId,
    required String productId,
    required double rating,
    required String comment,
    List<String>? images,
  }) async {
    _status = OrderStatusState.updating;
    _clearError();
    notifyListeners();

    try {
      final result = await _orderService.addReview(
        orderId: orderId,
        productId: productId,
        rating: rating,
        comment: comment,
        images: images,
      );

      _status = OrderStatusState.loaded;
      notifyListeners();
      return result;
    } catch (e) {
      _errorMessage = e.toString();
      _status = OrderStatusState.error;
      notifyListeners();
      return false;
    }
  }

  /// مسح الطلب المحدد
  void clearSelectedOrder() {
    _selectedOrder = null;
    notifyListeners();
  }

  /// مسح الخطأ
  void clearError() {
    _clearError();
    notifyListeners();
  }

  /// إعادة تعيين
  void reset() {
    _status = OrderStatusState.initial;
    _orders = [];
    _selectedOrder = null;
    _pendingOrders = [];
    _activeOrders = [];
    _completedOrders = [];
    _errorMessage = null;
    _hasMore = true;
    _currentPage = 1;
    notifyListeners();
  }

  // ========== Private Methods ==========

  void _clearError() {
    _errorMessage = null;
  }
}
