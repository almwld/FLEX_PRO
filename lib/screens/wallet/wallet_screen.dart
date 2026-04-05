// lib/screens/wallet/wallet_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/providers.dart';
import '../../theme/app_theme.dart';
import '../../widgets/widgets.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WalletProvider>().loadWallet();
      context.read<WalletProvider>().loadTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final walletProvider = Provider.of<WalletProvider>(context);

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // شريط التطبيق
            SliverAppBar(
              floating: true,
              backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
              elevation: 0,
              title: Text(
                'محفظتي',
                style: TextStyle(
                  color: isDark ? Colors.white : AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/wallet/settings');
                  },
                  icon: Icon(
                    Icons.settings_outlined,
                    color: isDark ? Colors.white : AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            // بطاقة الرصيد
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: _BalanceCard(
                  balance: walletProvider.balance,
                  availableBalance: walletProvider.availableBalance,
                ),
              ),
            ),
            // الإجراءات السريعة
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: _ActionButton(
                        icon: Icons.add,
                        label: 'إيداع',
                        onTap: () {
                          Navigator.of(context).pushNamed('/wallet/deposit');
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ActionButton(
                        icon: Icons.arrow_upward,
                        label: 'سحب',
                        onTap: () {
                          Navigator.of(context).pushNamed('/wallet/withdraw');
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ActionButton(
                        icon: Icons.swap_horiz,
                        label: 'تحويل',
                        onTap: () {
                          Navigator.of(context).pushNamed('/wallet/transfer');
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ActionButton(
                        icon: Icons.receipt,
                        label: 'فواتير',
                        onTap: () {
                          Navigator.of(context).pushNamed('/wallet/bills');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // الخدمات
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'الخدمات',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 4,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 8,
                      children: [
                        _ServiceItem(
                          icon: Icons.phone_android,
                          label: 'شحن',
                          onTap: () {
                            Navigator.of(context).pushNamed('/services/recharge');
                          },
                        ),
                        _ServiceItem(
                          icon: Icons.wifi,
                          label: 'إنترنت',
                          onTap: () {
                            Navigator.of(context).pushNamed('/services/internet');
                          },
                        ),
                        _ServiceItem(
                          icon: Icons.tv,
                          label: 'تلفزيون',
                          onTap: () {
                            Navigator.of(context).pushNamed('/services/tv');
                          },
                        ),
                        _ServiceItem(
                          icon: Icons.electric_bolt,
                          label: 'كهرباء',
                          onTap: () {
                            Navigator.of(context).pushNamed('/services/electricity');
                          },
                        ),
                        _ServiceItem(
                          icon: Icons.water_drop,
                          label: 'ماء',
                          onTap: () {
                            Navigator.of(context).pushNamed('/services/water');
                          },
                        ),
                        _ServiceItem(
                          icon: Icons.card_giftcard,
                          label: 'هدايا',
                          onTap: () {
                            Navigator.of(context).pushNamed('/wallet/gift-cards');
                          },
                        ),
                        _ServiceItem(
                          icon: Icons.qr_code_scanner,
                          label: 'مسح QR',
                          onTap: () {
                            Navigator.of(context).pushNamed('/wallet/scan');
                          },
                        ),
                        _ServiceItem(
                          icon: Icons.more_horiz,
                          label: 'المزيد',
                          onTap: () {
                            Navigator.of(context).pushNamed('/services');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // المعاملات الأخيرة
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'المعاملات الأخيرة',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : AppColors.textPrimary,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/wallet/transactions');
                      },
                      child: Text(
                        'عرض الكل',
                        style: TextStyle(
                          color: AppColors.goldPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // قائمة المعاملات
            if (walletProvider.isLoading)
              const SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            else if (walletProvider.transactions.isEmpty)
              SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        Icon(
                          Icons.receipt_long_outlined,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'لا توجد معاملات',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final transaction = walletProvider.transactions[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: TransactionListItem(
                        transaction: transaction,
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            '/wallet/transaction-details',
                            arguments: transaction.id,
                          );
                        },
                      ),
                    );
                  },
                  childCount: walletProvider.transactions.length > 5
                      ? 5
                      : walletProvider.transactions.length,
                ),
              ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
          ],
        ),
      ),
    );
  }
}

/// بطاقة الرصيد
class _BalanceCard extends StatelessWidget {
  final double balance;
  final double availableBalance;

  const _BalanceCard({
    required this.balance,
    required this.availableBalance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.goldPrimary,
            AppColors.goldDark,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.goldPrimary.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'الرصيد الكلي',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${balance.toStringAsFixed(0)} ر.ي',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  color: Colors.white70,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'الرصيد المتاح: ${availableBalance.toStringAsFixed(0)} ر.ي',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// زر الإجراء
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.goldPrimary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: AppColors.goldPrimary,
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: AppColors.goldPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// عنصر الخدمة
class _ServiceItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ServiceItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.darkSurface
                  : Colors.grey[100],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: AppColors.goldPrimary,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.grey[400] : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
