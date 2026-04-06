import 'package:flutter/material.dart';
import '../../theme/color_constants.dart';

class ProOffersScreen extends StatelessWidget {
  const ProOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('العروض'),
        backgroundColor: AppColors.goldColor,
      ),
      body: const Center(child: Text('العروض والخصومات - قيد التطوير')),
    );
  }
}
