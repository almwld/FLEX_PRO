import 'package:flutter/material.dart';
import '../../theme/color_constants.dart';

class ProBlogScreen extends StatelessWidget {
  const ProBlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المدونة'),
        backgroundColor: AppColors.goldColor,
      ),
      body: const Center(child: Text('المدونة والأخبار - قيد التطوير')),
    );
  }
}
