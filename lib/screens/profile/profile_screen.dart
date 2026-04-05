// lib/screens/profile/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/providers.dart';
import '../../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final authProvider = Provider.of<AuthProvider>(context);

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
                'حسابي',
                style: TextStyle(
                  color: isDark ? Colors.white : AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/settings');
                  },
                  icon: Icon(
                    Icons.settings_outlined,
                    color: isDark ? Colors.white : AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            // معلومات المستخدم
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: _ProfileHeader(
                  name: authProvider.userName ?? 'مستخدم',
                  email: authProvider.userEmail ?? '',
                  phone: authProvider.userPhone ?? '',
                  avatarUrl: authProvider.userAvatar,
                  isPro: authProvider.isPro,
                  proLevel: authProvider.proLevel,
                ),
              ),
            ),
            // الإحصائيات
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        value: '12',
                        label: 'طلب',
                        icon: Icons.shopping_bag_outlined,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        value: '5',
                        label: 'مفضلة',
                        icon: Icons.favorite_outline,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        value: '150',
                        label: 'نقطة',
                        icon: Icons.stars_outlined,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // القائمة
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'الحساب',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _MenuItem(
                      icon: Icons.person_outline,
                      title: 'تعديل الملف الشخصي',
                      onTap: () {
                        Navigator.of(context).pushNamed('/profile/edit');
                      },
                    ),
                    _MenuItem(
                      icon: Icons.location_on_outlined,
                      title: 'عناويني',
                      onTap: () {
                        Navigator.of(context).pushNamed('/profile/addresses');
                      },
                    ),
                    _MenuItem(
                      icon: Icons.payment_outlined,
                      title: 'طرق الدفع',
                      onTap: () {
                        Navigator.of(context).pushNamed('/profile/payment-methods');
                      },
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'الإعدادات',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _MenuItem(
                      icon: Icons.notifications_outlined,
                      title: 'الإشعارات',
                      onTap: () {
                        Navigator.of(context).pushNamed('/settings/notifications');
                      },
                    ),
                    _MenuItem(
                      icon: Icons.security_outlined,
                      title: 'الأمان',
                      onTap: () {
                        Navigator.of(context).pushNamed('/settings/security');
                      },
                    ),
                    _MenuItem(
                      icon: Icons.language_outlined,
                      title: 'اللغة',
                      trailing: Text(
                        'العربية',
                        style: TextStyle(
                          color: AppColors.goldPrimary,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed('/settings/language');
                      },
                    ),
                    _MenuItem(
                      icon: isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                      title: 'الوضع المظلم',
                      trailing: Switch(
                        value: isDark,
                        onChanged: (value) {
                          final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
                          themeProvider.setDarkMode(value);
                        },
                        activeColor: AppColors.goldPrimary,
                      ),
                      onTap: null,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'الدعم',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _MenuItem(
                      icon: Icons.help_outline,
                      title: 'المساعدة والدعم',
                      onTap: () {
                        Navigator.of(context).pushNamed('/support');
                      },
                    ),
                    _MenuItem(
                      icon: Icons.info_outline,
                      title: 'عن التطبيق',
                      onTap: () {
                        Navigator.of(context).pushNamed('/about');
                      },
                    ),
                    _MenuItem(
                      icon: Icons.privacy_tip_outlined,
                      title: 'الشروط والأحكام',
                      onTap: () {
                        Navigator.of(context).pushNamed('/terms');
                      },
                    ),
                    const SizedBox(height: 24),
                    // تسجيل الخروج
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          final confirmed = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('تسجيل الخروج'),
                              content: const Text('هل أنت متأكد من تسجيل الخروج؟'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(false),
                                  child: const Text('إلغاء'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(true),
                                  child: const Text('تسجيل الخروج'),
                                ),
                              ],
                            ),
                          );

                          if (confirmed == true && context.mounted) {
                            await authProvider.logout();
                            if (context.mounted) {
                              Navigator.of(context).pushReplacementNamed('/login');
                            }
                          }
                        },
                        icon: const Icon(Icons.logout),
                        label: const Text('تسجيل الخروج'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// رأس الملف الشخصي
class _ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String? avatarUrl;
  final bool isPro;
  final int proLevel;

  const _ProfileHeader({
    required this.name,
    required this.email,
    required this.phone,
    this.avatarUrl,
    required this.isPro,
    required this.proLevel,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.goldPrimary.withOpacity(0.2),
                backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
                child: avatarUrl == null
                    ? Icon(
                        Icons.person,
                        size: 40,
                        color: AppColors.goldPrimary,
                      )
                    : null,
              ),
              if (isPro)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.goldPrimary,
                          AppColors.goldLight,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'PRO',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  email.isNotEmpty ? email : phone,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.grey[400] : AppColors.textSecondary,
                  ),
                ),
                if (isPro) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.goldPrimary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'المستوى $proLevel',
                      style: TextStyle(
                        color: AppColors.goldPrimary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/profile/edit');
            },
            icon: Icon(
              Icons.edit_outlined,
              color: AppColors.goldPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

/// بطاقة إحصائية
class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const _StatCard({
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
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
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
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

/// عنصر القائمة
class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.goldPrimary,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDark ? Colors.white : AppColors.textPrimary,
        ),
      ),
      trailing: trailing ??
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: isDark ? Colors.grey[400] : AppColors.textSecondary,
          ),
      onTap: onTap,
    );
  }
}
