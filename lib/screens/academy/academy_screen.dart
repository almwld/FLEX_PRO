import 'package:flutter/material.dart';
import '../../theme/color_constants.dart';

class AcademyScreen extends StatelessWidget {
  const AcademyScreen({super.key});

  final List<Map<String, dynamic>> courses = const [
    {'title': 'مقدمة في العملات الرقمية', 'duration': '2 ساعة', 'level': 'مبتدئ', 'free': true},
    {'title': 'كيف تستثمر في العملات', 'duration': '3 ساعة', 'level': 'متوسط', 'free': false},
    {'title': 'تحليل الأسواق المالية', 'duration': '4 ساعة', 'level': 'متقدم', 'free': false},
    {'title': 'الأمان في المحافظ الرقمية', 'duration': '1.5 ساعة', 'level': 'مبتدئ', 'free': true},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[50],
      appBar: AppBar(
        title: const Text('الأكاديمية'),
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
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.goldColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.school, color: AppColors.goldColor, size: 30),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course['title'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.timer, size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(course['duration'], style: const TextStyle(fontSize: 12)),
                          const SizedBox(width: 12),
                          Icon(Icons.auto_graph, size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(course['level'], style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
                if (course['free'] == true)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('مجاني', style: TextStyle(color: Colors.green)),
                  )
                else
                  const Icon(Icons.lock, color: Colors.grey),
              ],
            ),
          );
        },
      ),
    );
  }
}
