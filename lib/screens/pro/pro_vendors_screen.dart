import 'package:flutter/material.dart';
import '../../theme/color_constants.dart';

class ProVendorsScreen extends StatelessWidget {
  const ProVendorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('البائعين'),
        backgroundColor: AppColors.goldColor,
      ),
      body: const Center(child: Text('إدارة البائعين - قيد التطوير')),
    );
  }
}
