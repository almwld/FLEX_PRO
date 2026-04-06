import 'package:flutter/material.dart';
import '../../theme/color_constants.dart';

class BlogDetailScreen extends StatelessWidget {
  final String postId;
  const BlogDetailScreen({super.key, required this.postId});

  @override
Widget build(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return Scaffold(
    backgroundColor: isDark ? Colors.grey[900] : Colors.white,
    appBar: AppBar(
      title: const Text('تفاصيل المقال'),
      backgroundColor: AppColors.goldColor,
      foregroundColor: Colors.black,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // صورة المقال
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Icon(Icons.image, size: 50, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 16),
          // عنوان المقال
          const Text(
            'عنوان المقال',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          // معلومات المقال
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              const Text('2025-04-01', style: TextStyle(fontSize: 12)),
              const SizedBox(width: 16),
              const Icon(Icons.visibility, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              const Text('1,234 مشاهدة', style: TextStyle(fontSize: 12)),
              const SizedBox(width: 16),
              const Icon(Icons.access_time, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              const Text('5 دقائق قراءة', style: TextStyle(fontSize: 12)),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          // محتوى المقال
          Text(
            'هذا هو محتوى المقال. يمكنك هنا عرض التفاصيل الكاملة للمقالة، '
            'بما في ذلك النصوص والصور والروابط. هذا النص هو مثال لتوضيح '
            'كيفية عرض المحتوى في صفحة تفاصيل المقال.',
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
              color: isDark ? Colors.grey[300] : Colors.grey[800],
            ),
          ),
          const SizedBox(height: 24),
          // مقالات مشابهة
          const Text(
            'مقالات مشابهة',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2,
            itemBuilder: (context, index) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[850] : Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('مقال مشابه ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        const Text('وصف قصير للمقال', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}
