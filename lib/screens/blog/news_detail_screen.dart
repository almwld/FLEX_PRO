import 'package:flutter/material.dart';
import '../../theme/color_constants.dart';

class NewsDetailScreen extends StatelessWidget {
  final String newsId;
  const NewsDetailScreen({super.key, required this.newsId});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.white,
      appBar: AppBar(
        title: const Text('تفاصيل الخبر'),
        backgroundColor: AppColors.goldColor,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // نوع الخبر
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text('إطلاق', style: TextStyle(color: Colors.green)),
            ),
            const SizedBox(height: 16),
            // عنوان الخبر
            const Text(
              'عنوان الخبر',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // التاريخ
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                const Text('2025-04-01', style: TextStyle(fontSize: 12)),
              ],
            ),
            const SizedBox(height: 16),
            // صورة الخبر
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(child: Icon(Icons.image, size: 50)),
            ),
            const SizedBox(height: 16),
            // محتوى الخبر
            Text(
              'هذا هو محتوى الخبر. يمكنك هنا عرض التفاصيل الكاملة. '
              'هذا النص هو مثال لتوضيح كيفية عرض المحتوى.',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: isDark ? Colors.grey[300] : Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
