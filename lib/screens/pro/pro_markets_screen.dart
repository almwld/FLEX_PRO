import 'package:flutter/material.dart';
import '../../theme/color_constants.dart';

class ProMarketsScreen extends StatelessWidget {
  const ProMarketsScreen({super.key});

  final List<Map<String, dynamic>> markets = const [
    {'name': 'السوق اليمني', 'icon': '🇾🇪', 'color': 0xFFE31E24, 'products': 1250},
    {'name': 'مولات فلكس', 'icon': '🏬', 'color': 0xFFD4AF37, 'products': 890},
    {'name': 'المقاهي', 'icon': '☕', 'color': 0xFF6F4E37, 'products': 340},
    {'name': 'الاستراحات', 'icon': '🏖️', 'color': 0xFF1E88E5, 'products': 210},
    {'name': 'الفنادق', 'icon': '🏨', 'color': 0xFF9C27B0, 'products': 150},
    {'name': 'المطاعم', 'icon': '🍽️', 'color': 0xFFFF5722, 'products': 560},
    {'name': 'الإلكترونيات', 'icon': '📱', 'color': 0xFF00BCD4, 'products': 2300},
    {'name': 'السيارات', 'icon': '🚗', 'color': 0xFF4CAF50, 'products': 180},
    {'name': 'العقارات', 'icon': '🏠', 'color': 0xFFFF9800, 'products': 320},
    {'name': 'الأزياء', 'icon': '👗', 'color': 0xFFE91E63, 'products': 1750},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[50],
      appBar: AppBar(
        title: const Text('الأسواق'),
        backgroundColor: AppColors.goldColor,
        foregroundColor: Colors.black,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.9,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: markets.length,
        itemBuilder: (context, index) {
          final market = markets[index];
          return Container(
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[850] : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Color(market['color']).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Center(
                    child: Text(
                      market['icon'],
                      style: const TextStyle(fontSize: 40),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  market['name'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${market['products']} منتج',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
