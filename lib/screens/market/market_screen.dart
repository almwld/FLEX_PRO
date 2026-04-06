// lib/screens/market/market_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/providers.dart';
import '../../theme/app_theme.dart';
import '../../widgets/widgets.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().loadProducts();
      context.read<ProductProvider>().loadCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // شريط البحث
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/search');
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkSurface : Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: isDark ? Colors.grey[400] : AppColors.textSecondary,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'البحث عن منتجات...',
                          style: TextStyle(
                            color: isDark ? Colors.grey[400] : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // الفئات
            SliverToBoxAdapter(
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: productProvider.categories.isEmpty
                      ? 5
                      : productProvider.categories.length,
                  itemBuilder: (context, index) {
                    if (productProvider.categories.isEmpty) {
                      return _CategorySkeleton();
                    }
                    final category = productProvider.categories[index];
                    return _CategoryItem(
                      name: category.name,
                      icon: category.iconData,
                      onTap: () {
                        productProvider.filterByCategory(category.id);
                      },
                    );
                  },
                ),
              ),
            ),
            // المنتجات المميزة
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'منتجات مميزة',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : AppColors.textPrimary,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/products/featured');
                      },
                      child: Text(
                        'عرض الكل',
                        style: TextStyle(
                          color: AppColors.goldPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // شبكة المنتجات
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: productProvider.isLoading
                  ? const SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(32),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    )
                  : SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if (index >= productProvider.products.length) {
                            return const SizedBox.shrink();
                          }
                          final product = productProvider.products[index];
                          return ProductCard(
                            product: product,
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                '/product-details',
                                arguments: product.id,
                              );
                            },
                          );
                        },
                        childCount: productProvider.products.length,
                      ),
                    ),
            ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
          ],
        ),
      ),
    );
  }
}

/// عنصر الفئة
class _CategoryItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final VoidCallback onTap;

  const _CategoryItem({
    required this.name,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkSurface
                    : AppColors.goldPrimary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                color: AppColors.goldPrimary,
                size: 28,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.grey[400] : AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

/// هيكل الفئة (Skeleton)
class _CategorySkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[800] : Colors.grey[200],
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 50,
            height: 12,
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[800] : Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}
