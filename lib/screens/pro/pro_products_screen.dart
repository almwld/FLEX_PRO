import 'package:flutter/material.dart';
import '../../theme/color_constants.dart';

class ProProductsScreen extends StatelessWidget {
  const ProProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المنتجات'),
        backgroundColor: AppColors.goldColor,
      ),
      body: const Center(child: Text('إدارة المنتجات - قيد التطوير')),
    );
  }
}
