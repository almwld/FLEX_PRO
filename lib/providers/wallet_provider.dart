
import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/services.dart';

/// حالات المحفظة
enum WalletStatus {
  initial,
  loading,
  loaded,
  error,
  processing,
}

/// Provider المحفظة
class WalletProvider extends ChangeNotifier {
  final WalletService _walletService;
  final LocalStorageService _storageService;

  WalletProvider({
    required WalletService walletService,
    required LocalStorageService storageService,
  })  : _walletService = walletService,
        _storageService = storageService;

  // ========== الحالة ==========
  WalletStatus _status = WalletStatus.initial;
  WalletModel? _wallet;
  List<WalletTransaction> _transactions = [];
  List<BillModel> _bills = [];
  List<GiftCardModel> _giftCards = [];
  String? _errorMessage;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  int _currentPage = 1;
  bool _hasMoreTransactions = true;

  // ========== Getters ==========
  WalletStatus get status => _status;
  WalletModel? get wallet => _wallet;
  List<WalletTransaction> get transactions => _transactions;
  List<BillModel> get bills => _bills;
  List<GiftCardModel> get giftCards => _giftCards;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  bool get hasWallet => _wallet != null;
  double get balance => _wallet?.balance ?? 0.0;
  double get availableBalance => _wallet?.availableBalance ?? 0.0;
  bool get hasMoreTransactions => _hasMoreTransactions;

  // ========== Methods ==========

