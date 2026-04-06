import 'package:flutter/material.dart';
import '../../theme/color_constants.dart';

class MarketMerchantsScreen extends StatelessWidget {
  const MarketMerchantsScreen({super.key});

  final List<Map<String, dynamic>> merchants = const [
    {'name': 'متجر الإلكترونيات', 'rating': 4.8, 'products': 230},
    {'name': 'متجر الملابس', 'rating': 4.5, 'products': 180},
    {'name': 'متجر الأجهزة', 'rating': 4.9, 'products': 95},
    {'name': 'متجر العطور', 'rating': 4.7, 'products': 120},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[50],
      appBar: AppBar(
        title: const Text('البائعون'),
        backgroundColor: AppColors.goldColor,
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: merchants.length,
        itemBuilder: (context, index) {
          final merchant = merchants[index];
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
                  child: const Icon(Icons.store, color: AppColors.goldColor),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(merchant['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text('${merchant['rating']}'),
                          const SizedBox(width: 16),
                          const Icon(Icons.inventory, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text('${merchant['products']} منتج'),
                        ],
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
          );
        },
      ),
    );
  }
}
