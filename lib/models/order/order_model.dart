import 'package:flutter/material.dart';

enum OrderStatus {
  pending,
  confirmed,
  processing,
  shipped,
  delivered,
  cancelled,
  refunded,
}

class OrderModel {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final double subtotal;
  final double shippingCost;
  final double tax;
  final double discount;
  final double total;
  final String currency;
  final OrderStatus status;
  final String? shippingAddress;
  final String? shippingCity;
  final String? shippingPhone;
  final String? shippingCompany;
  final String? trackingNumber;
  final DateTime createdAt;
  final DateTime? confirmedAt;
  final DateTime? shippedAt;
  final DateTime? deliveredAt;
  final String? paymentMethod;
  final String? paymentStatus;
  final String? notes;
  final String? cancelReason;
  final List<OrderStatusUpdate>? statusHistory;
  
  OrderModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.subtotal,
    required this.shippingCost,
    required this.tax,
    this.discount = 0,
    required this.total,
    this.currency = 'YER',
    required this.status,
    this.shippingAddress,
    this.shippingCity,
    this.shippingPhone,
    this.shippingCompany,
    this.trackingNumber,
    required this.createdAt,
    this.confirmedAt,
    this.shippedAt,
    this.deliveredAt,
    this.paymentMethod,
    this.paymentStatus,
    this.notes,
    this.cancelReason,
    this.statusHistory,
  });
  
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      items: (json['items'] as List?)
          ?.map((e) => OrderItem.fromJson(e))
          .toList() ?? [],
      subtotal: (json['subtotal'] ?? 0).toDouble(),
      shippingCost: (json['shipping_cost'] ?? 0).toDouble(),
      tax: (json['tax'] ?? 0).toDouble(),
      discount: (json['discount'] ?? 0).toDouble(),
      total: (json['total'] ?? 0).toDouble(),
      currency: json['currency'] ?? 'YER',
      status: OrderStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => OrderStatus.pending,
      ),
      shippingAddress: json['shipping_address'],
      shippingCity: json['shipping_city'],
      shippingPhone: json['shipping_phone'],
      shippingCompany: json['shipping_company'],
      trackingNumber: json['tracking_number'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      confirmedAt: json['confirmed_at'] != null 
          ? DateTime.parse(json['confirmed_at']) 
          : null,
      shippedAt: json['shipped_at'] != null 
          ? DateTime.parse(json['shipped_at']) 
          : null,
      deliveredAt: json['delivered_at'] != null 
          ? DateTime.parse(json['delivered_at']) 
          : null,
      paymentMethod: json['payment_method'],
      paymentStatus: json['payment_status'],
      notes: json['notes'],
      cancelReason: json['cancel_reason'],
      statusHistory: json['status_history'] != null 
          ? (json['status_history'] as List).map((s) => OrderStatusUpdate.fromJson(s)).toList()
          : null,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'items': items.map((e) => e.toJson()).toList(),
      'subtotal': subtotal,
      'shipping_cost': shippingCost,
      'tax': tax,
      'discount': discount,
      'total': total,
      'currency': currency,
      'status': status.name,
      'shipping_address': shippingAddress,
      'shipping_city': shippingCity,
      'shipping_phone': shippingPhone,
      'shipping_company': shippingCompany,
      'tracking_number': trackingNumber,
      'created_at': createdAt.toIso8601String(),
      'confirmed_at': confirmedAt?.toIso8601String(),
      'shipped_at': shippedAt?.toIso8601String(),
      'delivered_at': deliveredAt?.toIso8601String(),
      'payment_method': paymentMethod,
      'payment_status': paymentStatus,
      'notes': notes,
      'cancel_reason': cancelReason,
      'status_history': statusHistory?.map((s) => s.toJson()).toList(),
    };
  }
  
  // نص حالة الطلب
  String get statusText {
    switch (status) {
      case OrderStatus.pending:
        return 'قيد المراجعة';
      case OrderStatus.confirmed:
        return 'تم التأكيد';
      case OrderStatus.processing:
        return 'جاري التجهيز';
      case OrderStatus.shipped:
        return 'تم الشحن';
      case OrderStatus.delivered:
        return 'تم التوصيل';
      case OrderStatus.cancelled:
        return 'ملغي';
      case OrderStatus.refunded:
        return 'مسترد';
    }
  }
  
  // لون حالة الطلب
  Color get statusColor {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.confirmed:
        return Colors.blue;
      case OrderStatus.processing:
        return Colors.indigo;
      case OrderStatus.shipped:
        return Colors.purple;
      case OrderStatus.delivered:
        return const Color(0xFF00A15C);
      case OrderStatus.cancelled:
        return const Color(0xFFE5493A);
      case OrderStatus.refunded:
        return Colors.teal;
    }
  }
  
  // أيقونة حالة الطلب
  IconData get statusIcon {
    switch (status) {
      case OrderStatus.pending:
        return Icons.hourglass_empty;
      case OrderStatus.confirmed:
        return Icons.check_circle;
      case OrderStatus.processing:
        return Icons.inventory;
      case OrderStatus.shipped:
        return Icons.local_shipping;
      case OrderStatus.delivered:
        return Icons.done_all;
      case OrderStatus.cancelled:
        return Icons.cancel;
      case OrderStatus.refunded:
        return Icons.reply;
    }
  }
  
  // هل الطلب قابل للإلغاء
  bool get canCancel {
    return status == OrderStatus.pending || status == OrderStatus.confirmed;
  }
  
  // هل الطلب قابل للإرجاع
  bool get canReturn {
    return status == OrderStatus.delivered;
  }
  
  // عدد المنتجات
  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);
  
  // تاريخ منسق
  String get formattedDate {
    return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
  }
  
  // رمز العملة
  String get currencySymbol {
    switch (currency) {
      case 'YER':
        return 'ر.ي';
      case 'SAR':
        return 'ر.س';
      case 'USD':
        return '\$';
      default:
        return currency;
    }
  }
  
  OrderModel copyWith({
    String? id,
    String? userId,
    List<OrderItem>? items,
    double? subtotal,
    double? shippingCost,
    double? tax,
    double? discount,
    double? total,
    String? currency,
    OrderStatus? status,
    String? shippingAddress,
    String? shippingCity,
    String? shippingPhone,
    String? shippingCompany,
    String? trackingNumber,
    DateTime? createdAt,
    DateTime? confirmedAt,
    DateTime? shippedAt,
    DateTime? deliveredAt,
    String? paymentMethod,
    String? paymentStatus,
    String? notes,
    String? cancelReason,
    List<OrderStatusUpdate>? statusHistory,
  }) {
    return OrderModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      shippingCost: shippingCost ?? this.shippingCost,
      tax: tax ?? this.tax,
      discount: discount ?? this.discount,
      total: total ?? this.total,
      currency: currency ?? this.currency,
      status: status ?? this.status,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      shippingCity: shippingCity ?? this.shippingCity,
      shippingPhone: shippingPhone ?? this.shippingPhone,
      shippingCompany: shippingCompany ?? this.shippingCompany,
      trackingNumber: trackingNumber ?? this.trackingNumber,
      createdAt: createdAt ?? this.createdAt,
      confirmedAt: confirmedAt ?? this.confirmedAt,
      shippedAt: shippedAt ?? this.shippedAt,
      deliveredAt: deliveredAt ?? this.deliveredAt,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      notes: notes ?? this.notes,
      cancelReason: cancelReason ?? this.cancelReason,
      statusHistory: statusHistory ?? this.statusHistory,
    );
  }
}

