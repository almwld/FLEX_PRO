import 'package:flutter/material.dart';
import '../../theme/color_constants.dart';

class ProOrdersScreen extends StatelessWidget {
  const ProOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الطلبات'),
        backgroundColor: AppColors.goldColor,
      ),
      body: const Center(child: Text('إدارة الطلبات - قيد التطوير')),
    );
  }
}
