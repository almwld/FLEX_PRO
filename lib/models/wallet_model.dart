import 'package:flutter/material.dart';

enum TransactionType { deposit, withdraw, transfer, payment, received, refund }
enum TransactionStatus { pending, completed, failed, cancelled }

class WalletTransaction {
  final String id;
  final String walletId;
  final String userId;
  final TransactionType type;
  final TransactionStatus status;
  final double amount;
  final double fee;
  final String currency;
  final DateTime createdAt;
  final String title;
  final String subtitle;

  WalletTransaction({
    required this.id,
    required this.walletId,
    required this.userId,
    required this.type,
    required this.status,
    required this.amount,
    required this.fee,
    required this.currency,
    required this.createdAt,
    required this.title,
    required this.subtitle,
  });
}

class OrderTracking {
  final String orderId;
  final String status;
  final String location;
  final DateTime timestamp;

  OrderTracking({
    required this.orderId,
    required this.status,
    required this.location,
    required this.timestamp,
  });
}
