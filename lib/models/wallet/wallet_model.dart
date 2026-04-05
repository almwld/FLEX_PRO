import 'wallet_balance.dart';
import 'wallet_transaction.dart';

class WalletModel {
  final String id;
  final String userId;
  final List<WalletBalance> balances;
  final bool isActive;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime? lastActivity;
  final String? pinCode;
  final bool biometricEnabled;
  final double dailyLimit;
  final double monthlyLimit;
  final List<String> linkedBanks;
  final List<String> linkedCards;
  
  WalletModel({
    required this.id,
    required this.userId,
    required this.balances,
    this.isActive = true,
    this.isVerified = false,
    required this.createdAt,
    this.lastActivity,
    this.pinCode,
    this.biometricEnabled = false,
    this.dailyLimit = 1000000,
    this.monthlyLimit = 10000000,
    this.linkedBanks = const [],
    this.linkedCards = const [],
  });
  
  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      balances: (json['balances'] as List?)
          ?.map((e) => WalletBalance.fromJson(e))
          .toList() ?? [],
      isActive: json['is_active'] ?? true,
      isVerified: json['is_verified'] ?? false,
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      lastActivity: json['last_activity'] != null 
          ? DateTime.parse(json['last_activity']) 
          : null,
      pinCode: json['pin_code'],
      biometricEnabled: json['biometric_enabled'] ?? false,
      dailyLimit: (json['daily_limit'] ?? 1000000).toDouble(),
      monthlyLimit: (json['monthly_limit'] ?? 10000000).toDouble(),
      linkedBanks: List<String>.from(json['linked_banks'] ?? []),
      linkedCards: List<String>.from(json['linked_cards'] ?? []),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'balances': balances.map((e) => e.toJson()).toList(),
      'is_active': isActive,
      'is_verified': isVerified,
      'created_at': createdAt.toIso8601String(),
      'last_activity': lastActivity?.toIso8601String(),
      'pin_code': pinCode,
      'biometric_enabled': biometricEnabled,
      'daily_limit': dailyLimit,
      'monthly_limit': monthlyLimit,
      'linked_banks': linkedBanks,
      'linked_cards': linkedCards,
    };
  }
  
  // الحصول على رصيد عملة معينة
  WalletBalance? getBalance(String currency) {
    try {
      return balances.firstWhere((b) => b.currency == currency);
    } catch (e) {
      return null;
    }
  }
  
  // إجمالي الرصيد بالريال اليمني
  double get totalBalanceYER {
    return balances.fold(0, (sum, b) {
      if (b.currency == 'YER') return sum + b.amount;
      if (b.currency == 'SAR') return sum + (b.amount * 66.5);
      if (b.currency == 'USD') return sum + (b.amount * 250);
      return sum;
    });
  }
  
  // التحقق من وجود رصيد كافٍ
  bool hasSufficientBalance(String currency, double amount) {
    final balance = getBalance(currency);
    return balance != null && balance.availableAmount >= amount;
  }
  
  WalletModel copyWith({
    String? id,
    String? userId,
    List<WalletBalance>? balances,
    bool? isActive,
    bool? isVerified,
    DateTime? createdAt,
    DateTime? lastActivity,
    String? pinCode,
    bool? biometricEnabled,
    double? dailyLimit,
    double? monthlyLimit,
    List<String>? linkedBanks,
    List<String>? linkedCards,
  }) {
    return WalletModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      balances: balances ?? this.balances,
      isActive: isActive ?? this.isActive,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt ?? this.createdAt,
      lastActivity: lastActivity ?? this.lastActivity,
      pinCode: pinCode ?? this.pinCode,
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
      dailyLimit: dailyLimit ?? this.dailyLimit,
      monthlyLimit: monthlyLimit ?? this.monthlyLimit,
      linkedBanks: linkedBanks ?? this.linkedBanks,
      linkedCards: linkedCards ?? this.linkedCards,
    );
  }
}
