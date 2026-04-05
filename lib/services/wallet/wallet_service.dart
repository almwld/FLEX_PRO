import '../../models/wallet/wallet_model.dart';
import '../../models/wallet/wallet_balance.dart';
import '../../models/wallet/wallet_transaction.dart';
import '../storage/local_storage_service.dart';

class WalletService {
  static final WalletService _instance = WalletService._internal();
  factory WalletService() => _instance;
  WalletService._internal();
  
  WalletModel? _currentWallet;
  
  WalletModel? get currentWallet => _currentWallet;
  bool get hasWallet => _currentWallet != null;
  
  // تهيئة الخدمة
  Future<void> initialize() async {
    final walletData = LocalStorageService.getWalletData();
    if (walletData != null) {
      _currentWallet = WalletModel.fromJson(walletData);
    }
  }
  
  // إنشاء محفظة جديدة
  Future<WalletResult> createWallet(String userId) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      final wallet = WalletModel(
        id: 'wallet_${DateTime.now().millisecondsSinceEpoch}',
        userId: userId,
        balances: [
          WalletBalance(
            currency: 'YER',
            amount: 0,
            lastUpdated: DateTime.now(),
          ),
          WalletBalance(
            currency: 'SAR',
            amount: 0,
            lastUpdated: DateTime.now(),
          ),
          WalletBalance(
            currency: 'USD',
            amount: 0,
            lastUpdated: DateTime.now(),
          ),
        ],
        createdAt: DateTime.now(),
        isActive: true,
      );
      
      await _saveWalletData(wallet);
      
