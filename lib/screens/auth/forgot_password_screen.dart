import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../theme/color_constants.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendResetLink() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = context.read<AuthProvider>();
    
    await authProvider.forgotPassword(_emailController.text.trim());

    if (mounted && authProvider.error == null) {
      setState(() {
        _emailSent = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                
                // زر الرجوع
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                
                const SizedBox(height: 24),
                
                // الأيقونة
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.goldColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Icon(
                      Icons.lock_reset,
                      size: 50,
                      color: AppColors.goldColor,
                    ),
                  ),
                ),
                
                const SizedBox(height: 32),
                
                if (!_emailSent) ...[
                  // عنوان
                  const Center(
                    child: Text(
                      'نسيت كلمة المرور؟',
                      style: TextStyle(
                        fontFamily: 'Changa',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // وصف
                  Center(
                    child: Text(
                      'أدخل بريدك الإلكتروني وسنرسل لك رابطاً لإعادة تعيين كلمة المرور',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 14,
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // حقل البريد الإلكتروني
                  EmailField(
                    controller: _emailController,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // رسالة الخطأ
                  if (authProvider.error != null)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.error.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.error_outline, color: AppColors.error),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              authProvider.error!,
                              style: const TextStyle(
                                fontFamily: 'Tajawal',
                                color: AppColors.error,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                  if (authProvider.error != null) const SizedBox(height: 16),
                  
                  // زر إرسال
                  GoldButton(
                    text: 'إرسال رابط إعادة التعيين',
                    onPressed: authProvider.isLoading ? null : _sendResetLink,
                    isLoading: authProvider.isLoading,
                  ),
                ] else ...[
                  // رسالة النجاح
                  const Center(
                    child: Icon(
                      Icons.mark_email_read,
                      size: 80,
                      color: AppColors.success,
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  const Center(
                    child: Text(
                      'تم إرسال الرابط!',
                      style: TextStyle(
                        fontFamily: 'Changa',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Center(
                    child: Text(
                      'تحقق من بريدك الإلكتروني ${_emailController.text} واتبع التعليمات لإعادة تعيين كلمة المرور',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 14,
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  GoldButton(
                    text: 'العودة لتسجيل الدخول',
                    onPressed: () => Navigator.pop(context),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _emailSent = false;
                      });
                    },
                    child: const Text('إعادة الإرسال'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
