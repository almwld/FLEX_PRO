import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../theme/color_constants.dart';
import '../../providers/view_mode_provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/common/custom_button.dart';

class ModeSwitchScreen extends StatelessWidget {
  const ModeSwitchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final viewModeProvider = context.watch<ViewModeProvider>();

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 40),
              
              // الشعار
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  gradient: AppTheme.goldGradient,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.goldColor.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.shopping_bag,
                  size: 50,
                  color: Colors.black,
                ),
              )
              .animate()
              .scale(duration: 500.ms, curve: Curves.easeOutBack),
              
              const SizedBox(height: 24),
              
              // اسم التطبيق
              const Text(
                'Flex Yemen',
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.goldColor,
                ),
              )
              .animate()
              .fadeIn(delay: 200.ms)
              .slideY(begin: 0.2),
              
              const SizedBox(height: 8),
              
              Text(
                'اختر وضع الاستخدام المناسب لك',
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 16,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
              )
              .animate()
              .fadeIn(delay: 300.ms),
              
              const SizedBox(height: 40),
              
              // خيارات الوضع
              Expanded(
                child: ListView(
                  children: [
                    _buildModeCard(
                      context,
                      title: 'وضع Lite',
                      description: 'واجهة بسيطة مع الميزات الأساسية',
                      icon: Icons.flash_on,
                      color: Colors.grey,
                      features: const [
                        'تصفح المنتجات',
                        'إدارة الطلبات',
                        'المحفظة الإلكترونية',
                        'واجهة سهلة الاستخدام',
                      ],
                      isSelected: viewModeProvider.isLite,
                      onTap: () => viewModeProvider.setLiteMode(),
                    )
                    .animate()
                    .fadeIn(delay: 400.ms)
                    .slideX(begin: -0.2),
                    
                    const SizedBox(height: 16),
                    
                    _buildModeCard(
                      context,
                      title: 'وضع PRO',
                      description: 'ميزات متقدمة وإحصائيات مفصلة',
                      icon: Icons.workspace_premium,
                      color: AppColors.goldColor,
                      features: const [
                        'جميع ميزات Lite',
                        '10 أسواق متخصصة',
                        '25 قسم رئيسي',
                        '30 منتج رائج',
                        'إحصائيات حية',
                        'تبويبات متقدمة',
                      ],
                      isSelected: viewModeProvider.isPro,
                      onTap: () => viewModeProvider.setProMode(),
                      isRecommended: true,
                    )
                    .animate()
                    .fadeIn(delay: 500.ms)
                    .slideX(begin: -0.2),
                    
                    const SizedBox(height: 16),
                    
                    _buildModeCard(
                      context,
                      title: 'وضع Expert',
                      description: 'جميع الميزات مع تحكم كامل',
                      icon: Icons.star,
                      color: Colors.purple,
                      features: const [
                        'جميع ميزات PRO',
                        'لوحة تحكم كاملة',
                        'تحليلات متقدمة',
                        'إدارة البائعين',
                        'تقارير مفصلة',
                        'دورات أكاديمية',
                      ],
                      isSelected: viewModeProvider.isExpert,
                      onTap: () => viewModeProvider.setExpertMode(),
                    )
                    .animate()
                    .fadeIn(delay: 600.ms)
                    .slideX(begin: -0.2),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // زر المتابعة
              GoldButton(
                text: 'متابعة',
                onPressed: () => _handleContinue(context),
              )
              .animate()
              .fadeIn(delay: 700.ms),
              
              const SizedBox(height: 16),
              
              // تسجيل الدخول
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'لديك حساب بالفعل؟',
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/login'),
                    child: const Text(
                      'تسجيل الدخول',
                      style: TextStyle(
                        fontFamily: 'Changa',
                        fontWeight: FontWeight.bold,
                        color: AppColors.goldColor,
                      ),
                    ),
                  ),
                ],
              )
              .animate()
              .fadeIn(delay: 800.ms),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModeCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required List<String> features,
    required bool isSelected,
    required VoidCallback onTap,
    bool isRecommended = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.darkCard : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: isSelected
            ? Border.all(color: color, width: 2)
            : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontFamily: 'Changa',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (isRecommended) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.goldColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'موصى به',
                                style: TextStyle(
                                  fontFamily: 'Tajawal',
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(
                          fontFamily: 'Tajawal',
                          fontSize: 12,
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                  )
                else
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
            if (isSelected) ...[
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 12),
              ...features.map((feature) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 16,
                      color: color,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      feature,
                      style: const TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ],
        ),
      ),
    );
  }

  void _handleContinue(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    
    if (authProvider.isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/main');
    } else {
      Navigator.pushNamed(context, '/login');
    }
  }
}
