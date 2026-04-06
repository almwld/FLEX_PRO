import 'package:flutter/material.dart';
import '../../theme/color_constants.dart';
import '../../widgets/common/custom_button.dart';

class CourseDetailScreen extends StatelessWidget {
  final String courseId;
  const CourseDetailScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.white,
      appBar: AppBar(
        title: const Text('تفاصيل الدورة'),
        backgroundColor: AppColors.goldColor,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة الدورة
            Container(
              height: 200,
              width: double.infinity,
              color: AppColors.goldColor.withOpacity(0.2),
              child: const Center(
                child: Icon(Icons.school, size: 60, color: AppColors.goldColor),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // عنوان الدورة
                  const Text(
                    'مقدمة في العملات الرقمية',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  // معلومات الدورة
                  Row(
                    children: [
                      _InfoChip(Icons.timer, '2 ساعة'),
                      const SizedBox(width: 8),
                      _InfoChip(Icons.auto_graph, 'مبتدئ'),
                      const SizedBox(width: 8),
                      _InfoChip(Icons.people, '1,234 طالب'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // وصف الدورة
                  const Text(
                    'وصف الدورة',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'هذه دورة شاملة تشرح أساسيات العملات الرقمية وكيفية الاستثمار فيها...',
                    style: TextStyle(
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // محتوى الدورة
                  const Text(
                    'محتوى الدورة',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _LessonItem(title: 'مقدمة', duration: '10 دقائق', isLocked: false),
                  _LessonItem(title: 'ما هي العملات الرقمية؟', duration: '20 دقائق', isLocked: false),
                  _LessonItem(title: 'كيف تبدأ الاستثمار؟', duration: '15 دقائق', isLocked: true),
                  const SizedBox(height: 24),
                  GoldButton(
                    text: 'ابدأ الدورة',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoChip(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.grey[600]),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class _LessonItem extends StatelessWidget {
  final String title;
  final String duration;
  final bool isLocked;
  const _LessonItem({required this.title, required this.duration, required this.isLocked});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(isLocked ? Icons.lock : Icons.play_circle, color: AppColors.goldColor),
          const SizedBox(width: 12),
          Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold))),
          Text(duration, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
