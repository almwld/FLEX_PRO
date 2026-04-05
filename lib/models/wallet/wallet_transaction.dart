import 'package:flutter/material.dart';

enum TransactionType {
  deposit,
  withdrawal,
  transfer,
  payment,
  refund,
  fee,
  recharge,
  billPayment,
  giftCard,
  exchange,
}

enum TransactionStatus {
  pending,
  completed,
  failed,
  cancelled,
  refunded,
}

class WalletTransaction {
  final String id;
  final String walletId;
  final TransactionType type;
  final TransactionStatus status;
  final double amount;
  final String currency;
  final String? description;
  final String? recipientName;
  final String? recipientId;
  final String? recipientPhone;
  final String? recipientBank;
  final String? recipientAccount;
  final DateTime createdAt;
  final DateTime? completedAt;
  final String? referenceNumber;
  final String? qrCode;
  final Map<String, dynamic>? metadata;
  final double? fee;
  final double? exchangeRate;
  
  WalletTransaction({
    required this.id,
    required this.walletId,
    required this.type,
    required this.status,
    required this.amount,
    required this.currency,
    this.description,
    this.recipientName,
    this.recipientId,
    this.recipientPhone,
    this.recipientBank,
    this.recipientAccount,
    required this.createdAt,
    this.completedAt,
    this.referenceNumber,
    this.qrCode,
    this.metadata,
    this.fee,
    this.exchangeRate,
  });
  
