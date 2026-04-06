import 'package:flutter/material.dart';
import '../../theme/color_constants.dart';
import '../../widgets/common/custom_button.dart';

class BanksWalletsScreen extends StatefulWidget {
  const BanksWalletsScreen({super.key});

  @override
  State<BanksWalletsScreen> createState() => _BanksWalletsScreenState();
}

class _BanksWalletsScreenState extends State<BanksWalletsScreen> {
  int _selectedTab = 0;
  
  final List<BankModel> banks = [
    BankModel(name: 'البنك المركزي اليمني', icon: '🏦', color: 0xFF1B5E20),
    BankModel(name: 'بنك اليمن الدولي', icon: '🏛️', color: 0xFF0D47A1),
    BankModel(name: 'بنك التسليف', icon: '🏢', color: 0xFFE65100),
    BankModel(name: 'بنك الكريمي', icon: '🏦', color: 0xFF004D40),
  ];
  
  final List<WalletModel> wallets = [
    WalletModel(name: 'محفظة فلكس', icon: '💳', balance: '15,000 ر.ي'),
    WalletModel(name: 'محفظة جيب', icon: '👛', balance: '5,000 ر.ي'),
    WalletModel(name: 'محفظة كاش', icon: '💰', balance: '2,500 ر.ي'),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[50],
      appBar: AppBar(
        title: const Text('البنوك والمحافظ'),
        backgroundColor: AppColors.goldColor,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          // تبويبات
          Container(
            color: isDark ? Colors.grey[850] : Colors.white,
            child: Row(
              children: [
                _buildTab('البنوك', 0),
                _buildTab('المحافظ', 1),
              ],
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: _selectedTab,
              children: [
                _buildBanksList(),
                _buildWalletsList(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.goldColor,
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
  
  Widget _buildTab(String title, int index) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? AppColors.goldColor : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? AppColors.goldColor : null,
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildBanksList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: banks.length,
      itemBuilder: (context, index) {
        final bank = banks[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(bank.color),
              child: Text(bank.icon, style: const TextStyle(fontSize: 24)),
            ),
            title: Text(bank.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text('حساب بنكي'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        );
      },
    );
  }
  
  Widget _buildWalletsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: wallets.length,
      itemBuilder: (context, index) {
        final wallet = wallets[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.goldColor.withOpacity(0.2),
              child: Text(wallet.icon, style: const TextStyle(fontSize: 24)),
            ),
            title: Text(wallet.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(wallet.balance),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        );
      },
    );
  }
}

class BankModel {
  final String name;
  final String icon;
  final int color;
  BankModel({required this.name, required this.icon, required this.color});
}

class WalletModel {
  final String name;
  final String icon;
  final String balance;
  WalletModel({required this.name, required this.icon, required this.balance});
}
