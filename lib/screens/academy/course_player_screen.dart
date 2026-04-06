import 'package:flutter/material.dart';
import '../../theme/color_constants.dart';

class CoursePlayerScreen extends StatelessWidget {
  final String lessonId;
  const CoursePlayerScreen({super.key, required this.lessonId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('تشغيل الدرس'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.play_circle_filled, size: 80, color: AppColors.goldColor),
            SizedBox(height: 16),
            Text('مشغل الفيديو', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
