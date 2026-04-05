import 'package:flutter/material.dart';

enum BillType {
  electricity,
  water,
  internet,
  phone,
  gas,
  tv,
  education,
  government,
  other,
}

enum BillStatus {
  unpaid,
  paid,
  overdue,
  partiallyPaid,
  cancelled,
}

class BillModel {
  final String id;
  final String billNumber;
  final BillType type;
  final String provider;
  final String? providerLogo;
  final String accountNumber;
  final String accountName;
  final double amount;
  final double? paidAmount;
  final String currency;
  final DateTime issueDate;
  final DateTime dueDate;
  final DateTime? paidDate;
  final BillStatus status;
  final String? description;
  final List<BillItem>? items;
  final String? barcode;
  final bool isRecurring;
  final String? recurrencePeriod;
  
  BillModel({
    required this.id,
    required this.billNumber,
    required this.type,
    required this.provider,
    this.providerLogo,
    required this.accountNumber,
    required this.accountName,
    required this.amount,
    this.paidAmount,
    this.currency = 'YER',
    required this.issueDate,
    required this.dueDate,
    this.paidDate,
    required this.status,
    this.description,
    this.items,
    this.barcode,
    this.isRecurring = false,
    this.recurrencePeriod,
  });
  
  factory BillModel.fromJson(Map<String, dynamic> json) {
    return BillModel(
      id: json['id'] ?? '',
      billNumber: json['bill_number'] ?? '',
      type: BillType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => BillType.other,
      ),
      provider: json['provider'] ?? '',
      providerLogo: json['provider_logo'],
      accountNumber: json['account_number'] ?? '',
      accountName: json['account_name'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      paidAmount: json['paid_amount']?.toDouble(),
      currency: json['currency'] ?? 'YER',
      issueDate: DateTime.parse(json['issue_date'] ?? DateTime.now().toIso8601String()),
      dueDate: DateTime.parse(json['due_date'] ?? DateTime.now().toIso8601String()),
      paidDate: json['paid_date'] != null ? DateTime.parse(json['paid_date']) : null,
      status: BillStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => BillStatus.unpaid,
      ),
      description: json['description'],
      items: json['items'] != null 
          ? (json['items'] as List).map((i) => BillItem.fromJson(i)).toList()
          : null,
      barcode: json['barcode'],
      isRecurring: json['is_recurring'] ?? false,
      recurrencePeriod: json['recurrence_period'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bill_number': billNumber,
      'type': type.name,
      'provider': provider,
      'provider_logo': providerLogo,
      'account_number': accountNumber,
      'account_name': accountName,
      'amount': amount,
      'paid_amount': paidAmount,
      'currency': currency,
      'issue_date': issueDate.toIso8601String(),
      'due_date': dueDate.toIso8601String(),
      'paid_date': paidDate?.toIso8601String(),
      'status': status.name,
      'description': description,
      'items': items?.map((i) => i.toJson()).toList(),
      'barcode': barcode,
      'is_recurring': isRecurring,
      'recurrence_period': recurrencePeriod,
    };
  }
  
  // نص نوع الفاتورة
  String get typeText {
    switch (type) {
      case BillType.electricity:
        return 'كهرباء';
      case BillType.water:
        return 'مياه';
      case BillType.internet:
        return 'إنترنت';
      case BillType.phone:
        return 'هاتف';
      case BillType.gas:
        return 'غاز';
      case BillType.tv:
        return 'تلفزيون';
      case BillType.education:
        return 'تعليم';
      case BillType.government:
        return 'حكومي';
      case BillType.other:
        return 'أخرى';
    }
  }
  
  // أيقونة نوع الفاتورة
  IconData get typeIcon {
    switch (type) {
      case BillType.electricity:
        return Icons.electric_bolt;
      case BillType.water:
        return Icons.water_drop;
      case BillType.internet:
        return Icons.wifi;
      case BillType.phone:
        return Icons.phone;
      case BillType.gas:
        return Icons.local_fire_department;
      case BillType.tv:
        return Icons.tv;
      case BillType.education:
        return Icons.school;
      case BillType.government:
        return Icons.account_balance;
      case BillType.other:
        return Icons.receipt;
    }
  }
  
  // لون نوع الفاتورة
  Color get typeColor {
    switch (type) {
      case BillType.electricity:
        return Colors.yellow.shade700;
      case BillType.water:
        return Colors.blue;
      case BillType.internet:
        return Colors.purple;
      case BillType.phone:
        return Colors.green;
      case BillType.gas:
        return Colors.orange;
      case BillType.tv:
        return Colors.red;
      case BillType.education:
        return Colors.teal;
      case BillType.government:
        return Colors.indigo;
      case BillType.other:
        return Colors.grey;
    }
  }
  
  // نص الحالة
  String get statusText {
    switch (status) {
      case BillStatus.unpaid:
        return 'غير مدفوعة';
      case BillStatus.paid:
        return 'مدفوعة';
      case BillStatus.overdue:
        return 'متأخرة';
      case BillStatus.partiallyPaid:
        return 'مدفوعة جزئياً';
      case BillStatus.cancelled:
        return 'ملغاة';
    }
  }
  
  // لون الحالة
  Color get statusColor {
    switch (status) {
      case BillStatus.unpaid:
        return Colors.orange;
      case BillStatus.paid:
        return const Color(0xFF00A15C);
      case BillStatus.overdue:
        return const Color(0xFFE5493A);
      case BillStatus.partiallyPaid:
        return Colors.blue;
      case BillStatus.cancelled:
        return Colors.grey;
    }
  }
  
