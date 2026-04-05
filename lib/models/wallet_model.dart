// lib/models/wallet_model.dart

import 'package:flutter/material.dart';

/// أنواع المعاملات المالية
enum TransactionType {
  deposit,      // إيداع
  withdraw,     // سحب
  transfer,     // تحويل
  payment,      // دفع
  refund,       // استرداد
  fee,          // رسوم
  bonus,        // مكافأة
  billPayment,  // دفع فاتورة
  giftCard,     // بطاقة هدايا
  exchange,     // صرف عملة
}

/// حالات المعاملة
enum TransactionStatus {
  pending,      // معلقة
  completed,    // مكتملة
  failed,       // فاشلة
  cancelled,    // ملغاة
  processing,   // قيد المعالجة
}

/// طرق الدفع
enum PaymentMethod {
  wallet,           // محفظة
  bankCard,         // بطاقة بنكية
  bankTransfer,     // تحويل بنكي
  cash,             // نقدي
  mobileMoney,      // محفظة جوال
  crypto,           // عملة رقمية
}

/// فئات الفواتير
enum BillCategory {
  electricity,  // كهرباء
  water,        // ماء
  internet,     // إنترنت
  phone,        // هاتف
  gas,          // غاز
  tv,           // تلفزيون
  education,    // تعليم
  government,   // حكومة
  other,        // أخرى
}

/// نموذج المحفظة الرئيسي
class WalletModel {
  final String id;
  final String userId;
  final double balance;
  final double frozenBalance;
  final String currency;
  final bool isActive;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<WalletTransaction> recentTransactions;
  final WalletLimits limits;
  final WalletStats stats;

  WalletModel({
    required this.id,
    required this.userId,
    this.balance = 0.0,
    this.frozenBalance = 0.0,
    this.currency = 'YER',
    this.isActive = true,
    this.isVerified = false,
    required this.createdAt,
    required this.updatedAt,
    this.recentTransactions = const [],
    required this.limits,
    required this.stats,
  });

  /// الرصيد المتاح
  double get availableBalance => balance - frozenBalance;

  /// هل الرصيد كافٍ
  bool hasSufficientBalance(double amount) => availableBalance >= amount;

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      balance: (json['balance'] ?? 0.0).toDouble(),
      frozenBalance: (json['frozenBalance'] ?? 0.0).toDouble(),
      currency: json['currency'] ?? 'YER',
      isActive: json['isActive'] ?? true,
      isVerified: json['isVerified'] ?? false,
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt']) 
          : DateTime.now(),
      recentTransactions: json['recentTransactions'] != null
          ? (json['recentTransactions'] as List)
              .map((t) => WalletTransaction.fromJson(t))
              .toList()
          : [],
      limits: json['limits'] != null
          ? WalletLimits.fromJson(json['limits'])
          : WalletLimits.defaultLimits(),
      stats: json['stats'] != null
          ? WalletStats.fromJson(json['stats'])
          : WalletStats.empty(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'balance': balance,
      'frozenBalance': frozenBalance,
      'currency': currency,
      'isActive': isActive,
      'isVerified': isVerified,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'recentTransactions': recentTransactions.map((t) => t.toJson()).toList(),
      'limits': limits.toJson(),
      'stats': stats.toJson(),
    };
  }

  WalletModel copyWith({
    String? id,
    String? userId,
    double? balance,
    double? frozenBalance,
    String? currency,
    bool? isActive,
    bool? isVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<WalletTransaction>? recentTransactions,
    WalletLimits? limits,
    WalletStats? stats,
  }) {
    return WalletModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      balance: balance ?? this.balance,
      frozenBalance: frozenBalance ?? this.frozenBalance,
      currency: currency ?? this.currency,
      isActive: isActive ?? this.isActive,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      recentTransactions: recentTransactions ?? this.recentTransactions,
      limits: limits ?? this.limits,
      stats: stats ?? this.stats,
    );
  }
}

/// نموذج رصيد المحفظة
class WalletBalance {
  final double total;
  final double available;
  final double frozen;
  final double pending;
  final String currency;

  WalletBalance({
    required this.total,
    required this.available,
    required this.frozen,
    required this.pending,
    required this.currency,
  });

  factory WalletBalance.fromJson(Map<String, dynamic> json) {
    return WalletBalance(
      total: (json['total'] ?? 0.0).toDouble(),
      available: (json['available'] ?? 0.0).toDouble(),
      frozen: (json['frozen'] ?? 0.0).toDouble(),
      pending: (json['pending'] ?? 0.0).toDouble(),
      currency: json['currency'] ?? 'YER',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'available': available,
      'frozen': frozen,
      'pending': pending,
      'currency': currency,
    };
  }
}