  factory WalletTransaction.fromJson(Map<String, dynamic> json) {
    return WalletTransaction(
      id: json['id'] ?? '',
      walletId: json['wallet_id'] ?? '',
      type: TransactionType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => TransactionType.payment,
      ),
      status: TransactionStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => TransactionStatus.pending,
      ),
      amount: (json['amount'] ?? 0).toDouble(),
      currency: json['currency'] ?? 'YER',
      description: json['description'],
      recipientName: json['recipient_name'],
      recipientId: json['recipient_id'],
      recipientPhone: json['recipient_phone'],
      recipientBank: json['recipient_bank'],
      recipientAccount: json['recipient_account'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      completedAt: json['completed_at'] != null 
          ? DateTime.parse(json['completed_at']) 
          : null,
      referenceNumber: json['reference_number'],
      qrCode: json['qr_code'],
      metadata: json['metadata'],
      fee: json['fee']?.toDouble(),
      exchangeRate: json['exchange_rate']?.toDouble(),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'wallet_id': walletId,
      'type': type.name,
      'status': status.name,
      'amount': amount,
      'currency': currency,
      'description': description,
      'recipient_name': recipientName,
      'recipient_id': recipientId,
      'recipient_phone': recipientPhone,
      'recipient_bank': recipientBank,
      'recipient_account': recipientAccount,
      'created_at': createdAt.toIso8601String(),
      'completed_at': completedAt?.toIso8601String(),
      'reference_number': referenceNumber,
      'qr_code': qrCode,
      'metadata': metadata,
      'fee': fee,
      'exchange_rate': exchangeRate,
    };
  }
  
  // لون حالة المعاملة
  Color get statusColor {
    switch (status) {
      case TransactionStatus.completed:
        return const Color(0xFF00A15C);
      case TransactionStatus.pending:
        return const Color(0xFFFCD535);
      case TransactionStatus.failed:
        return const Color(0xFFE5493A);
      case TransactionStatus.cancelled:
        return Colors.grey;
      case TransactionStatus.refunded:
        return Colors.blue;
    }
  }
  
  // نص حالة المعاملة
  String get statusText {
    switch (status) {
      case TransactionStatus.completed:
        return 'مكتملة';
      case TransactionStatus.pending:
        return 'قيد المعالجة';
      case TransactionStatus.failed:
        return 'فاشلة';
      case TransactionStatus.cancelled:
        return 'ملغاة';
      case TransactionStatus.refunded:
        return 'مستردة';
    }
  }
  
  // أيقونة نوع المعاملة
  IconData get typeIcon {
    switch (type) {
      case TransactionType.deposit:
        return Icons.arrow_downward;
      case TransactionType.withdrawal:
        return Icons.arrow_upward;
      case TransactionType.transfer:
        return Icons.swap_horiz;
      case TransactionType.payment:
        return Icons.payment;
      case TransactionType.refund:
        return Icons.reply;
      case TransactionType.fee:
        return Icons.money_off;
      case TransactionType.recharge:
        return Icons.phone_android;
      case TransactionType.billPayment:
        return Icons.receipt;
      case TransactionType.giftCard:
        return Icons.card_giftcard;
      case TransactionType.exchange:
        return Icons.currency_exchange;
    }
  }
  
  // نص نوع المعاملة
  String get typeText {
    switch (type) {
      case TransactionType.deposit:
        return 'إيداع';
      case TransactionType.withdrawal:
        return 'سحب';
      case TransactionType.transfer:
        return 'تحويل';
      case TransactionType.payment:
        return 'دفع';
      case TransactionType.refund:
        return 'استرداد';
      case TransactionType.fee:
        return 'رسوم';
      case TransactionType.recharge:
        return 'شحن';
      case TransactionType.billPayment:
        return 'دفع فاتورة';
      case TransactionType.giftCard:
        return 'بطاقة هدايا';
      case TransactionType.exchange:
        return 'تحويل عملة';
    }
  }
  
  // هل المعاملة واردة
  bool get isIncoming {
    return type == TransactionType.deposit || 
           type == TransactionType.refund ||
           (type == TransactionType.transfer && metadata?['direction'] == 'incoming');
  }
  
  // إجمالي المبلغ مع الرسوم
  double get totalAmount {
    return amount + (fee ?? 0);
  }
  
  // تنسيق المبلغ
  String get formattedAmount {
    final symbol = _getCurrencySymbol(currency);
    return '${isIncoming ? '+' : '-'} ${amount.toStringAsFixed(0)} $symbol';
  }
  
  String _getCurrencySymbol(String currency) {
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
  
  // تاريخ منسق
  String get formattedDate {
    final now = DateTime.now();
    final diff = now.difference(createdAt);
    
    if (diff.inDays == 0) {
      if (diff.inHours == 0) {
        if (diff.inMinutes == 0) {
          return 'الآن';
        }
        return 'منذ ${diff.inMinutes} دقيقة';
      }
      return 'منذ ${diff.inHours} ساعة';
    } else if (diff.inDays == 1) {
      return 'أمس';
    } else if (diff.inDays < 7) {
      return 'منذ ${diff.inDays} أيام';
    } else {
      return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
    }
  }
  
  WalletTransaction copyWith({
    String? id,
    String? walletId,
    TransactionType? type,
    TransactionStatus? status,
    double? amount,
    String? currency,
    String? description,
    String? recipientName,
    String? recipientId,
    String? recipientPhone,
    String? recipientBank,
    String? recipientAccount,
    DateTime? createdAt,
    DateTime? completedAt,
    String? referenceNumber,
    String? qrCode,
    Map<String, dynamic>? metadata,
    double? fee,
    double? exchangeRate,
  }) {
    return WalletTransaction(
      id: id ?? this.id,
      walletId: walletId ?? this.walletId,
      type: type ?? this.type,
      status: status ?? this.status,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      description: description ?? this.description,
      recipientName: recipientName ?? this.recipientName,
      recipientId: recipientId ?? this.recipientId,
      recipientPhone: recipientPhone ?? this.recipientPhone,
      recipientBank: recipientBank ?? this.recipientBank,
      recipientAccount: recipientAccount ?? this.recipientAccount,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      qrCode: qrCode ?? this.qrCode,
      metadata: metadata ?? this.metadata,
      fee: fee ?? this.fee,
      exchangeRate: exchangeRate ?? this.exchangeRate,
    );
  }
}