  // هل الفاتورة متأخرة
  bool get isOverdue {
    return status == BillStatus.unpaid && dueDate.isBefore(DateTime.now());
  }
  
  // المبلغ المتبقي
  double get remainingAmount {
    return amount - (paidAmount ?? 0);
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
  
  // تاريخ الاستحقاق المنسق
  String get formattedDueDate {
    return '${dueDate.day}/${dueDate.month}/${dueDate.year}';
  }
  
  // الأيام المتبقية
  String get daysLeft {
    final diff = dueDate.difference(DateTime.now()).inDays;
    if (diff < 0) return 'متأخرة ${diff.abs()} يوم';
    if (diff == 0) return 'تستحق اليوم';
    if (diff == 1) return 'يوم واحد';
    return '$diff أيام';
  }
  
  BillModel copyWith({
    String? id,
    String? billNumber,
    BillType? type,
    String? provider,
    String? providerLogo,
    String? accountNumber,
    String? accountName,
    double? amount,
    double? paidAmount,
    String? currency,
    DateTime? issueDate,
    DateTime? dueDate,
    DateTime? paidDate,
    BillStatus? status,
    String? description,
    List<BillItem>? items,
    String? barcode,
    bool? isRecurring,
    String? recurrencePeriod,
  }) {
    return BillModel(
      id: id ?? this.id,
      billNumber: billNumber ?? this.billNumber,
      type: type ?? this.type,
      provider: provider ?? this.provider,
      providerLogo: providerLogo ?? this.providerLogo,
      accountNumber: accountNumber ?? this.accountNumber,
      accountName: accountName ?? this.accountName,
      amount: amount ?? this.amount,
      paidAmount: paidAmount ?? this.paidAmount,
      currency: currency ?? this.currency,
      issueDate: issueDate ?? this.issueDate,
      dueDate: dueDate ?? this.dueDate,
      paidDate: paidDate ?? this.paidDate,
      status: status ?? this.status,
      description: description ?? this.description,
      items: items ?? this.items,
      barcode: barcode ?? this.barcode,
      isRecurring: isRecurring ?? this.isRecurring,
      recurrencePeriod: recurrencePeriod ?? this.recurrencePeriod,
    );
  }
}

class BillItem {
  final String id;
  final String name;
  final String? description;
  final double amount;
  final double? quantity;
  final String? unit;
  
  BillItem({
    required this.id,
    required this.name,
    this.description,
    required this.amount,
    this.quantity,
    this.unit,
  });
  
  factory BillItem.fromJson(Map<String, dynamic> json) {
    return BillItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      amount: (json['amount'] ?? 0).toDouble(),
      quantity: json['quantity']?.toDouble(),
      unit: json['unit'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'amount': amount,
      'quantity': quantity,
      'unit': unit,
    };
  }
}

// فواتير افتراضية
final List<BillModel> sampleBills = [
  BillModel(
    id: '1',
    billNumber: 'ELEC-2026-001',
    type: BillType.electricity,
    provider: 'شركة الكهرباء اليمنية',
    accountNumber: '123456789',
    accountName: 'أحمد محمد',
    amount: 15000,
    currency: 'YER',
    issueDate: DateTime.now().subtract(const Duration(days: 10)),
    dueDate: DateTime.now().add(const Duration(days: 5)),
    status: BillStatus.unpaid,
    description: 'فاتورة استهلاك شهر يناير 2026',
    items: [
      BillItem(id: '1', name: 'استهلاك الكهرباء', amount: 13500, quantity: 250, unit: 'كيلو واط'),
      BillItem(id: '2', name: 'رسوم الخدمة', amount: 1500),
    ],
  ),
  BillModel(
    id: '2',
    billNumber: 'WATER-2026-001',
    type: BillType.water,
    provider: 'المؤسسة العامة للمياه',
    accountNumber: '987654321',
    accountName: 'أحمد محمد',
    amount: 5000,
    currency: 'YER',
    issueDate: DateTime.now().subtract(const Duration(days: 15)),
    dueDate: DateTime.now().add(const Duration(days: 2)),
    status: BillStatus.unpaid,
    description: 'فاتورة استهلاك المياه - يناير 2026',
  ),
  BillModel(
    id: '3',
    billNumber: 'NET-2026-001',
    type: BillType.internet,
    provider: 'يمن نت',
    accountNumber: 'NET123456',
    accountName: 'أحمد محمد',
    amount: 25000,
    currency: 'YER',
    issueDate: DateTime.now().subtract(const Duration(days: 5)),
    dueDate: DateTime.now().add(const Duration(days: 10)),
    status: BillStatus.paid,
    paidDate: DateTime.now().subtract(const Duration(days: 2)),
    paidAmount: 25000,
    description: 'اشتراك إنترنت شهري - باقة 20 ميجا',
  ),
  BillModel(
    id: '4',
    billNumber: 'PHONE-2026-001',
    type: BillType.phone,
    provider: 'سبأفون',
    accountNumber: '777123456',
    accountName: 'أحمد محمد',
    amount: 8500,
    currency: 'YER',
    issueDate: DateTime.now().subtract(const Duration(days: 20)),
    dueDate: DateTime.now().subtract(const Duration(days: 5)),
    status: BillStatus.overdue,
    description: 'فاتورة الهاتف المحمول - يناير 2026',
  ),
];
