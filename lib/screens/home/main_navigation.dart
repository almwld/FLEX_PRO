import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/view_mode_provider.dart';
import '../wallet/wallet_screen.dart';
import '../market/market_screen.dart';
import '../orders/orders_screen.dart';
import '../profile/profile_screen.dart';
import '../home/home_screen.dart';
import '../pro/pro_dashboard_screen.dart';
import '../../theme/color_constants.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const WalletScreen(),
    const MarketScreen(),
    const OrdersScreen(),
    const ProfileScreen(),
  ];

  final List<String> _titles = [
    'الرئيسية',
    'المحفظة',
    'السوق',
    'الطلبات',
    'حسابي',
  ];

  @override
  Widget build(BuildContext context) {
    final viewMode = context.watch<ViewModeProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // إذا كان وضع PRO، أضف شاشة PRO
    final screens = viewMode.isPro
        ? [_screens[0], _screens[1], _screens[2], _screens[3], _screens[4]]
        : _screens;

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[850] : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              _titles.length,
              (index) => _buildNavItem(
                index: index,
                title: _titles[index],
                isSelected: _currentIndex == index,
                onTap: () => setState(() => _currentIndex = index),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final icons = [
      Icons.home_outlined,
      Icons.account_balance_wallet_outlined,
      Icons.shopping_bag_outlined,
      Icons.receipt_long_outlined,
      Icons.person_outline,
    ];
    final activeIcons = [
      Icons.home,
      Icons.account_balance_wallet,
      Icons.shopping_bag,
      Icons.receipt_long,
      Icons.person,
    ];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcons[index] : icons[index],
              color: isSelected ? AppColors.goldColor : Colors.grey,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? AppColors.goldColor : Colors.grey,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
