import 'package:flutter/material.dart';
import '../../theme/color_constants.dart';

class MyCoursesScreen extends StatelessWidget {
  const MyCoursesScreen({super.key});

  final List<Map<String, dynamic>> courses = const [
    {'title': 'مقدمة في العملات الرقمية', 'progress': 0.6, 'status': 'قيد التقدم'},
    {'title': 'تحليل الأسواق المالية', 'progress': 0.3, 'status': 'قيد التقدم'},
    {'title': 'الأمان في المحافظ الرقمية', 'progress': 1.0, 'status': 'مكتمل'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[50],
      appBar: AppBar(
        title: const Text('دوراتي'),
        backgroundColor: AppColors.goldColor,
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[850] : Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        course['title'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: course['status'] == 'مكتمل'
                            ? Colors.green.withOpacity(0.1)
                            : AppColors.goldColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        course['status'],
                        style: TextStyle(
                          fontSize: 12,
                          color: course['status'] == 'مكتمل' ? Colors.green : AppColors.goldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: course['progress'],
                  backgroundColor: Colors.grey[300],
                  color: AppColors.goldColor,
                ),
                const SizedBox(height: 8),
                Text('${(course['progress'] * 100).toInt()}% مكتمل'),
              ],
            ),
          );
        },
      ),
    );
  }
}
