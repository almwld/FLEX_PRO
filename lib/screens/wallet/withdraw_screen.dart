import 'package:flutter/material.dart';
import '../../theme/color_constants.dart';

class WithdrawScreen extends StatelessWidget {
  const WithdrawScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سحب'),
        backgroundColor: AppColors.goldColor,
      ),
      body: const Center(
        child: Text('شاشة السحب - قيد التطوير'),
      ),
    );
  }
}
