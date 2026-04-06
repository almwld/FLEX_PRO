import 'package:flutter/material.dart';
import '../models/wallet_model.dart';
import '../services/wallet_service.dart';

enum WalletStatus { initial, loading, loaded, error, processing }

class WalletProvider extends ChangeNotifier {
  final WalletService _walletService = WalletService();
  
  WalletStatus _status = WalletStatus.initial;
  String? _errorMessage;
  WalletModel? _wallet;
  List<WalletTransaction> _transactions = [];
  List<BillModel> _bills = [];
  List<GiftCardModel> _giftCards = [];
  
  WalletStatus get status => _status;
  String? get errorMessage => _errorMessage;
  WalletModel? get wallet => _wallet;
  List<WalletTransaction> get transactions => _transactions;
  List<BillModel> get bills => _bills;
  List<GiftCardModel> get giftCards => _giftCards;
  bool get isLoading => _status == WalletStatus.loading;
  
  double get balance => _wallet?.balance ?? 0;
  double get availableBalance => _wallet?.balance ?? 0;
  double get yerBalance => 15000;
  double get sarBalance => 1000;
  double get usdBalance => 100;
  
  String getFormattedTotalBalance() => '${balance.toStringAsFixed(0)} ر.ي';
  
  Future<void> loadWallet() async {
    _status = WalletStatus.loading;
    notifyListeners();
    
    try {
      _wallet = await _walletService.getWallet();
      _transactions = await _walletService.getTransactions();
      _bills = await _walletService.getBills();
      _giftCards = await _walletService.getGiftCards();
      _status = WalletStatus.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _status = WalletStatus.error;
    }
    notifyListeners();
  }
  
  Future<bool> deposit(double amount, dynamic method) async {
    _status = WalletStatus.processing;
    notifyListeners();
    
    try {
      final result = await _walletService.deposit(amount, method);
      if (result != null) {
        await loadWallet();
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
  
  Future<bool> withdraw(double amount, dynamic method) async {
    if (_wallet != null && _wallet!.balance < amount) {
      _errorMessage = 'رصيد غير كافٍ';
      _status = WalletStatus.error;
      notifyListeners();
      return false;
    }
    
    _status = WalletStatus.processing;
    notifyListeners();
    
    try {
      final result = await _walletService.withdraw(amount, method);
      if (result != null) {
        await loadWallet();
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
  
  Future<bool> transfer(double amount, String recipient, {String? note}) async {
    if (_wallet != null && _wallet!.balance < amount) {
      _errorMessage = 'رصيد غير كافٍ';
      _status = WalletStatus.error;
      notifyListeners();
      return false;
    }
    
    _status = WalletStatus.processing;
    notifyListeners();
    
    try {
      final result = await _walletService.transfer(amount, recipient);
      if (result != null) {
        await loadWallet();
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
  
  Future<bool> payBill(String billId, double amount) async {
    if (_wallet != null && _wallet!.balance < amount) {
      _errorMessage = 'رصيد غير كافٍ';
      _status = WalletStatus.error;
      notifyListeners();
      return false;
    }
    
    _status = WalletStatus.processing;
    notifyListeners();
    
    try {
      final result = await _walletService.payBill(billId);
      if (result != null) {
        await loadWallet();
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
  
  Future<GiftCardModel?> buyGiftCard(double amount) async {
    _status = WalletStatus.processing;
    notifyListeners();
    
    try {
      final result = await _walletService.buyGiftCard(amount);
      if (result != null) {
        await loadWallet();
        return result;
      }
      return null;
    } catch (e) {
      _errorMessage = e.toString();
      _status = WalletStatus.error;
      notifyListeners();
      return null;
    }
  }
  
  Future<bool> redeemGiftCard(String code) async {
    _status = WalletStatus.processing;
    notifyListeners();
    
    try {
      final result = await _walletService.redeemGiftCard(code);
      if (result) {
        await loadWallet();
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
  
  void clearError() {
    _errorMessage = null;
    if (_status == WalletStatus.error) {
      _status = WalletStatus.loaded;
    }
    notifyListeners();
  }
}

  Future<void> loadTransactions() async {
    await loadWallet();
  }
