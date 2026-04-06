import 'package:flutter/material.dart';
import '../../theme/color_constants.dart';

class ProAppSettingsScreen extends StatelessWidget {
  const ProAppSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إعدادات التطبيق'),
        backgroundColor: AppColors.goldColor,
      ),
      body: const Center(child: Text('إعدادات التطبيق المتقدمة - قيد التطوير')),
    );
  }
}
