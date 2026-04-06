import '../models/wallet_model.dart';

class WalletService {
  Future<WalletModel?> getWallet() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return WalletModel(id: '1', balance: 15000, currency: 'YER');
  }
  
  Future<WalletBalance?> getBalance() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return WalletBalance(total: 15000, yerBalance: 15000, sarBalance: 1000, usdBalance: 100);
  }
  
  Future<List<WalletTransaction>> getTransactions() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [];
  }
  
  Future<WalletTransaction?> deposit(double amount, dynamic method) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return null;
  }
  
  Future<WalletTransaction?> withdraw(double amount, dynamic method) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return null;
  }
  
  Future<WalletTransaction?> transfer(double amount, String recipient) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return null;
  }
  
  Future<List<BillModel>> getBills() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [];
  }
  
  Future<WalletTransaction?> payBill(String billId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return null;
  }
  
  Future<List<GiftCardModel>> getGiftCards() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [];
  }
  
  Future<GiftCardModel?> buyGiftCard(double amount) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return null;
  }
  
  Future<WalletStats?> getStats() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return WalletStats(totalSpent: 0, totalReceived: 0, transactionCount: 0);
  }
  
  Future<WalletLimits?> getLimits() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return WalletLimits.defaultLimits();
  }
}
