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
  });

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
      paymentMethodText: json['paymentMethodText'] ?? json['paymentMethod'] ?? '',
      trackingNumber: json['trackingNumber'],
      cancellationReason: json['cancellationReason'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
      confirmedAt: json['confirmedAt'] != null ? DateTime.parse(json['confirmedAt']) : null,
      shippedAt: json['shippedAt'] != null ? DateTime.parse(json['shippedAt']) : null,
      deliveredAt: json['deliveredAt'] != null ? DateTime.parse(json['deliveredAt']) : null,
    );
  }
}
