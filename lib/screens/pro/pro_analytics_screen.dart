import 'package:flutter/material.dart';
import '../../theme/color_constants.dart';

class ProAnalyticsScreen extends StatelessWidget {
  const ProAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('التحليلات'),
        backgroundColor: AppColors.goldColor,
      ),
      body: const Center(child: Text('التحليلات والإحصائيات - قيد التطوير')),
    );
  }
}
