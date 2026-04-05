// lib/screens/home/home_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/providers.dart';
import '../../theme/app_theme.dart';
import '../../widgets/widgets.dart';
import '../wallet/wallet_screen.dart';
import '../market/market_screen.dart';
import '../orders/orders_screen.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const _HomeContent(),
    const WalletScreen(),
    const MarketScreen(),
    const OrdersScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.home_outlined, Icons.home, 'الرئيسية', 0),
                _buildNavItem(Icons.account_balance_wallet_outlined,
                    Icons.account_balance_wallet, 'المحفظة', 1),
                _buildNavItem(
                    Icons.shopping_bag_outlined, Icons.shopping_bag, 'السوق', 2),
                _buildNavItem(
                    Icons.receipt_long_outlined, Icons.receipt_long, 'الطلبات', 3),
                _buildNavItem(
                    Icons.person_outline, Icons.person, 'حسابي', 4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      IconData icon, IconData activeIcon, String label, int index) {
    final isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.goldPrimary.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? AppColors.goldPrimary : Colors.grey,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.goldPrimary : Colors.grey,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// محتوى الصفحة الرئيسية
class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final authProvider = Provider.of<AuthProvider>(context);
    final walletProvider = Provider.of<WalletProvider>(context);

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // شريط التطبيق
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // صورة المستخدم
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.goldPrimary.withOpacity(0.2),
                    backgroundImage: authProvider.userAvatar != null
                        ? NetworkImage(authProvider.userAvatar!)
                        : null,
                    child: authProvider.userAvatar == null
                        ? Icon(
                            Icons.person,
                            color: AppColors.goldPrimary,
                          )
                        : null,
                  ),
                  const SizedBox(width: 12),
                  // الترحيب
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'أهلاً، ${authProvider.userName ?? 'زائر'}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          'مرحباً بك في فليكس يمن',
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark
                                ? Colors.grey[400]
                                : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // الإشعارات
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/notifications');
                    },
                    icon: Stack(
                      children: [
                        Icon(
                          Icons.notifications_outlined,
                          color: isDark ? Colors.white : AppColors.textPrimary,
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // بطاقة الرصيد
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _BalanceCard(
                balance: walletProvider.balance,
                onDeposit: () {
                  Navigator.of(context).pushNamed('/wallet/deposit');
                },
                onTransfer: () {
                  Navigator.of(context).pushNamed('/wallet/transfer');
                },
                onPay: () {
                  Navigator.of(context).pushNamed('/wallet/pay');
                },
              ),
            ),
          ),
          // الخدمات السريعة
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الخدمات السريعة',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _QuickServiceItem(
                        icon: Icons.phone_android,
                        label: 'شحن رصيد',
                        onTap: () {
                          Navigator.of(context).pushNamed('/services/recharge');
                        },
                      ),
                      _QuickServiceItem(
                        icon: Icons.wifi,
                        label: 'باقات إنترنت',
                        onTap: () {
                          Navigator.of(context).pushNamed('/services/internet');
                        },
                      ),
                      _QuickServiceItem(
                        icon: Icons.receipt,
                        label: 'فواتير',
                        onTap: () {
                          Navigator.of(context).pushNamed('/wallet/bills');
                        },
                      ),
                      _QuickServiceItem(
                        icon: Icons.card_giftcard,
                        label: 'بطاقات',
                        onTap: () {
                          Navigator.of(context).pushNamed('/wallet/gift-cards');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // العروض
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'عروض خاصة',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/offers');
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
          // قائمة العروض
          SliverToBoxAdapter(
            child: SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return _OfferCard(
                    title: 'عرض ${index + 1}',
                    subtitle: 'خصم ${(index + 1) * 10}%',
                    color: [
                      Colors.blue,
                      Colors.green,
                      Colors.orange,
                      Colors.purple,
                      Colors.red,
                    ][index],
                  );
                },
              ),
            ),
          ),
          // آخر المعاملات
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'آخر المعاملات',
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
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: TransactionListItem(
                    transaction: WalletTransaction(
                      id: 'txn_$index',
                      walletId: 'wallet_1',
                      userId: 'user_1',
                      type: index % 2 == 0
                          ? TransactionType.deposit
                          : TransactionType.payment,
                      status: TransactionStatus.completed,
                      amount: (index + 1) * 1000.0,
                      fee: 0,
                      currency: 'YER',
                      createdAt: DateTime.now().subtract(Duration(days: index)),
                      title: index % 2 == 0 ? 'إيداع' : 'دفع',
                      subtitle: index % 2 == 0 ? 'إيداع نقدي' : 'شراء منتج',
                    ),
                  ),
                );
              },
              childCount: 5,
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
        ],
      ),
    );
  }
}

/// بطاقة الرصيد
class _BalanceCard extends StatelessWidget {
  final double balance;
  final VoidCallback onDeposit;
  final VoidCallback onTransfer;
  final VoidCallback onPay;

  const _BalanceCard({
    required this.balance,
    required this.onDeposit,
    required this.onTransfer,
    required this.onPay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.goldPrimary,
            AppColors.goldDark,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.goldPrimary.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'الرصيد المتاح',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.visibility_outlined,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${balance.toStringAsFixed(0)} ر.ي',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ActionButton(
                icon: Icons.add,
                label: 'إيداع',
                onTap: onDeposit,
              ),
              _ActionButton(
                icon: Icons.swap_horiz,
                label: 'تحويل',
                onTap: onTransfer,
              ),
              _ActionButton(
                icon: Icons.qr_code_scanner,
                label: 'دفع',
                onTap: onPay,
              ),
            ],
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
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

/// عنصر الخدمة السريعة
class _QuickServiceItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickServiceItem({
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
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.darkSurface
                  : AppColors.goldPrimary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: AppColors.goldPrimary,
              size: 28,
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

/// بطاقة العرض
class _OfferCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;

  const _OfferCard({
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color,
            color.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'عرض محدود',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