class OrderItem {
  final String id;
  final String productId;
  final String productName;
  final String? productImage;
  final double price;
  final int quantity;
  final String? variant;
  final double? discount;
  
  OrderItem({
    required this.id,
    required this.productId,
    required this.productName,
    this.productImage,
    required this.price,
    required this.quantity,
    this.variant,
    this.discount,
  });
  
  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'] ?? '',
      productId: json['product_id'] ?? '',
      productName: json['product_name'] ?? '',
      productImage: json['product_image'],
      price: (json['price'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 1,
      variant: json['variant'],
      discount: json['discount']?.toDouble(),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'product_name': productName,
      'product_image': productImage,
      'price': price,
      'quantity': quantity,
      'variant': variant,
      'discount': discount,
    };
  }
  
  // الإجمالي
  double get total {
    final totalPrice = price * quantity;
    if (discount != null && discount! > 0) {
      return totalPrice - (totalPrice * discount! / 100);
    }
    return totalPrice;
  }
  
  OrderItem copyWith({
    String? id,
    String? productId,
    String? productName,
    String? productImage,
    double? price,
    int? quantity,
    String? variant,
    double? discount,
  }) {
    return OrderItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      variant: variant ?? this.variant,
      discount: discount ?? this.discount,
    );
  }
}

