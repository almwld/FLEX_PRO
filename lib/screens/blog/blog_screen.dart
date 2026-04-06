import 'package:flutter/material.dart';
import '../../theme/color_constants.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  final List<Map<String, dynamic>> posts = const [
    {'title': 'أحدث اتجاهات التجارة الإلكترونية 2025', 'date': '2025-04-01', 'views': 1234},
    {'title': 'كيف تحمي محفظتك الرقمية', 'date': '2025-03-28', 'views': 892},
    {'title': 'دليل الاستثمار للمبتدئين', 'date': '2025-03-25', 'views': 2156},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[50],
      appBar: AppBar(
        title: const Text('المدونة'),
        backgroundColor: AppColors.goldColor,
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
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
                Text(
                  post['title'],
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(post['date'], style: const TextStyle(fontSize: 12)),
                    const SizedBox(width: 16),
                    Icon(Icons.visibility, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text('${post['views']}', style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
