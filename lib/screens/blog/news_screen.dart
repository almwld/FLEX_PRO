import 'package:flutter/material.dart';
import '../../theme/color_constants.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  final List<Map<String, dynamic>> news = const [
    {'title': 'إطلاق تطبيق فلكس يمن', 'date': '2025-04-01', 'type': 'إطلاق', 'color': 0xFF4CAF50},
    {'title': 'عروض رمضان', 'date': '2025-03-28', 'type': 'عرض', 'color': 0xFFFF9800},
    {'title': 'شراكة جديدة مع البنوك', 'date': '2025-03-25', 'type': 'شراكة', 'color': 0xFF2196F3},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[50],
      appBar: AppBar(
        title: const Text('الأخبار'),
        backgroundColor: AppColors.goldColor,
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: news.length,
        itemBuilder: (context, index) {
          final item = news[index];
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
                  width: 8,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(item['color']),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'],
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Color(item['color']).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              item['type'],
                              style: TextStyle(fontSize: 10, color: Color(item['color'])),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(item['date'], style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
          );
        },
      ),
    );
  }
}
