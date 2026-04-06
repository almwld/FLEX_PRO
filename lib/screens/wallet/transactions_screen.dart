import 'package:flutter/material.dart';
import '../../theme/color_constants.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المعاملات'),
        backgroundColor: AppColors.goldColor,
      ),
      body: const Center(
        child: Text('شاشة المعاملات - قيد التطوير'),
      ),
    );
  }
}
