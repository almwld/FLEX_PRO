import 'package:flutter/material.dart';
import '../../theme/color_constants.dart';

class ProSupportScreen extends StatelessWidget {
  const ProSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الدعم الفني'),
        backgroundColor: AppColors.goldColor,
      ),
      body: const Center(child: Text('الدعم الفني للمستخدمين PRO - قيد التطوير')),
    );
  }
}
