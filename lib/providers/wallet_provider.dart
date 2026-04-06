import 'package:flutter/material.dart';
import '../models/wallet_model.dart';
import '../services/wallet_service.dart';

enum WalletStatus { initial, loading, loaded, error, processing }

class WalletProvider extends ChangeNotifier {
  final WalletService _walletService = WalletService();
  
  // State variables
  WalletStatus _status = WalletStatus.initial;
  String? _errorMessage;
  
  WalletModel? _wallet;
  List<WalletTransaction> _transactions = [];
  List<BillModel> _bills = [];
  List<GiftCardModel> _giftCards = [];
  
  int _currentPage = 1;
  bool _hasMoreTransactions = true;
  
  // Getters
  WalletStatus get status => _status;
  String? get errorMessage => _errorMessage;
  WalletModel? get wallet => _wallet;
  List<WalletTransaction> get transactions => _transactions;
  List<BillModel> get bills => _bills;
  List<GiftCardModel> get giftCards => _giftCards;
  bool get isLoading => _status == WalletStatus.loading;
  bool get hasMore => _hasMoreTransactions;
  
  double get balance => _wallet?.balance ?? 0;
  double get yerBalance => 15000;
  double get sarBalance => 1000;
  double get usdBalance => 100;
  
  String getFormattedTotalBalance() {
    return '${balance.toStringAsFixed(0)} ر.ي';
  }
  
  // Load wallet
  Future<void> loadWallet({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      _transactions = [];
      _hasMoreTransactions = true;
    }
    
    _setStatus(WalletStatus.loading);
    
    try {
      _wallet = await _walletService.getWallet();
      await _loadTransactions(refresh: refresh);
      await _loadBills();
      await _loadGiftCards();
      _setStatus(WalletStatus.loaded);
    } catch (e) {
      _errorMessage = e.toString();
      _setStatus(WalletStatus.error);
    }
  }
  
  Future<void> _loadTransactions({bool refresh = false}) async {
    final transactions = await _walletService.getTransactions();
    if (refresh) {
      _transactions = transactions;
    } else {
      _transactions.addAll(transactions);
    }
    _hasMoreTransactions = transactions.length >= 20;
    _currentPage++;
  }
  
  Future<void> loadMoreTransactions() async {
    if (!_hasMoreTransactions || _status == WalletStatus.loading) return;
    await _loadTransactions();
    notifyListeners();
  }
  
  Future<void> _loadBills() async {
    _bills = await _walletService.getBills();
  }
  
  Future<void> _loadGiftCards() async {
    _giftCards = await _walletService.getGiftCards();
  }
  
  // Deposit
  Future<bool> deposit(double amount, dynamic method) async {
    _setStatus(WalletStatus.processing);
    
    try {
      final transaction = await _walletService.deposit(amount, method);
      if (transaction != null) {
        await loadWallet(refresh: true);
        return true;
      }
      return false;
    } catch (e) {
      _errorMessage = e.toString();
      _setStatus(WalletStatus.error);
      return false;
    }
  }
  
  // Withdraw
  Future<bool> withdraw(double amount, dynamic method) async {
    if (_wallet != null && !_wallet!.hasSufficientBalance(amount)) {
      _errorMessage = 'رصيد غير كافٍ';
      _setStatus(WalletStatus.error);
      return false;
    }
    
    _setStatus(WalletStatus.processing);
    
    try {
      final transaction = await _walletService.withdraw(amount, method);
      if (transaction != null) {
        await loadWallet(refresh: true);
        return true;
      }
      return false;
    } catch (e) {
      _errorMessage = e.toString();
      _setStatus(WalletStatus.error);
      return false;
    }
  }
  
  // Transfer
  Future<bool> transfer(double amount, String recipientPhone, {String? note}) async {
    if (_wallet != null && !_wallet!.hasSufficientBalance(amount)) {
      _errorMessage = 'رصيد غير كافٍ';
      _setStatus(WalletStatus.error);
      return false;
    }
    
    _setStatus(WalletStatus.processing);
    
    try {
      final transaction = await _walletService.transfer(amount, recipientPhone);
      if (transaction != null) {
        await loadWallet(refresh: true);
        return true;
      }
      return false;
    } catch (e) {
      _errorMessage = e.toString();
      _setStatus(WalletStatus.error);
      return false;
    }
  }
  
  // Pay Bill
  Future<bool> payBill(String billId, double amount) async {
    if (_wallet != null && !_wallet!.hasSufficientBalance(amount)) {
      _errorMessage = 'رصيد غير كافٍ';
      _setStatus(WalletStatus.error);
      return false;
    }
    
    _setStatus(WalletStatus.processing);
    
    try {
      final transaction = await _walletService.payBill(billId);
      if (transaction != null) {
        await loadWallet(refresh: true);
        await _loadBills();
        return true;
      }
      return false;
    } catch (e) {
      _errorMessage = e.toString();
      _setStatus(WalletStatus.error);
      return false;
    }
  }
  
  // Gift Cards
  Future<GiftCardModel?> buyGiftCard(double amount) async {
    _setStatus(WalletStatus.processing);
    
    try {
      final giftCard = await _walletService.buyGiftCard(amount);
      if (giftCard != null) {
        await loadWallet(refresh: true);
        await _loadGiftCards();
        return giftCard;
      }
      return null;
    } catch (e) {
      _errorMessage = e.toString();
      _setStatus(WalletStatus.error);
      return null;
    }
  }
  
  Future<bool> redeemGiftCard(String code) async {
    _setStatus(WalletStatus.processing);
    
    try {
      final result = await _walletService.redeemGiftCard(code);
      if (result) {
        await loadWallet(refresh: true);
        await _loadGiftCards();
        return true;
      }
      return false;
    } catch (e) {
      _errorMessage = e.toString();
      _setStatus(WalletStatus.error);
      return false;
    }
  }
  
  // Refresh
  Future<void> refreshBalances() async {
    await loadWallet(refresh: true);
  }
  
  // Reset
  void reset() {
    _status = WalletStatus.initial;
    _errorMessage = null;
    _wallet = null;
    _transactions = [];
    _bills = [];
    _giftCards = [];
    _currentPage = 1;
    _hasMoreTransactions = true;
    notifyListeners();
  }
  
  void clearError() {
    _errorMessage = null;
    if (_status == WalletStatus.error) {
      _status = WalletStatus.loaded;
    }
    notifyListeners();
  }
  
  void _setStatus(WalletStatus status) {
    _status = status;
    notifyListeners();
  }
}

  Future<void> loadTransactions() async {
    await _loadTransactions();
  }

  double get availableBalance => balance;

  Future<void> loadTransactions() async {
    await _loadTransactions();
  }
  
  double get availableBalance => _wallet?.balance ?? 0;