  /// تحميل بيانات المحفظة
  Future<void> loadWallet({bool refresh = false}) async {
    if (_isLoading && !refresh) return;

    _setLoading(true);
    _clearError();
    try {
      final wallet = await _walletService.getWallet();
      if (wallet != null) {
        _wallet = wallet;
        _status = WalletStatus.loaded;
      } else {
        _errorMessage = 'فشل تحميل بيانات المحفظة';
        _status = WalletStatus.error;
      }
    } catch (e) {
      _errorMessage = e.toString();
      _status = WalletStatus.error;
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  /// تحميل المعاملات
  Future<void> loadTransactions({
    bool refresh = false,
    int page = 1,
    int limit = 20,
  }) async {
    if (refresh) {
      _currentPage = 1;
      _transactions = [];
      _hasMoreTransactions = true;
    }

    if (_isLoadingMore || !_hasMoreTransactions) return;

    if (page > 1) {
      _isLoadingMore = true;
    } else {
      _setLoading(true);
    }

    try {
      final transactions = await _walletService.getTransactions(
        page: _currentPage,
        limit: limit,
      );

      if (transactions.isNotEmpty) {
        if (page == 1) {
          _transactions = transactions;
        } else {
          _transactions.addAll(transactions);
        }
        _currentPage++;
        _hasMoreTransactions = transactions.length >= limit;
      } else {
        _hasMoreTransactions = false;
      }

      _status = WalletStatus.loaded;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
      _isLoadingMore = false;
      notifyListeners();
    }
  }

  /// تحميل المزيد من المعاملات
  Future<void> loadMoreTransactions() async {
    await loadTransactions(page: _currentPage);
  }

  /// إيداع
  Future<bool> deposit({
    required double amount,
    required PaymentMethod method,
    Map<String, dynamic>? metadata,
  }) async {
    _setProcessing();
    _clearError();
    try {
      final transaction = await _walletService.deposit(
        amount: amount,
        method: method,
        metadata: metadata,
      );

      if (transaction != null) {
        _transactions.insert(0, transaction);
        await loadWallet(refresh: true);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _errorMessage = e.toString();
      _status = WalletStatus.error;
      notifyListeners();
      return false;
    }
  }

  /// سحب
  Future<bool> withdraw({
    required double amount,
    required PaymentMethod method,
    Map<String, dynamic>? metadata,
  }) async {
    _setProcessing();
    _clearError();
    try {
      if (_wallet != null && !_wallet!.hasSufficientBalance(amount)) {
        _errorMessage = 'رصيد غير كافٍ';
        _status = WalletStatus.error;
        notifyListeners();
        return false;
      }

      final transaction = await _walletService.withdraw(
        amount: amount,
        method: method,
        metadata: metadata,
      );

      if (transaction != null) {
        _transactions.insert(0, transaction);
        await loadWallet(refresh: true);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _errorMessage = e.toString();
      _status = WalletStatus.error;
      notifyListeners();
      return false;
    }
  }

  /// تحويل
  Future<bool> transfer({
    required double amount,
    required String recipientPhone,
    String? note,
  }) async {
    _setProcessing();
    _clearError();
    try {
      if (_wallet != null && !_wallet!.hasSufficientBalance(amount)) {
        _errorMessage = 'رصيد غير كافٍ';
        _status = WalletStatus.error;
        notifyListeners();
        return false;
      }

      final transaction = await _walletService.transfer(
        amount: amount,
        recipientPhone: recipientPhone,
        note: note,
      );

      if (transaction != null) {
        _transactions.insert(0, transaction);
        await loadWallet(refresh: true);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _errorMessage = e.toString();
      _status = WalletStatus.error;
      notifyListeners();
      return false;
    }
  }

  /// دفع فاتورة
  Future<bool> payBill({
    required String billId,
    required double amount,
  }) async {
    _setProcessing();
    _clearError();
    try {
      if (_wallet != null && !_wallet!.hasSufficientBalance(amount)) {
        _errorMessage = 'رصيد غير كافٍ';
        _status = WalletStatus.error;
        notifyListeners();
        return false;
      }

      final transaction = await _walletService.payBill(
        billId: billId,
        amount: amount,
      );

      if (transaction != null) {
        _transactions.insert(0, transaction);
        await loadWallet(refresh: true);
        await loadBills();
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _errorMessage = e.toString();
      _status = WalletStatus.error;
      notifyListeners();
      return false;
    }
  }

  /// تحميل الفواتير
  Future<void> loadBills() async {
    _setLoading(true);
    try {
      final bills = await _walletService.getBills();
      _bills = bills;
      _status = WalletStatus.loaded;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  /// شراء بطاقة هدايا
  Future<GiftCardModel?> buyGiftCard({
    required double amount,
    String? message,
    String? recipientName,
  }) async {
    _setProcessing();
    _clearError();
    try {
      if (_wallet != null && !_wallet!.hasSufficientBalance(amount)) {
        _errorMessage = 'رصيد غير كافٍ';
        _status = WalletStatus.error;
        notifyListeners();
        return null;
      }

      final giftCard = await _walletService.buyGiftCard(
        amount: amount,
        message: message,
        recipientName: recipientName,
      );

      if (giftCard != null) {
        _giftCards.insert(0, giftCard);
        await loadWallet(refresh: true);
        notifyListeners();
      }
      return giftCard;
    } catch (e) {
      _errorMessage = e.toString();
      _status = WalletStatus.error;
      notifyListeners();
      return null;
    }
  }

  /// استبدال بطاقة هدايا
  Future<bool> redeemGiftCard(String code) async {
    _setProcessing();
    _clearError();
    try {
      final result = await _walletService.redeemGiftCard(code);
      if (result) {
        await loadWallet(refresh: true);
        notifyListeners();
      } else {
        _errorMessage = 'رمز البطاقة غير صالح';
        _status = WalletStatus.error;
        notifyListeners();
      }
      return result;
    } catch (e) {
      _errorMessage = e.toString();
      _status = WalletStatus.error;
      notifyListeners();
      return false;
    }
  }

  /// تحميل بطاقات الهدايا
  Future<void> loadGiftCards() async {
    _setLoading(true);
    try {
      final giftCards = await _walletService.getGiftCards();
      _giftCards = giftCards;
      _status = WalletStatus.loaded;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  /// الحصول على تفاصيل المعاملة
  Future<WalletTransaction?> getTransactionDetails(String transactionId) async {
    try {
      return await _walletService.getTransactionDetails(transactionId);
    } catch (e) {
      _errorMessage = e.toString();
      return null;
    }
  }

  /// البحث في المعاملات
  Future<List<WalletTransaction>> searchTransactions(String query) async {
    try {
      return await _walletService.searchTransactions(query);
    } catch (e) {
      _errorMessage = e.toString();
      return [];
    }
  }

  /// تصفية المعاملات حسب النوع
  List<WalletTransaction> filterByType(TransactionType type) {
    return _transactions.where((t) => t.type == type).toList();
  }

  /// تصفية المعاملات حسب التاريخ
  List<WalletTransaction> filterByDateRange(DateTime start, DateTime end) {
    return _transactions.where((t) {
      return t.createdAt.isAfter(start) && t.createdAt.isBefore(end);
    }).toList();
  }

  /// مسح الخطأ
  void clearError() {
    _clearError();
    notifyListeners();
  }

  /// إعادة تعيين الحالة
  void reset() {
    _status = WalletStatus.initial;
    _wallet = null;
    _transactions = [];
    _bills = [];
    _giftCards = [];
    _errorMessage = null;
    _currentPage = 1;
    _hasMoreTransactions = true;
    notifyListeners();
  }

  // ========== Private Methods ==========

  void _setLoading(bool value) {
    _isLoading = value;
    if (value) {
      _status = WalletStatus.loading;
    }
  }

  void _setProcessing() {
    _status = WalletStatus.processing;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    if (_status == WalletStatus.error) {
      _status = WalletStatus.initial;
    }
  }
}
