import 'package:flutter/material.dart';

enum TransactionType { deposit, withdraw, transfer, payment, received, refund, billPayment }
enum TransactionStatus { pending, processing, completed, failed, cancelled }

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
  final String? description;
  final String? recipientId;
  final String? paymentMethod;

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
    this.description,
    this.recipientId,
    this.paymentMethod,
  });

  bool get isIncoming => type == TransactionType.received || type == TransactionType.deposit;
  bool get isOutgoing => type == TransactionType.withdraw || type == TransactionType.transfer || type == TransactionType.payment;

  Color get transactionColor {
    if (isIncoming) return Colors.green;
    if (isOutgoing) return Colors.red;
    return Colors.orange;
  }

  IconData get transactionIcon {
    switch (type) {
      case TransactionType.deposit: return Icons.arrow_downward;
      case TransactionType.withdraw: return Icons.arrow_upward;
      case TransactionType.transfer: return Icons.swap_horiz;
      case TransactionType.payment: return Icons.payment;
      case TransactionType.received: return Icons.receipt;
      case TransactionType.refund: return Icons.refresh;
      case TransactionType.billPayment: return Icons.receipt_long;
    }
  }

  String get typeText {
    switch (type) {
      case TransactionType.deposit: return 'إيداع';
      case TransactionType.withdraw: return 'سحب';
      case TransactionType.transfer: return 'تحويل';
      case TransactionType.payment: return 'دفع';
      case TransactionType.received: return 'استلام';
      case TransactionType.refund: return 'استرداد';
      case TransactionType.billPayment: return 'دفع فاتورة';
    }
  }

  String get statusText {
    switch (status) {
      case TransactionStatus.pending: return 'قيد المعالجة';
      case TransactionStatus.processing: return 'جاري التنفيذ';
      case TransactionStatus.completed: return 'مكتمل';
      case TransactionStatus.failed: return 'فشل';
      case TransactionStatus.cancelled: return 'ملغي';
    }
  }
}
