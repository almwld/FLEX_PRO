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

class OrderTracking {
  final String id;
  final String orderId;
  final String status;
  final String location;
  final DateTime timestamp;

  OrderTracking({
    required this.id,
    required this.orderId,
    required this.status,
    required this.location,
    required this.timestamp,
  });
}

class WalletBalance {
  final double total;
  final double yerBalance;
  final double sarBalance;
  final double usdBalance;
  final double available;
  
  WalletBalance({
    required this.total,
    required this.yerBalance,
    required this.sarBalance,
    required this.usdBalance,
    this.available = 0,
  });
}

class BillModel {
  final String id;
  final String title;
  final double amount;
  final DateTime dueDate;
  final String? name;
  
  BillModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.dueDate,
    this.name,
  });
}

class GiftCardModel {
  final String id;
  final String code;
  final double amount;
  final bool isUsed;
  final String? currency;
  
  GiftCardModel({
    required this.id,
    required this.code,
    required this.amount,
    this.isUsed = false,
    this.currency,
  });
}

class PaymentMethod {
  final String id;
  final String name;
  final String type;
  
  PaymentMethod({required this.id, required this.name, required this.type});
  
  String toJson() => id;
}

class WalletStats {
  final double totalSpent;
  final double totalReceived;
  final int transactionCount;
  final int totalTransactions;
  
  WalletStats({
    required this.totalSpent,
    required this.totalReceived,
    required this.transactionCount,
    this.totalTransactions = 0,
  });
}

class WalletLimits {
  final double dailyLimit;
  final double monthlyLimit;
  final double perTransactionLimit;
  
  WalletLimits({
    required this.dailyLimit,
    required this.monthlyLimit,
    required this.perTransactionLimit,
  });
  
  static WalletLimits defaultLimits() => WalletLimits(
    dailyLimit: 100000,
    monthlyLimit: 1000000,
    perTransactionLimit: 50000,
  );
}

class WalletModel {
  final String id;
  final double balance;
  final String currency;
  final bool isActive;
  
  WalletModel({
    required this.id,
    required this.balance,
    required this.currency,
    this.isActive = true,
  });
}
