// lib/models/coupon_model.dart

/// نوع الخصم
enum DiscountType {
  percentage,  // نسبة مئوية
  fixed,       // مبلغ ثابت
}

/// نموذج الكوبون
class CouponModel {
  final String id;
  final String code;
  final String? description;
  final DiscountType discountType;
  final double discountValue;
  final double? minOrderAmount;
  final double? maxDiscount;
  final DateTime startDate;
  final DateTime expiryDate;
  final int? usageLimit;
  final int usageCount;
  final bool isActive;
  final List<String>? applicableCategories;
  final List<String>? applicableProducts;
  final List<String>? excludedProducts;
  final bool isFirstOrderOnly;
  final DateTime createdAt;

  CouponModel({
    required this.id,
    required this.code,
    this.description,
    required this.discountType,
    required this.discountValue,
    this.minOrderAmount,
    this.maxDiscount,
    required this.startDate,
    required this.expiryDate,
    this.usageLimit,
    this.usageCount = 0,
    this.isActive = true,
    this.applicableCategories,
    this.applicableProducts,
    this.excludedProducts,
    this.isFirstOrderOnly = false,
    required this.createdAt,
  });

  /// هل الكوبون صالح
  bool get isValid {
    final now = DateTime.now();
    return isActive &&
           now.isAfter(startDate) &&
           now.isBefore(expiryDate) &&
           !isExpired &&
           !isUsageLimitReached;
  }

  /// هل الكوبون منتهي الصلاحية
  bool get isExpired => DateTime.now().isAfter(expiryDate);

  /// هل تم الوصول للحد الأقصى للاستخدام
  bool get isUsageLimitReached {
    if (usageLimit == null) return false;
    return usageCount >= usageLimit!;
  }

  /// نص نوع الخصم
  String get discountTypeText {
    switch (discountType) {
      case DiscountType.percentage:
        return 'نسبة مئوية';
      case DiscountType.fixed:
        return 'مبلغ ثابت';
    }
  }

  /// نص قيمة الخصم
  String get discountText {
    switch (discountType) {
      case DiscountType.percentage:
        return '%${discountValue.toStringAsFixed(0)}';
      case DiscountType.fixed:
        return '${discountValue.toStringAsFixed(0)} ر.ي';
    }
  }

  /// حساب قيمة الخصم
  double calculateDiscount(double orderAmount) {
    if (!isValid) return 0;
    if (minOrderAmount != null && orderAmount < minOrderAmount!) return 0;

    double discount;
    switch (discountType) {
      case DiscountType.percentage:
        discount = orderAmount * (discountValue / 100);
        break;
      case DiscountType.fixed:
        discount = discountValue;
        break;
    }

    if (maxDiscount != null && discount > maxDiscount!) {
      discount = maxDiscount!;
    }

    return discount;
  }

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json['id'] ?? '',
      code: json['code'] ?? '',
      description: json['description'],
      discountType: DiscountType.values.firstWhere(
        (e) => e.toString() == 'DiscountType.${json['discountType']}',
        orElse: () => DiscountType.percentage,
      ),
      discountValue: (json['discountValue'] ?? 0.0).toDouble(),
      minOrderAmount: json['minOrderAmount']?.toDouble(),
      maxDiscount: json['maxDiscount']?.toDouble(),
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'])
          : DateTime.now(),
      expiryDate: json['expiryDate'] != null
          ? DateTime.parse(json['expiryDate'])
          : DateTime.now(),
      usageLimit: json['usageLimit'],
      usageCount: json['usageCount'] ?? 0,
      isActive: json['isActive'] ?? true,
      applicableCategories: json['applicableCategories'] != null
          ? List<String>.from(json['applicableCategories'])
          : null,
      applicableProducts: json['applicableProducts'] != null
          ? List<String>.from(json['applicableProducts'])
          : null,
      excludedProducts: json['excludedProducts'] != null
          ? List<String>.from(json['excludedProducts'])
          : null,
      isFirstOrderOnly: json['isFirstOrderOnly'] ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'description': description,
      'discountType': discountType.toString().split('.').last,
      'discountValue': discountValue,
      'minOrderAmount': minOrderAmount,
      'maxDiscount': maxDiscount,
      'startDate': startDate.toIso8601String(),
      'expiryDate': expiryDate.toIso8601String(),
      'usageLimit': usageLimit,
      'usageCount': usageCount,
      'isActive': isActive,
      'applicableCategories': applicableCategories,
      'applicableProducts': applicableProducts,
      'excludedProducts': excludedProducts,
      'isFirstOrderOnly': isFirstOrderOnly,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  CouponModel copyWith({
    String? id,
    String? code,
    String? description,
    DiscountType? discountType,
    double? discountValue,
    double? minOrderAmount,
    double? maxDiscount,
    DateTime? startDate,
    DateTime? expiryDate,
    int? usageLimit,
    int? usageCount,
    bool? isActive,
    List<String>? applicableCategories,
    List<String>? applicableProducts,
    List<String>? excludedProducts,
    bool? isFirstOrderOnly,
    DateTime? createdAt,
  }) {
    return CouponModel(
      id: id ?? this.id,
      code: code ?? this.code,
      description: description ?? this.description,
      discountType: discountType ?? this.discountType,
      discountValue: discountValue ?? this.discountValue,
      minOrderAmount: minOrderAmount ?? this.minOrderAmount,
      maxDiscount: maxDiscount ?? this.maxDiscount,
      startDate: startDate ?? this.startDate,
      expiryDate: expiryDate ?? this.expiryDate,
      usageLimit: usageLimit ?? this.usageLimit,
      usageCount: usageCount ?? this.usageCount,
      isActive: isActive ?? this.isActive,
      applicableCategories: applicableCategories ?? this.applicableCategories,
      applicableProducts: applicableProducts ?? this.applicableProducts,
      excludedProducts: excludedProducts ?? this.excludedProducts,
      isFirstOrderOnly: isFirstOrderOnly ?? this.isFirstOrderOnly,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
