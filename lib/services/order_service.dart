// lib/services/order_service.dart

import '../models/models.dart';

/// خدمة الطلبات
class OrderService {
  static final OrderService _instance = OrderService._internal();
  factory OrderService() => _instance;
  OrderService._internal();

  // ========== الطلبات ==========

  /// الحصول على الطلبات
  Future<List<OrderModel>> getOrders({
    int page = 1,
    int limit = 20,
    OrderStatus? status,
  }) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(milliseconds: 500));

    return List.generate(
      limit,
      (index) => OrderModel(
        id: 'order_${page}_$index',
        userId: 'user_1',
        orderNumber: 'ORD-${DateTime.now().year}-${1000 + index}',
        status: status ?? OrderStatus.values[index % OrderStatus.values.length],
        items: [
          OrderItemModel(
            id: 'item_$index',
            productId: 'prod_$index',
            productName: 'منتج $index',
            productImage: 'https://via.placeholder.com/100',
            price: (index + 1) * 1000.0,
            quantity: index + 1,
            total: (index + 1) * 1000.0 * (index + 1),
          ),
        ],
        subtotal: (index + 1) * 1000.0,
        shippingCost: 1000,
        discount: index % 3 == 0 ? 500 : 0,
        total: (index + 1) * 1000.0 + 1000 - (index % 3 == 0 ? 500 : 0),
        shippingAddress: AddressModel(
          id: 'addr_1',
          userId: 'user_1',
          name: 'محمد أحمد',
          phone: '+967777123456',
          city: 'صنعاء',
          street: 'شارع تعز',
          createdAt: DateTime.now(),
        ),
        paymentMethod: PaymentMethod.wallet,
        createdAt: DateTime.now().subtract(Duration(days: index)),
      ),
    );
  }

  /// الحصول على طلبات حسب الحالة
  Future<List<OrderModel>> getOrdersByStatus(OrderStatus status) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(milliseconds: 500));

    return List.generate(
      5,
      (index) => OrderModel(
        id: 'order_${status.toString().split('.').last}_$index',
        userId: 'user_1',
        orderNumber: 'ORD-${DateTime.now().year}-${2000 + index}',
        status: status,
        items: [
          OrderItemModel(
            id: 'item_$index',
            productId: 'prod_$index',
            productName: 'منتج $index',
            productImage: 'https://via.placeholder.com/100',
            price: (index + 1) * 1000.0,
            quantity: 1,
            total: (index + 1) * 1000.0,
          ),
        ],
        subtotal: (index + 1) * 1000.0,
        shippingCost: 1000,
        discount: 0,
        total: (index + 1) * 1000.0 + 1000,
        shippingAddress: AddressModel(
          id: 'addr_1',
          userId: 'user_1',
          name: 'محمد أحمد',
          phone: '+967777123456',
          city: 'صنعاء',
          street: 'شارع تعز',
          createdAt: DateTime.now(),
        ),
        paymentMethod: PaymentMethod.wallet,
        createdAt: DateTime.now(),
      ),
    );
  }

  /// الحصول على تفاصيل طلب
  Future<OrderModel?> getOrderDetails(String orderId) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(milliseconds: 500));

    return OrderModel(
      id: orderId,
      userId: 'user_1',
      orderNumber: 'ORD-${DateTime.now().year}-9999',
      status: 'processing',
      items: [
        OrderItemModel(
          id: 'item_1',
          productId: 'prod_1',
          productName: 'منتج تجريبي 1',
          productImage: 'https://via.placeholder.com/100',
          price: 10000,
          quantity: 2,
          total: 20000,
        ),
        OrderItemModel(
          id: 'item_2',
          productId: 'prod_2',
          productName: 'منتج تجريبي 2',
          productImage: 'https://via.placeholder.com/100',
          price: 5000,
          quantity: 1,
          total: 5000,
        ),
      ],
      subtotal: 25000,
      shippingCost: 2000,
      discount: 1000,
      total: 26000,
      shippingAddress: AddressModel(
        id: 'addr_1',
        userId: 'user_1',
        name: 'محمد أحمد',
        phone: '+967777123456',
        city: 'صنعاء',
        district: 'التحرير',
        street: 'شارع تعز',
        building: '15',
        floor: '3',
        apartment: '5',
        createdAt: DateTime.now(),
      ),
      paymentMethod: PaymentMethod.wallet,
      notes: 'ملاحظات على الطلب',
      createdAt: DateTime.now(),
    );
  }

  /// إنشاء طلب
  Future<OrderModel?> createOrder({
    required List<CartItemModel> items,
    required AddressModel address,
    required PaymentMethod paymentMethod,
    String? couponCode,
    String? notes,
  }) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(seconds: 1));

    final subtotal = items.fold(0.0, (sum, item) => sum + item.itemTotal);
    final shippingCost = 2000.0;
    final discount = 0.0;

    return OrderModel(
      id: 'order_${DateTime.now().millisecondsSinceEpoch}',
      userId: 'user_1',
      orderNumber: 'ORD-${DateTime.now().year}-${DateTime.now().millisecondsSinceEpoch % 10000}',
      status: 'pending',
      items: items.map((item) => OrderItemModel(
        id: 'item_${item.id}',
        productId: item.productId,
        productName: item.productName,
        productImage: item.productImage,
        price: item.price,
        quantity: item.quantity,
        total: item.itemTotal,
      )).toList(),
      subtotal: subtotal,
      shippingCost: shippingCost,
      discount: discount,
      total: subtotal + shippingCost - discount,
      shippingAddress: address,
      paymentMethod: paymentMethod,
      couponCode: couponCode,
      notes: notes,
      createdAt: DateTime.now(),
    );
  }

  /// إلغاء طلب
  Future<bool> cancelOrder(String orderId, {String? reason}) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  /// إعادة طلب
  Future<bool> reorder(String orderId) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  /// تتبع طلب
  Future<List<OrderTracking>> trackOrder(String orderId) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      OrderTracking(
        id: 'track_1',
        orderId: orderId,
        status: 'pending',
        description: 'تم استلام الطلب',
        location: 'المستودع الرئيسي',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
      ),
      OrderTracking(
        id: 'track_2',
        orderId: orderId,
        status: 'processing',
        description: 'جاري معالجة الطلب',
        location: 'المستودع الرئيسي',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
      ),
      OrderTracking(
        id: 'track_3',
        orderId: orderId,
        status: 'shipped',
        description: 'تم شحن الطلب',
        location: 'مركز الشحن',
        timestamp: DateTime.now(),
      ),
    ];
  }

  /// إضافة تقييم
  Future<bool> addReview({
    required String orderId,
    required String productId,
    required double rating,
    required String comment,
    List<String>? images,
  }) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  /// الحصول على ملخص الطلبات
  Future<Map<String, dynamic>> getOrderSummary() async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(milliseconds: 300));

    return {
      'total': 50,
      'pending': 5,
      'processing': 3,
      'shipped': 2,
      'delivered': 30,
      'cancelled': 5,
      'returned': 5,
    };
  }
}
