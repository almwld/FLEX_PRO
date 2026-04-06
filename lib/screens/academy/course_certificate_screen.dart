import 'package:flutter/material.dart';
import '../../theme/color_constants.dart';
import '../../widgets/common/custom_button.dart';

class CourseCertificateScreen extends StatelessWidget {
  const CourseCertificateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('شهادة الإنجاز'),
        backgroundColor: AppColors.goldColor,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // الشهادة
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.goldColor, width: 2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.verified, size: 60, color: AppColors.goldColor),
                    const SizedBox(height: 16),
                    const Text(
                      'شهادة إنجاز',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text('تُمنح هذه الشهادة إلى'),
                    const SizedBox(height: 8),
                    const Text(
                      'أحمد محمد',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text('لإكمال دورة'),
                    const SizedBox(height: 8),
                    const Text(
                      'مقدمة في العملات الرقمية',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    const Text('بتاريخ 2025-04-01'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: GoldButton(
                      text: 'تحميل PDF',
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GoldButton(
                      text: 'مشاركة',
                      onPressed: () {},
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