class OrderStatusUpdate {
  final OrderStatus status;
  final DateTime timestamp;
  final String? note;
  final String? updatedBy;
  
  OrderStatusUpdate({
    required this.status,
    required this.timestamp,
    this.note,
    this.updatedBy,
  });
  
  factory OrderStatusUpdate.fromJson(Map<String, dynamic> json) {
    return OrderStatusUpdate(
      status: OrderStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => OrderStatus.pending,
      ),
      timestamp: DateTime.parse(json['timestamp'] ?? DateTime.now().toIso8601String()),
      note: json['note'],
      updatedBy: json['updated_by'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'status': status.name,
      'timestamp': timestamp.toIso8601String(),
      'note': note,
      'updated_by': updatedBy,
    };
  }
}

// Sample orders
final List<OrderModel> sampleOrders = [
  OrderModel(
    id: 'ORD-001',
    userId: '1',
    items: [
      OrderItem(
        id: 'ITEM-001',
        productId: '1',
        productName: 'آيفون 15 برو ماكس',
        productImage: 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400',
        price: 450000,
        quantity: 1,
      ),
    ],
    subtotal: 450000,
    shippingCost: 5000,
    tax: 0,
    total: 455000,
    status: OrderStatus.delivered,
    shippingAddress: 'شارع حدة، مبنى رقم 10',
    shippingCity: 'صنعاء',
    shippingPhone: '777123456',
    shippingCompany: 'سبيدكس',
    trackingNumber: 'SPX123456789',
    createdAt: DateTime.now().subtract(const Duration(days: 10)),
    confirmedAt: DateTime.now().subtract(const Duration(days: 9)),
    shippedAt: DateTime.now().subtract(const Duration(days: 7)),
    deliveredAt: DateTime.now().subtract(const Duration(days: 5)),
    paymentMethod: 'محفظة فلكس',
  ),
  OrderModel(
    id: 'ORD-002',
    userId: '1',
    items: [
      OrderItem(
        id: 'ITEM-002',
        productId: '2',
        productName: 'سامسونج S24 الترا',
        productImage: 'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=400',
        price: 380000,
        quantity: 1,
      ),
      OrderItem(
        id: 'ITEM-003',
        productId: '6',
        productName: 'ساعة أبل واتش الترا 2',
        productImage: 'https://images.unsplash.com/photo-1434493789847-2f02dc6ca35d?w=400',
        price: 180000,
        quantity: 1,
      ),
    ],
    subtotal: 560000,
    shippingCost: 0,
    tax: 0,
    discount: 10000,
    total: 550000,
    status: OrderStatus.shipped,
    shippingAddress: 'شارع التحرير، برج فلكس',
    shippingCity: 'صنعاء',
    shippingPhone: '777123456',
    shippingCompany: 'يمن إكسبرس',
    trackingNumber: 'YEX987654321',
    createdAt: DateTime.now().subtract(const Duration(days: 3)),
    confirmedAt: DateTime.now().subtract(const Duration(days: 2)),
    shippedAt: DateTime.now().subtract(const Duration(hours: 12)),
    paymentMethod: 'بطاقة بنكية',
  ),
  OrderModel(
    id: 'ORD-003',
    userId: '1',
    items: [
      OrderItem(
        id: 'ITEM-004',
        productId: '5',
        productName: 'شقة فاخرة في حدة',
        productImage: 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=400',
        price: 35000000,
        quantity: 1,
      ),
    ],
    subtotal: 35000000,
    shippingCost: 0,
    tax: 0,
    total: 35000000,
    status: OrderStatus.pending,
    shippingAddress: 'شارع حدة، مبنى رقم 10',
    shippingCity: 'صنعاء',
    shippingPhone: '777123456',
    createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    paymentMethod: 'تحويل بنكي',
  ),
];
