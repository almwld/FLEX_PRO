class WalletBalance {
  final String currency; // YER, SAR, USD
  final double amount;
  final double heldAmount; // المبلغ المحجوز
  final DateTime lastUpdated;
  
  WalletBalance({
    required this.currency,
    required this.amount,
    this.heldAmount = 0,
    required this.lastUpdated,
  });
  
  factory WalletBalance.fromJson(Map<String, dynamic> json) {
    return WalletBalance(
      currency: json['currency'] ?? 'YER',
      amount: (json['amount'] ?? 0).toDouble(),
      heldAmount: (json['held_amount'] ?? 0).toDouble(),
      lastUpdated: DateTime.parse(json['last_updated'] ?? DateTime.now().toIso8601String()),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'currency': currency,
      'amount': amount,
      'held_amount': heldAmount,
      'last_updated': lastUpdated.toIso8601String(),
    };
  }
  
  // المبلغ المتاح للاستخدام
  double get availableAmount => amount - heldAmount;
  
  // رمز العملة
  String get symbol {
    switch (currency) {
      case 'YER':
        return 'ر.ي';
      case 'SAR':
        return 'ر.س';
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      default:
        return currency;
    }
  }
  
  // اسم العملة
  String get name {
    switch (currency) {
      case 'YER':
        return 'ريال يمني';
      case 'SAR':
        return 'ريال سعودي';
      case 'USD':
        return 'دولار أمريكي';
      case 'EUR':
        return 'يورو';
      default:
        return currency;
    }
  }
  
  // تنسيق المبلغ
  String get formattedAmount {
    return '${amount.toStringAsFixed(0)} $symbol';
  }
  
  String get formattedAvailableAmount {
    return '${availableAmount.toStringAsFixed(0)} $symbol';
  }
  
  WalletBalance copyWith({
    String? currency,
    double? amount,
    double? heldAmount,
    DateTime? lastUpdated,
  }) {
    return WalletBalance(
      currency: currency ?? this.currency,
      amount: amount ?? this.amount,
      heldAmount: heldAmount ?? this.heldAmount,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
