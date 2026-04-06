import 'package:flutter/material.dart';
import '../../theme/color_constants.dart';

class ProSettingsScreen extends StatelessWidget {
  const ProSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إعدادات PRO'),
        backgroundColor: AppColors.goldColor,
      ),
      body: const Center(child: Text('إعدادات متقدمة - قيد التطوير')),
    );
  }
}