/// نموذج معاملة مالية
class WalletTransaction {
  final String id;
  final String walletId;
  final String? recipientWalletId;
  final String userId;
  final String? recipientId;
  final TransactionType type;
  final TransactionStatus status;
  final double amount;
  final double fee;
  final String currency;
  final String? description;
  final String? reference;
  final PaymentMethod? paymentMethod;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime? completedAt;
  final String? failureReason;
  final String? icon;
  final String? title;
  final String? subtitle;
  final bool isRead;

  WalletTransaction({
    required this.id,
    required this.walletId,
    this.recipientWalletId,
    required this.userId,
    this.recipientId,
    required this.type,
    required this.status,
    required this.amount,
    this.fee = 0.0,
    required this.currency,
    this.description,
    this.reference,
    this.paymentMethod,
    this.metadata,
    required this.createdAt,
    this.completedAt,
    this.failureReason,
    this.icon,
    this.title,
    this.subtitle,
    this.isRead = false,
  });

  /// المبلغ الإجمالي (المبلغ + الرسوم)
  double get totalAmount => amount + fee;

  /// هل المعاملة واردة
  bool get isIncoming {
    return type == TransactionType.deposit ||
           type == TransactionType.refund ||
           type == TransactionType.bonus;
  }

  /// هل المعاملة صادرة
  bool get isOutgoing {
    return type == TransactionType.withdraw ||
           type == TransactionType.payment ||
           type == TransactionType.fee ||
           type == TransactionType.transfer ||
           type == TransactionType.billPayment ||
           type == TransactionType.giftCard;
  }

  /// لون المعاملة
  Color get transactionColor {
    if (isIncoming) return Colors.green;
    if (isOutgoing) return Colors.red;
    return Colors.grey;
  }

  /// أيقونة المعاملة
  IconData get transactionIcon {
    switch (type) {
      case TransactionType.deposit:
        return Icons.arrow_downward;
      case TransactionType.withdraw:
        return Icons.arrow_upward;
      case TransactionType.transfer:
        return Icons.swap_horiz;
      case TransactionType.payment:
        return Icons.payment;
      case TransactionType.refund:
        return Icons.replay;
      case TransactionType.fee:
        return Icons.money_off;
      case TransactionType.bonus:
        return Icons.card_giftcard;
      case TransactionType.billPayment:
        return Icons.receipt;
      case TransactionType.giftCard:
        return Icons.card_membership;
      case TransactionType.exchange:
        return Icons.currency_exchange;
    }
  }

  /// نص نوع المعاملة بالعربية
  String get typeText {
    switch (type) {
      case TransactionType.deposit:
        return 'إيداع';
      case TransactionType.withdraw:
        return 'سحب';
      case TransactionType.transfer:
        return 'تحويل';
      case TransactionType.payment:
        return 'دفع';
      case TransactionType.refund:
        return 'استرداد';
      case TransactionType.fee:
        return 'رسوم';
      case TransactionType.bonus:
        return 'مكافأة';
      case TransactionType.billPayment:
        return 'دفع فاتورة';
      case TransactionType.giftCard:
        return 'بطاقة هدايا';
      case TransactionType.exchange:
        return 'صرف عملة';
    }
  }

  /// نص حالة المعاملة بالعربية
  String get statusText {
    switch (status) {
      case TransactionStatus.pending:
        return 'معلقة';
      case TransactionStatus.completed:
        return 'مكتملة';
      case TransactionStatus.failed:
        return 'فاشلة';
      case TransactionStatus.cancelled:
        return 'ملغاة';
      case TransactionStatus.processing:
        return 'قيد المعالجة';
    }
  }

