// lib/services/wallet_service.dart

import '../models/models.dart';

/// خدمة المحفظة
class WalletService {
  static final WalletService _instance = WalletService._internal();
  factory WalletService() => _instance;
  WalletService._internal();

  // ========== المحفظة ==========

  /// الحصول على المحفظة
  Future<WalletModel?> getWallet() async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(milliseconds: 500));

    return WalletModel(
      id: 'wallet_1',
      userId: 'user_1',
      balance: 150000,
      frozenBalance: 0,
      currency: 'YER',
      isActive: true,
      isVerified: true,
      createdAt: DateTime.now().subtract(const Duration(days: 365)),
      updatedAt: DateTime.now(),
      limits: WalletLimits.defaultLimits(),
      stats: WalletStats(
        totalTransactions: 150,
        totalDeposits: 500000,
        totalWithdrawals: 200000,
        totalPayments: 150000,
        totalFees: 5000,
        lastActivity: DateTime.now(),
      ),
    );
  }

  /// الحصول على الرصيد
  Future<WalletBalance?> getBalance() async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(milliseconds: 300));

    return WalletBalance(
      total: 150000,
      available: 150000,
      frozen: 0,
      pending: 0,
      currency: 'YER',
    );
  }

  // ========== المعاملات ==========

  /// الحصول على المعاملات
  Future<List<WalletTransaction>> getTransactions({
    int page = 1,
    int limit = 20,
    TransactionType? type,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(milliseconds: 500));

    // محاكاة بيانات
    return List.generate(
      limit,
      (index) => WalletTransaction(
        id: 'txn_${page}_$index',
        walletId: 'wallet_1',
        userId: 'user_1',
        type: TransactionType.values[index % TransactionType.values.length],
        status: TransactionStatus.completed,
        amount: (index + 1) * 1000.0,
        fee: index % 3 == 0 ? 50 : 0,
        currency: 'YER',
        description: 'معاملة تجريبية ${index + 1}',
        createdAt: DateTime.now().subtract(Duration(days: index)),
        title: 'معاملة ${index + 1}',
        subtitle: 'وصف المعاملة ${index + 1}',
      ),
    );
  }

  /// الحصول على تفاصيل معاملة
  Future<WalletTransaction?> getTransactionDetails(String transactionId) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(milliseconds: 300));

    return WalletTransaction(
      id: transactionId,
      walletId: 'wallet_1',
      userId: 'user_1',
      type: TransactionType.deposit,
      status: TransactionStatus.completed,
      amount: 10000,
      fee: 0,
      currency: 'YER',
      description: 'تفاصيل المعاملة',
      createdAt: DateTime.now(),
      title: 'إيداع',
      subtitle: 'إيداع عبر البطاقة البنكية',
    );
  }

  /// البحث في المعاملات
  Future<List<WalletTransaction>> searchTransactions(String query) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(milliseconds: 500));
    return [];
  }

  // ========== العمليات المالية ==========

  /// إيداع
  Future<WalletTransaction?> deposit({
    required double amount,
    required PaymentMethod method,
    Map<String, dynamic>? metadata,
  }) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(seconds: 1));

    return WalletTransaction(
      id: 'txn_deposit_${DateTime.now().millisecondsSinceEpoch}',
      walletId: 'wallet_1',
      userId: 'user_1',
      type: TransactionType.deposit,
      status: TransactionStatus.completed,
      amount: amount,
      fee: 0,
      currency: 'YER',
      paymentMethod: method,
      description: 'إيداع مبلغ $amount',
      createdAt: DateTime.now(),
      title: 'إيداع',
      subtitle: 'إيداع عبر ${method.toString().split('.').last}',
    );
  }

  /// سحب
  Future<WalletTransaction?> withdraw({
    required double amount,
    required PaymentMethod method,
    Map<String, dynamic>? metadata,
  }) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(seconds: 1));

    return WalletTransaction(
      id: 'txn_withdraw_${DateTime.now().millisecondsSinceEpoch}',
      walletId: 'wallet_1',
      userId: 'user_1',
      type: TransactionType.withdraw,
      status: TransactionStatus.completed,
      amount: amount,
      fee: 100,
      currency: 'YER',
      paymentMethod: method,
      description: 'سحب مبلغ $amount',
      createdAt: DateTime.now(),
      title: 'سحب',
      subtitle: 'سحب عبر ${method.toString().split('.').last}',
    );
  }

  /// تحويل
  Future<WalletTransaction?> transfer({
    required double amount,
    required String recipientPhone,
    String? note,
  }) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(seconds: 1));

    return WalletTransaction(
      id: 'txn_transfer_${DateTime.now().millisecondsSinceEpoch}',
      walletId: 'wallet_1',
      userId: 'user_1',
      recipientId: recipientPhone,
      type: TransactionType.transfer,
      status: TransactionStatus.completed,
      amount: amount,
      fee: 50,
      currency: 'YER',
      description: note ?? 'تحويل إلى $recipientPhone',
      createdAt: DateTime.now(),
      title: 'تحويل',
      subtitle: 'إلى: $recipientPhone',
    );
  }

  // ========== الفواتير ==========

  /// الحصول على الفواتير
  Future<List<BillModel>> getBills() async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      BillModel(
        id: 'bill_1',
        name: 'فاتورة الكهرباء',
        category: BillCategory.electricity,
        accountNumber: '123456789',
        amount: 15000,
        dueDate: DateTime.now().add(const Duration(days: 5)),
        provider: 'شركة الكهرباء',
      ),
      BillModel(
        id: 'bill_2',
        name: 'فاتورة الماء',
        category: BillCategory.water,
        accountNumber: '987654321',
        amount: 5000,
        dueDate: DateTime.now().add(const Duration(days: 10)),
        provider: 'شركة الماء',
      ),
      BillModel(
        id: 'bill_3',
        name: 'فاتورة الإنترنت',
        category: BillCategory.internet,
        accountNumber: '555555555',
        amount: 12000,
        dueDate: DateTime.now().add(const Duration(days: 3)),
        provider: 'شركة الإنترنت',
      ),
    ];
  }

  /// دفع فاتورة
  Future<WalletTransaction?> payBill({
    required String billId,
    required double amount,
  }) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(seconds: 1));

    return WalletTransaction(
      id: 'txn_bill_${DateTime.now().millisecondsSinceEpoch}',
      walletId: 'wallet_1',
      userId: 'user_1',
      type: TransactionType.billPayment,
      status: TransactionStatus.completed,
      amount: amount,
      fee: 0,
      currency: 'YER',
      description: 'دفع فاتورة $billId',
      createdAt: DateTime.now(),
      title: 'دفع فاتورة',
      subtitle: 'فاتورة رقم: $billId',
    );
  }

  /// إضافة فاتورة
  Future<bool> addBill(BillModel bill) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }

  // ========== بطاقات الهدايا ==========

  /// الحصول على بطاقات الهدايا
  Future<List<GiftCardModel>> getGiftCards() async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(milliseconds: 500));
    return [];
  }

  /// شراء بطاقة هدايا
  Future<GiftCardModel?> buyGiftCard({
    required double amount,
    String? message,
    String? recipientName,
  }) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(seconds: 1));

    return GiftCardModel(
      id: 'gift_${DateTime.now().millisecondsSinceEpoch}',
      code: 'FLEX${DateTime.now().millisecondsSinceEpoch}',
      amount: amount,
      currency: 'YER',
      expiryDate: DateTime.now().add(const Duration(days: 365)),
      createdAt: DateTime.now(),
      message: message,
      senderName: recipientName,
    );
  }

  /// استبدال بطاقة هدايا
  Future<bool> redeemGiftCard(String code) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  /// التحقق من بطاقة هدايا
  Future<GiftCardModel?> validateGiftCard(String code) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(milliseconds: 500));
    return null;
  }

  // ========== الإحصائيات ==========

  /// الحصول على إحصائيات المحفظة
  Future<WalletStats?> getStats() async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(milliseconds: 500));

    return WalletStats(
      totalTransactions: 150,
      totalDeposits: 500000,
      totalWithdrawals: 200000,
      totalPayments: 150000,
      totalFees: 5000,
      lastActivity: DateTime.now(),
    );
  }

  /// الحصول على الحدود
  Future<WalletLimits?> getLimits() async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(milliseconds: 300));
    return WalletLimits.defaultLimits();
  }
}
