import 'package:flutter/material.dart';
import '../../theme/color_constants.dart';

class MarketDetailScreen extends StatelessWidget {
  final String marketId;
  const MarketDetailScreen({super.key, required this.marketId});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[50],
      appBar: AppBar(
        title: const Text('تفاصيل السوق'),
        backgroundColor: AppColors.goldColor,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // غلاف السوق
          Container(
            height: 150,
            width: double.infinity,
            color: AppColors.goldColor,
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.store, size: 50, color: Colors.white),
                  SizedBox(height: 8),
                  Text('اسم السوق', style: TextStyle(color: Colors.white, fontSize: 20)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // تبويبات
          DefaultTabController(
            length: 3,
            child: Expanded(
              child: Column(
                children: [
                  const TabBar(
                    tabs: [
                      Tab(text: 'المنتجات'),
                      Tab(text: 'العروض'),
                      Tab(text: 'المعلومات'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _ProductsTab(),
                        const Center(child: Text('العروض - قيد التطوير')),
                        const Center(child: Text('المعلومات - قيد التطوير')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[850] : Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: const Center(child: Icon(Icons.image, size: 40)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text('منتج ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('${(index + 1) * 1000} ر.ي', style: const TextStyle(color: AppColors.goldColor)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
