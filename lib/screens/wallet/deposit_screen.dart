import 'package:flutter/material.dart';
import '../../widgets/common/custom_button.dart';
import '../../theme/color_constants.dart';

class DepositScreen extends StatelessWidget {
  const DepositScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إيداع'),
        backgroundColor: AppColors.goldColor,
      ),
      body: const Center(
        child: Text('شاشة الإيداع - قيد التطوير'),
      ),
    );
  }
}
