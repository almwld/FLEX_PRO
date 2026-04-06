import 'package:flutter/material.dart';
import '../../theme/color_constants.dart';

class ProAchievementsScreen extends StatelessWidget {
  const ProAchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإنجازات'),
        backgroundColor: AppColors.goldColor,
      ),
      body: const Center(child: Text('الإنجازات والمكافآت - قيد التطوير')),
    );
  }
}