      return WalletResult.success(wallet);
    } catch (e) {
      return WalletResult.error('حدث خطأ أثناء إنشاء المحفظة: $e');
    }
  }
  
  // الحصول على بيانات المحفظة
  Future<WalletResult> getWallet(String walletId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      
      if (_currentWallet != null && _currentWallet!.id == walletId) {
        return WalletResult.success(_currentWallet!);
      }
      
      return WalletResult.error('المحفظة غير موجودة');
    } catch (e) {
      return WalletResult.error('حدث خطأ: $e');
    }
  }
  
  // إيداع مبلغ
  Future<WalletResult> deposit({
    required String currency,
    required double amount,
    required String method,
    String? description,
  }) async {
    try {
      if (_currentWallet == null) {
        return WalletResult.error('المحفظة غير موجودة');
      }
      
      await Future.delayed(const Duration(seconds: 1));
      
      // تحديث الرصيد
      final balances = List<WalletBalance>.from(_currentWallet!.balances);
      final balanceIndex = balances.indexWhere((b) => b.currency == currency);
      
      if (balanceIndex >= 0) {
        final oldBalance = balances[balanceIndex];
        balances[balanceIndex] = oldBalance.copyWith(
          amount: oldBalance.amount + amount,
          lastUpdated: DateTime.now(),
        );
      }
      
      final updatedWallet = _currentWallet!.copyWith(
        balances: balances,
        lastActivity: DateTime.now(),
      );
      
      await _saveWalletData(updatedWallet);
      
      // إنشاء معاملة
      final transaction = WalletTransaction(
        id: 'txn_${DateTime.now().millisecondsSinceEpoch}',
        walletId: _currentWallet!.id,
        type: TransactionType.deposit,
        status: TransactionStatus.completed,
        amount: amount,
        currency: currency,
        description: description ?? 'إيداع عبر $method',
        createdAt: DateTime.now(),
        completedAt: DateTime.now(),
        referenceNumber: 'REF${DateTime.now().millisecondsSinceEpoch}',
      );
      
      return WalletResult.success(updatedWallet, transaction: transaction);
    } catch (e) {
      return WalletResult.error('حدث خطأ أثناء الإيداع: $e');
    }
  }
  
  // سحب مبلغ
  Future<WalletResult> withdraw({
    required String currency,
    required double amount,
    required String method,
    String? description,
  }) async {
    try {
      if (_currentWallet == null) {
        return WalletResult.error('المحفظة غير موجودة');
      }
      
      // التحقق من الرصيد
      final balance = _currentWallet!.getBalance(currency);
      if (balance == null || balance.availableAmount < amount) {
        return WalletResult.error('رصيد غير كافٍ');
      }
      
      await Future.delayed(const Duration(seconds: 1));
      
      // تحديث الرصيد
      final balances = List<WalletBalance>.from(_currentWallet!.balances);
      final balanceIndex = balances.indexWhere((b) => b.currency == currency);
      
      if (balanceIndex >= 0) {
        final oldBalance = balances[balanceIndex];
        balances[balanceIndex] = oldBalance.copyWith(
          amount: oldBalance.amount - amount,
          lastUpdated: DateTime.now(),
        );
      }
      
      final updatedWallet = _currentWallet!.copyWith(
        balances: balances,
        lastActivity: DateTime.now(),
      );
      
      await _saveWalletData(updatedWallet);
      
      // إنشاء معاملة
      final transaction = WalletTransaction(
        id: 'txn_${DateTime.now().millisecondsSinceEpoch}',
        walletId: _currentWallet!.id,
        type: TransactionType.withdrawal,
        status: TransactionStatus.completed,
        amount: amount,
        currency: currency,
        description: description ?? 'سحب عبر $method',
        createdAt: DateTime.now(),
        completedAt: DateTime.now(),
        referenceNumber: 'REF${DateTime.now().millisecondsSinceEpoch}',
      );
      
      return WalletResult.success(updatedWallet, transaction: transaction);
    } catch (e) {
      return WalletResult.error('حدث خطأ أثناء السحب: $e');
    }
  }
  
  // تحويل مبلغ
  Future<WalletResult> transfer({
    required String currency,
    required double amount,
    required String recipientId,
    required String recipientName,
    String? recipientPhone,
    String? description,
  }) async {
    try {
      if (_currentWallet == null) {
        return WalletResult.error('المحفظة غير موجودة');
      }
      
      // التحقق من الرصيد
      final balance = _currentWallet!.getBalance(currency);
      if (balance == null || balance.availableAmount < amount) {
        return WalletResult.error('رصيد غير كافٍ');
      }
      
      await Future.delayed(const Duration(seconds: 1));
      
      // تحديث الرصيد
      final balances = List<WalletBalance>.from(_currentWallet!.balances);
      final balanceIndex = balances.indexWhere((b) => b.currency == currency);
      
      if (balanceIndex >= 0) {
        final oldBalance = balances[balanceIndex];
        balances[balanceIndex] = oldBalance.copyWith(
          amount: oldBalance.amount - amount,
          lastUpdated: DateTime.now(),
        );
      }
      
      final updatedWallet = _currentWallet!.copyWith(
        balances: balances,
        lastActivity: DateTime.now(),
      );
      
      await _saveWalletData(updatedWallet);
      
      // إنشاء معاملة
      final transaction = WalletTransaction(
        id: 'txn_${DateTime.now().millisecondsSinceEpoch}',
        walletId: _currentWallet!.id,
        type: TransactionType.transfer,
        status: TransactionStatus.completed,
        amount: amount,
        currency: currency,
        description: description ?? 'تحويل إلى $recipientName',
        recipientId: recipientId,
        recipientName: recipientName,
        recipientPhone: recipientPhone,
        createdAt: DateTime.now(),
        completedAt: DateTime.now(),
        referenceNumber: 'REF${DateTime.now().millisecondsSinceEpoch}',
      );
      
      return WalletResult.success(updatedWallet, transaction: transaction);
    } catch (e) {
      return WalletResult.error('حدث خطأ أثناء التحويل: $e');
    }
  }
  
  // دفع فاتورة
  Future<WalletResult> payBill({
    required String billId,
    required String currency,
    required double amount,
    required String provider,
    String? description,
  }) async {
    try {
      if (_currentWallet == null) {
        return WalletResult.error('المحفظة غير موجودة');
      }
      
      // التحقق من الرصيد
      final balance = _currentWallet!.getBalance(currency);
      if (balance == null || balance.availableAmount < amount) {
        return WalletResult.error('رصيد غير كافٍ');
      }
      
      await Future.delayed(const Duration(seconds: 1));
      
      // تحديث الرصيد
      final balances = List<WalletBalance>.from(_currentWallet!.balances);
      final balanceIndex = balances.indexWhere((b) => b.currency == currency);
      
      if (balanceIndex >= 0) {
        final oldBalance = balances[balanceIndex];
        balances[balanceIndex] = oldBalance.copyWith(
          amount: oldBalance.amount - amount,
          lastUpdated: DateTime.now(),
        );
      }
      
      final updatedWallet = _currentWallet!.copyWith(
        balances: balances,
        lastActivity: DateTime.now(),
      );
      
      await _saveWalletData(updatedWallet);
      
      // إنشاء معاملة
      final transaction = WalletTransaction(
        id: 'txn_${DateTime.now().millisecondsSinceEpoch}',
        walletId: _currentWallet!.id,
        type: TransactionType.billPayment,
        status: TransactionStatus.completed,
        amount: amount,
        currency: currency,
        description: description ?? 'دفع فاتورة $provider',
        createdAt: DateTime.now(),
        completedAt: DateTime.now(),
        referenceNumber: 'REF${DateTime.now().millisecondsSinceEpoch}',
        metadata: {'bill_id': billId},
      );
      
      return WalletResult.success(updatedWallet, transaction: transaction);
    } catch (e) {
      return WalletResult.error('حدث خطأ أثناء دفع الفاتورة: $e');
    }
  }
  
  // شراء بطاقة هدايا
  Future<WalletResult> buyGiftCard({
    required String cardType,
    required String currency,
    required double amount,
    String? description,
  }) async {
    try {
      if (_currentWallet == null) {
        return WalletResult.error('المحفظة غير موجودة');
      }
      
      // التحقق من الرصيد
      final balance = _currentWallet!.getBalance(currency);
      if (balance == null || balance.availableAmount < amount) {
        return WalletResult.error('رصيد غير كافٍ');
      }
      
      await Future.delayed(const Duration(seconds: 1));
      
      // تحديث الرصيد
      final balances = List<WalletBalance>.from(_currentWallet!.balances);
      final balanceIndex = balances.indexWhere((b) => b.currency == currency);
      
      if (balanceIndex >= 0) {
        final oldBalance = balances[balanceIndex];
        balances[balanceIndex] = oldBalance.copyWith(
          amount: oldBalance.amount - amount,
          lastUpdated: DateTime.now(),
        );
      }
      
      final updatedWallet = _currentWallet!.copyWith(
        balances: balances,
        lastActivity: DateTime.now(),
      );
      
      await _saveWalletData(updatedWallet);
      
      // إنشاء معاملة
      final transaction = WalletTransaction(
        id: 'txn_${DateTime.now().millisecondsSinceEpoch}',
        walletId: _currentWallet!.id,
        type: TransactionType.giftCard,
        status: TransactionStatus.completed,
        amount: amount,
        currency: currency,
        description: description ?? 'شراء بطاقة $cardType',
        createdAt: DateTime.now(),
        completedAt: DateTime.now(),
        referenceNumber: 'REF${DateTime.now().millisecondsSinceEpoch}',
        metadata: {'card_type': cardType},
      );
      
      return WalletResult.success(updatedWallet, transaction: transaction);
    } catch (e) {
      return WalletResult.error('حدث خطأ: $e');
    }
  }
  
  // شحن رصيد
  Future<WalletResult> recharge({
    required String phoneNumber,
    required String operator,
    required String currency,
    required double amount,
  }) async {
    try {
      if (_currentWallet == null) {
        return WalletResult.error('المحفظة غير موجودة');
      }
      
      // التحقق من الرصيد
      final balance = _currentWallet!.getBalance(currency);
      if (balance == null || balance.availableAmount < amount) {
        return WalletResult.error('رصيد غير كافٍ');
      }
      
      await Future.delayed(const Duration(seconds: 1));
      
      // تحديث الرصيد
      final balances = List<WalletBalance>.from(_currentWallet!.balances);
      final balanceIndex = balances.indexWhere((b) => b.currency == currency);
      
      if (balanceIndex >= 0) {
        final oldBalance = balances[balanceIndex];
        balances[balanceIndex] = oldBalance.copyWith(
          amount: oldBalance.amount - amount,
          lastUpdated: DateTime.now(),
        );
      }
      
      final updatedWallet = _currentWallet!.copyWith(
        balances: balances,
        lastActivity: DateTime.now(),
      );
      
      await _saveWalletData(updatedWallet);
      
      // إنشاء معاملة
      final transaction = WalletTransaction(
        id: 'txn_${DateTime.now().millisecondsSinceEpoch}',
        walletId: _currentWallet!.id,
        type: TransactionType.recharge,
        status: TransactionStatus.completed,
        amount: amount,
        currency: currency,
        description: 'شحن رصيد $operator',
        recipientPhone: phoneNumber,
        createdAt: DateTime.now(),
        completedAt: DateTime.now(),
        referenceNumber: 'REF${DateTime.now().millisecondsSinceEpoch}',
      );
      
      return WalletResult.success(updatedWallet, transaction: transaction);
    } catch (e) {
      return WalletResult.error('حدث خطأ أثناء الشحن: $e');
    }
  }
  
  // الحصول على سجل المعاملات
  Future<List<WalletTransaction>> getTransactionHistory({
    String? currency,
    TransactionType? type,
    DateTime? fromDate,
    DateTime? toDate,
    int limit = 50,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      
      // محاكاة جلب المعاملات
      return sampleTransactions.where((t) {
        if (currency != null && t.currency != currency) return false;
        if (type != null && t.type != type) return false;
        if (fromDate != null && t.createdAt.isBefore(fromDate)) return false;
        if (toDate != null && t.createdAt.isAfter(toDate)) return false;
        return true;
      }).take(limit).toList();
    } catch (e) {
      return [];
    }
  }
  
  // تحديث رمز PIN
  Future<WalletResult> updatePin(String newPin) async {
    try {
      if (_currentWallet == null) {
        return WalletResult.error('المحفظة غير موجودة');
      }
      
      final updatedWallet = _currentWallet!.copyWith(
        pinCode: newPin,
      );
      
      await _saveWalletData(updatedWallet);
      
      return WalletResult.success(updatedWallet);
    } catch (e) {
      return WalletResult.error('حدث خطأ: $e');
    }
  }
  
  // تفعيل/تعطيل البصمة
  Future<WalletResult> toggleBiometric(bool enabled) async {
    try {
      if (_currentWallet == null) {
        return WalletResult.error('المحفظة غير موجودة');
      }
      
      final updatedWallet = _currentWallet!.copyWith(
        biometricEnabled: enabled,
      );
      
      await _saveWalletData(updatedWallet);
      
      return WalletResult.success(updatedWallet);
    } catch (e) {
      return WalletResult.error('حدث خطأ: $e');
    }
  }
  
  // حفظ بيانات المحفظة
  Future<void> _saveWalletData(WalletModel wallet) async {
    _currentWallet = wallet;
    await LocalStorageService.saveWalletData(wallet.toJson());
  }
  
  // معاملات افتراضية
  final List<WalletTransaction> sampleTransactions = [
    WalletTransaction(
      id: 'txn_1',
      walletId: 'wallet_1',
      type: TransactionType.deposit,
      status: TransactionStatus.completed,
      amount: 100000,
      currency: 'YER',
      description: 'إيداع عبر تحويل بنكي',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      completedAt: DateTime.now().subtract(const Duration(days: 5)),
      referenceNumber: 'REF001',
    ),
    WalletTransaction(
      id: 'txn_2',
      walletId: 'wallet_1',
      type: TransactionType.transfer,
      status: TransactionStatus.completed,
      amount: 25000,
      currency: 'YER',
      description: 'تحويل إلى محمد علي',
      recipientName: 'محمد علي',
      recipientPhone: '777987654',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      completedAt: DateTime.now().subtract(const Duration(days: 3)),
      referenceNumber: 'REF002',
    ),
    WalletTransaction(
      id: 'txn_3',
      walletId: 'wallet_1',
      type: TransactionType.billPayment,
      status: TransactionStatus.completed,
      amount: 15000,
      currency: 'YER',
      description: 'دفع فاتورة كهرباء',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      completedAt: DateTime.now().subtract(const Duration(days: 1)),
      referenceNumber: 'REF003',
    ),
    WalletTransaction(
      id: 'txn_4',
      walletId: 'wallet_1',
      type: TransactionType.recharge,
      status: TransactionStatus.completed,
      amount: 5000,
      currency: 'YER',
      description: 'شحن رصيد سبأفون',
      recipientPhone: '777123456',
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      completedAt: DateTime.now().subtract(const Duration(hours: 5)),
      referenceNumber: 'REF004',
    ),
    WalletTransaction(
      id: 'txn_5',
      walletId: 'wallet_1',
      type: TransactionType.withdrawal,
      status: TransactionStatus.completed,
      amount: 30000,
      currency: 'YER',
      description: 'سحب نقدي',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      completedAt: DateTime.now().subtract(const Duration(hours: 2)),
      referenceNumber: 'REF005',
    ),
  ];
}

class WalletResult {
  final bool success;
  final WalletModel? wallet;
  final WalletTransaction? transaction;
  final String? message;
  final String? error;
  
  WalletResult._({
    required this.success,
    this.wallet,
    this.transaction,
    this.message,
    this.error,
  });
  
  factory WalletResult.success(WalletModel wallet, {WalletTransaction? transaction, String? message}) {
    return WalletResult._(
      success: true,
      wallet: wallet,
      transaction: transaction,
      message: message,
    );
  }
  
  factory WalletResult.error(String error) {
    return WalletResult._(
      success: false,
      error: error,
    );
  }
}
