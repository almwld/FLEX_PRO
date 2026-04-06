import 'package:flutter/material.dart';
import '../../theme/color_constants.dart';

class ProUserStatsScreen extends StatelessWidget {
  const ProUserStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إحصائياتي'),
        backgroundColor: AppColors.goldColor,
      ),
      body: const Center(child: Text('إحصائيات المستخدم - قيد التطوير')),
    );
  }
}
