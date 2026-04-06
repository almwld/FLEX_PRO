import 'package:flutter/material.dart';
import '../../theme/color_constants.dart';

class TransferScreen extends StatelessWidget {
  const TransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تحويل'),
        backgroundColor: AppColors.goldColor,
      ),
      body: const Center(
        child: Text('شاشة التحويل - قيد التطوير'),
      ),
    );
  }
}
