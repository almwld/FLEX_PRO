import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../theme/color_constants.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/common/custom_button.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String phone;
  final String purpose;

  const VerifyOtpScreen({
    super.key,
    required this.phone,
    this.purpose = 'verification',
  });

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final _otpController = TextEditingController();
  int _resendTimer = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _startResendTimer() {
    setState(() {
      _canResend = false;
      _resendTimer = 60;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _resendTimer > 0) {
        setState(() {
          _resendTimer--;
        });
        _startResendTimer();
      } else if (mounted) {
        setState(() {
          _canResend = true;
        });
      }
    });
  }

  Future<void> _verifyOtp() async {
    if (_otpController.text.length != 6) {
      return;
    }

    final authProvider = context.read<AuthProvider>();
    
    await authProvider.verifyOtp(
      phone: widget.phone,
      otp: _otpController.text,
    );

    if (mounted && authProvider.error == null) {
      Navigator.pop(context, true);
    }
  }

  Future<void> _resendOtp() async {
    final authProvider = context.read<AuthProvider>();
    await authProvider.sendOtp(widget.phone);
    _startResendTimer();
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              
              // زر الرجوع
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // الأيقونة
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.goldColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  Icons.verified_user,
                  size: 50,
                  color: AppColors.goldColor,
                ),
              ),
              
              const SizedBox(height: 32),
              
              // عنوان
              const Text(
                'التحقق من الرقم',
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 8),
              
              // وصف
              Text(
                'أدخل رمز التحقق المكون من 6 أرقام المرسل إلى ${widget.phone}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 14,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
              
              const SizedBox(height: 40),
              
              // حقول OTP
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(6, (index) {
                  return Container(
                    width: 45,
                    height: 55,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF2A2F35) : Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _otpController.text.length == index
                          ? AppColors.goldColor
                          : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: TextField(
                      controller: index == 0 ? _otpController : null,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      style: const TextStyle(
                        fontFamily: 'Changa',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: const InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        if (value.length == 6) {
                          _verifyOtp();
                        }
                      },
                    ),
                  );
                }),
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
              
              const SizedBox(height: 32),
              
              // زر التحقق
              GoldButton(
                text: 'تحقق',
                onPressed: _otpController.text.length == 6 && !authProvider.isLoading
                  ? _verifyOtp
                  : null,
                isLoading: authProvider.isLoading,
              ),
              
              const SizedBox(height: 24),
              
              // إعادة الإرسال
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'لم تستلم الرمز؟',
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                  TextButton(
                    onPressed: _canResend ? _resendOtp : null,
                    child: Text(
                      _canResend
                        ? 'إعادة الإرسال'
                        : 'إعادة الإرسال ($_resendTimer)',
                      style: TextStyle(
                        fontFamily: 'Changa',
                        fontWeight: FontWeight.bold,
                        color: _canResend ? AppColors.goldColor : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
