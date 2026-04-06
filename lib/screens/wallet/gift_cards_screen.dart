import 'package:flutter/material.dart';
import '../../theme/color_constants.dart';
import '../../widgets/common/custom_button.dart';

class GiftCardsScreen extends StatelessWidget {
  const GiftCardsScreen({super.key});

  final List<GiftCard> giftCards = const [
    GiftCard(name: 'أمازون', icon: '🛒', value: '10$ - 500$', color: 0xFFFF9900),
    GiftCard(name: 'Google Play', icon: '▶️', value: '5$ - 200$', color: 0xFF4285F4),
    GiftCard(name: 'App Store', icon: '🍎', value: '10$ - 500$', color: 0xFFA2AAAD),
    GiftCard(name: 'Steam', icon: '🎮', value: '5$ - 100$', color: 0xFF171A21),
    GiftCard(name: 'Netflix', icon: '📺', value: '10$ - 100$', color: 0xFFE50914),
    GiftCard(name: 'PlayStation', icon: '🎮', value: '10$ - 100$', color: 0xFF003791),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[50],
      appBar: AppBar(
        title: const Text('بطاقات الهدايا'),
        backgroundColor: AppColors.goldColor,
        foregroundColor: Colors.black,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: giftCards.length,
        itemBuilder: (context, index) {
          final card = giftCards[index];
          return GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[800] : Colors.white,
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
                      color: Color(card.color).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Center(
                      child: Text(card.icon, style: const TextStyle(fontSize: 40)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    card.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    card.value,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.goldColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'شراء',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class GiftCard {
  final String name;
  final String icon;
  final String value;
  final int color;
  const GiftCard({required this.name, required this.icon, required this.value, required this.color});
}
