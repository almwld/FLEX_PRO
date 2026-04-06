import 'package:flutter/material.dart';
import '../../theme/color_constants.dart';

class ProNotificationsScreen extends StatelessWidget {
  const ProNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإشعارات'),
        backgroundColor: AppColors.goldColor,
      ),
      body: const Center(child: Text('إشعارات PRO - قيد التطوير')),
    );
  }
}
