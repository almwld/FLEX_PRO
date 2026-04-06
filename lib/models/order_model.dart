import 'package:flutter/material.dart';

enum OrderStatus {
  pending,
  processing,
  confirmed,
  shipped,
  delivered,
  cancelled,
  completed,
}

class OrderModel {
  final String id;
  final String orderNumber;
  final String userId;
  final List<dynamic> items;
  final double subtotal;
  final double shippingCost;
  final double tax;
  final double discount;
  final double total;
  final OrderStatus status;
  final String shippingAddress;
  final String shippingCity;
  final String shippingPhone;
  final String paymentMethod;
  final String paymentMethodText;
  final String? trackingNumber;
  final String? cancellationReason;
  final DateTime createdAt;
  final DateTime? confirmedAt;
  final DateTime? shippedAt;
  final DateTime? deliveredAt;
  final String? notes;
  final String? couponCode;

  OrderModel({
    required this.id,
    required this.orderNumber,
    required this.userId,
    required this.items,
    required this.subtotal,
    required this.shippingCost,
    required this.tax,
    required this.discount,
    required this.total,
    required this.status,
    required this.shippingAddress,
    required this.shippingCity,
    required this.shippingPhone,
    required this.paymentMethod,
    required this.paymentMethodText,
    this.trackingNumber,
    this.cancellationReason,
    required this.createdAt,
    this.confirmedAt,
    this.shippedAt,
    this.deliveredAt,
    this.notes,
    this.couponCode, this.updatedAt,
  });

  Color get statusColor {
    switch (status) {
      case OrderStatus.pending: return Colors.orange;
      case OrderStatus.processing: return Colors.blue;
      case OrderStatus.confirmed: return Colors.green;
      case OrderStatus.shipped: return Colors.purple;
      case OrderStatus.delivered: return Colors.teal;
      case OrderStatus.cancelled: return Colors.red;
      case OrderStatus.completed: return Colors.green;
    }
  }

  String get statusText {
    switch (status) {
      case OrderStatus.pending: return 'قيد المراجعة';
      case OrderStatus.processing: return 'جاري التجهيز';
      case OrderStatus.confirmed: return 'تم التأكيد';
      case OrderStatus.shipped: return 'تم الشحن';
      case OrderStatus.delivered: return 'تم التوصيل';
      case OrderStatus.cancelled: return 'ملغي';
      case OrderStatus.completed: return 'مكتمل';
    }
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? '',
      orderNumber: json['orderNumber'] ?? '',
      userId: json['userId'] ?? '',
      items: json['items'] ?? [],
      subtotal: (json['subtotal'] ?? 0).toDouble(),
      shippingCost: (json['shippingCost'] ?? 0).toDouble(),
      tax: (json['tax'] ?? 0).toDouble(),
      discount: (json['discount'] ?? 0).toDouble(),
      total: (json['total'] ?? 0).toDouble(),
      status: OrderStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => OrderStatus.pending,
      ),
      shippingAddress: json['shippingAddress'] ?? '',
      shippingCity: json['shippingCity'] ?? '',
      shippingPhone: json['shippingPhone'] ?? '',
      paymentMethod: json['paymentMethod'] ?? '',
      paymentMethodText: json['paymentMethodText'] ?? '',
      trackingNumber: json['trackingNumber'],
      cancellationReason: json['cancellationReason'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
      confirmedAt: json['confirmedAt'] != null ? DateTime.parse(json['confirmedAt']) : null,
      shippedAt: json['shippedAt'] != null ? DateTime.parse(json['shippedAt']) : null,
      deliveredAt: json['deliveredAt'] != null ? DateTime.parse(json['deliveredAt']) : null,
      notes: json['notes'],
      couponCode: json['couponCode'],
    );
  }

  OrderModel copyWith({
    OrderStatus? status,
    String? cancellationReason,
  }) {
    return OrderModel(
      id: id,
      orderNumber: orderNumber,
      userId: userId,
      items: items,
      subtotal: subtotal,
      shippingCost: shippingCost,
      tax: tax,
      discount: discount,
      total: total,
      status: status ?? this.status,
      shippingAddress: shippingAddress,
      shippingCity: shippingCity,
      shippingPhone: shippingPhone,
      paymentMethod: paymentMethod,
      paymentMethodText: paymentMethodText,
      trackingNumber: trackingNumber,
      cancellationReason: cancellationReason ?? this.cancellationReason,
      createdAt: createdAt,
      confirmedAt: confirmedAt,
      shippedAt: shippedAt,
      deliveredAt: deliveredAt,
      notes: notes,
      couponCode: couponCode,
    );
  }
}

  final DateTime? updatedAt;
  
  // إضافة updatedAt إلى constructor الحالي