  factory WalletTransaction.fromJson(Map<String, dynamic> json) {
    return WalletTransaction(
      id: json['id'] ?? '',
      walletId: json['walletId'] ?? '',
      recipientWalletId: json['recipientWalletId'],
      userId: json['userId'] ?? '',
      recipientId: json['recipientId'],
      type: TransactionType.values.firstWhere(
        (e) => e.toString() == 'TransactionType.${json['type']}',
        orElse: () => TransactionType.payment,
      ),
      status: TransactionStatus.values.firstWhere(
        (e) => e.toString() == 'TransactionStatus.${json['status']}',
        orElse: () => TransactionStatus.pending,
      ),
      amount: (json['amount'] ?? 0.0).toDouble(),
      fee: (json['fee'] ?? 0.0).toDouble(),
      currency: json['currency'] ?? 'YER',
      description: json['description'],
      reference: json['reference'],
      paymentMethod: json['paymentMethod'] != null
          ? PaymentMethod.values.firstWhere(
              (e) => e.toString() == 'PaymentMethod.${json['paymentMethod']}',
              orElse: () => PaymentMethod.wallet,
            )
          : null,
      metadata: json['metadata'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'])
          : null,
      failureReason: json['failureReason'],
      icon: json['icon'],
      title: json['title'],
      subtitle: json['subtitle'],
      isRead: json['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'walletId': walletId,
      'recipientWalletId': recipientWalletId,
      'userId': userId,
      'recipientId': recipientId,
      'type': type.toString().split('.').last,
      'status': status.toString().split('.').last,
      'amount': amount,
      'fee': fee,
      'currency': currency,
      'description': description,
      'reference': reference,
      'paymentMethod': paymentMethod?.toString().split('.').last,
      'metadata': metadata,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'failureReason': failureReason,
      'icon': icon,
      'title': title,
      'subtitle': subtitle,
      'isRead': isRead,
    };
  }

  WalletTransaction copyWith({
    String? id,
    String? walletId,
    String? recipientWalletId,
    String? userId,
    String? recipientId,
    TransactionType? type,
    TransactionStatus? status,
    double? amount,
    double? fee,
    String? currency,
    String? description,
    String? reference,
    PaymentMethod? paymentMethod,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
    DateTime? completedAt,
    String? failureReason,
    String? icon,
    String? title,
    String? subtitle,
    bool? isRead,
  }) {
    return WalletTransaction(
      id: id ?? this.id,
      walletId: walletId ?? this.walletId,
      recipientWalletId: recipientWalletId ?? this.recipientWalletId,
      userId: userId ?? this.userId,
      recipientId: recipientId ?? this.recipientId,
      type: type ?? this.type,
      status: status ?? this.status,
      amount: amount ?? this.amount,
      fee: fee ?? this.fee,
      currency: currency ?? this.currency,
      description: description ?? this.description,
      reference: reference ?? this.reference,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      metadata: metadata ?? this.metadata,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      failureReason: failureReason ?? this.failureReason,
      icon: icon ?? this.icon,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      isRead: isRead ?? this.isRead,
    );
  }
}

/// نموذج حدود المحفظة
class WalletLimits {
  final double dailyLimit;
  final double monthlyLimit;
  final double singleTransactionLimit;
  final double minTransactionAmount;
  final double maxBalance;

  WalletLimits({
    required this.dailyLimit,
    required this.monthlyLimit,
    required this.singleTransactionLimit,
    required this.minTransactionAmount,
    required this.maxBalance,
  });

  factory WalletLimits.defaultLimits() {
    return WalletLimits(
      dailyLimit: 100000,
      monthlyLimit: 1000000,
      singleTransactionLimit: 50000,
      minTransactionAmount: 100,
      maxBalance: 500000,
    );
  }

  factory WalletLimits.fromJson(Map<String, dynamic> json) {
    return WalletLimits(
      dailyLimit: (json['dailyLimit'] ?? 100000).toDouble(),
      monthlyLimit: (json['monthlyLimit'] ?? 1000000).toDouble(),
      singleTransactionLimit: (json['singleTransactionLimit'] ?? 50000).toDouble(),
      minTransactionAmount: (json['minTransactionAmount'] ?? 100).toDouble(),
      maxBalance: (json['maxBalance'] ?? 500000).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dailyLimit': dailyLimit,
      'monthlyLimit': monthlyLimit,
      'singleTransactionLimit': singleTransactionLimit,
      'minTransactionAmount': minTransactionAmount,
      'maxBalance': maxBalance,
    };
  }
}

/// نموذج إحصائيات المحفظة
class WalletStats {
  final int totalTransactions;
  final double totalDeposits;
  final double totalWithdrawals;
  final double totalPayments;
  final double totalFees;
  final DateTime lastActivity;

  WalletStats({
    required this.totalTransactions,
    required this.totalDeposits,
    required this.totalWithdrawals,
    required this.totalPayments,
    required this.totalFees,
    required this.lastActivity,
  });

  factory WalletStats.empty() {
    return WalletStats(
      totalTransactions: 0,
      totalDeposits: 0,
      totalWithdrawals: 0,
      totalPayments: 0,
      totalFees: 0,
      lastActivity: DateTime.now(),
    );
  }

  factory WalletStats.fromJson(Map<String, dynamic> json) {
    return WalletStats(
      totalTransactions: json['totalTransactions'] ?? 0,
      totalDeposits: (json['totalDeposits'] ?? 0.0).toDouble(),
      totalWithdrawals: (json['totalWithdrawals'] ?? 0.0).toDouble(),
      totalPayments: (json['totalPayments'] ?? 0.0).toDouble(),
      totalFees: (json['totalFees'] ?? 0.0).toDouble(),
      lastActivity: json['lastActivity'] != null
          ? DateTime.parse(json['lastActivity'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalTransactions': totalTransactions,
      'totalDeposits': totalDeposits,
      'totalWithdrawals': totalWithdrawals,
      'totalPayments': totalPayments,
      'totalFees': totalFees,
      'lastActivity': lastActivity.toIso8601String(),
    };
  }
}

/// نموذج فاتورة
class BillModel {
  final String id;
  final String name;
  final BillCategory category;
  final String accountNumber;
  final double amount;
  final DateTime dueDate;
  final bool isPaid;
  final DateTime? paidAt;
  final String? transactionId;
  final String provider;
  final String? description;

  BillModel({
    required this.id,
    required this.name,
    required this.category,
    required this.accountNumber,
    required this.amount,
    required this.dueDate,
    this.isPaid = false,
    this.paidAt,
    this.transactionId,
    required this.provider,
    this.description,
  });

  /// هل الفاتورة متأخرة
  bool get isOverdue => !isPaid && dueDate.isBefore(DateTime.now());

  /// الأيام المتبقية
  int get daysRemaining => dueDate.difference(DateTime.now()).inDays;

  /// أيقونة الفئة
  IconData get categoryIcon {
    switch (category) {
      case BillCategory.electricity:
        return Icons.electric_bolt;
      case BillCategory.water:
        return Icons.water_drop;
      case BillCategory.internet:
        return Icons.wifi;
      case BillCategory.phone:
        return Icons.phone;
      case BillCategory.gas:
        return Icons.local_fire_department;
      case BillCategory.tv:
        return Icons.tv;
      case BillCategory.education:
        return Icons.school;
      case BillCategory.government:
        return Icons.account_balance;
      case BillCategory.other:
        return Icons.receipt;
    }
  }

  factory BillModel.fromJson(Map<String, dynamic> json) {
    return BillModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      category: BillCategory.values.firstWhere(
        (e) => e.toString() == 'BillCategory.${json['category']}',
        orElse: () => BillCategory.other,
      ),
      accountNumber: json['accountNumber'] ?? '',
      amount: (json['amount'] ?? 0.0).toDouble(),
      dueDate: json['dueDate'] != null
          ? DateTime.parse(json['dueDate'])
          : DateTime.now(),
      isPaid: json['isPaid'] ?? false,
      paidAt: json['paidAt'] != null
          ? DateTime.parse(json['paidAt'])
          : null,
      transactionId: json['transactionId'],
      provider: json['provider'] ?? '',
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category.toString().split('.').last,
      'accountNumber': accountNumber,
      'amount': amount,
      'dueDate': dueDate.toIso8601String(),
      'isPaid': isPaid,
      'paidAt': paidAt?.toIso8601String(),
      'transactionId': transactionId,
      'provider': provider,
      'description': description,
    };
  }
}

/// نموذج بطاقة هدايا
class GiftCardModel {
  final String id;
  final String code;
  final double amount;
  final String currency;
  final bool isRedeemed;
  final DateTime? redeemedAt;
  final String? redeemedBy;
  final DateTime expiryDate;
  final DateTime createdAt;
  final String? message;
  final String? senderName;

  GiftCardModel({
    required this.id,
    required this.code,
    required this.amount,
    required this.currency,
    this.isRedeemed = false,
    this.redeemedAt,
    this.redeemedBy,
    required this.expiryDate,
    required this.createdAt,
    this.message,
    this.senderName,
  });

  /// هل البطاقة منتهية الصلاحية
  bool get isExpired => expiryDate.isBefore(DateTime.now());

  /// هل البطاقة صالحة
  bool get isValid => !isRedeemed && !isExpired;

  factory GiftCardModel.fromJson(Map<String, dynamic> json) {
    return GiftCardModel(
      id: json['id'] ?? '',
      code: json['code'] ?? '',
      amount: (json['amount'] ?? 0.0).toDouble(),
      currency: json['currency'] ?? 'YER',
      isRedeemed: json['isRedeemed'] ?? false,
      redeemedAt: json['redeemedAt'] != null
          ? DateTime.parse(json['redeemedAt'])
          : null,
      redeemedBy: json['redeemedBy'],
      expiryDate: json['expiryDate'] != null
          ? DateTime.parse(json['expiryDate'])
          : DateTime.now().add(const Duration(days: 365)),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      message: json['message'],
      senderName: json['senderName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'amount': amount,
      'currency': currency,
      'isRedeemed': isRedeemed,
      'redeemedAt': redeemedAt?.toIso8601String(),
      'redeemedBy': redeemedBy,
      'expiryDate': expiryDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'message': message,
      'senderName': senderName,
    };
  }
}
