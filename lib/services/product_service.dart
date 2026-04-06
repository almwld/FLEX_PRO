// lib/services/product_service.dart

import '../models/models.dart';

/// خدمة المنتجات
class ProductService {
  static final ProductService _instance = ProductService._internal();
  factory ProductService() => _instance;
  ProductService._internal();

  // ========== المنتجات ==========

  /// الحصول على المنتجات
  Future<List<ProductModel>> getProducts({
    int page = 1,
    int limit = 20,
    String? categoryId,
    String? searchQuery,
    Map<String, dynamic>? filters,
  }) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(milliseconds: 500));

    return List.generate(
      limit,
      (index) => ProductModel(
        id: 'prod_${page}_$index',
        productName: 'منتج تجريبي ${index + 1}',
        description: 'وصف المنتج التجريبي ${index + 1}',
        price: (index + 1) * 1000.0,
        discountPrice: index % 3 == 0 ? (index + 1) * 800.0 : null,
        images: ['https://via.placeholder.com/300'],
        stockQuantity: 100 - index,
        categoryId: categoryId ?? 'cat_${index % 5}',
        marketId: 'market_${index % 3}',
        marketName: 'متجر ${index % 3 + 1}',
        rating: 3.5 + (index % 2),
        reviewCount: 10 + index,
        createdAt: DateTime.now().subtract(Duration(days: index)),
        updatedAt: DateTime.now(),
      ),
    );
  }

  /// الحصول على تفاصيل منتج
  Future<ProductModel?> getProductDetails(String productId) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(milliseconds: 500));

    return ProductModel(
      id: productId,
      productName: 'منتج تجريبي',
      description: 'وصف تفصيلي للمنتج التجريبي',
      price: 10000,
      discountPrice: 8000,
      images: [
        'https://via.placeholder.com/300',
        'https://via.placeholder.com/300/FF0000',
        'https://via.placeholder.com/300/00FF00',
      ],
      stockQuantity: 50,
      categoryId: 'cat_1',
      categoryName: 'فئة 1',
      marketId: 'market_1',
      marketName: 'متجر 1',
      rating: 4.5,
      reviewCount: 25,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  /// الحصول على المنتجات المميزة
  Future<List<ProductModel>> getFeaturedProducts() async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(milliseconds: 500));

    return List.generate(
      10,
      (index) => ProductModel(
        id: 'featured_$index',
        productName: 'منتج مميز ${index + 1}',
        description: 'وصف المنتج المميز',
        price: (index + 1) * 5000.0,
        discountPrice: index % 2 == 0 ? (index + 1) * 4000.0 : null,
        images: ['https://via.placeholder.com/300'],
        stockQuantity: 100,
        categoryId: 'cat_${index % 5}',
        marketId: 'market_${index % 3}',
        marketName: 'متجر ${index % 3 + 1}',
        rating: 4.0 + (index % 2),
        reviewCount: 20 + index,
        isFeatured: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  }

  /// الحصول على المنتجات الجديدة
  Future<List<ProductModel>> getNewArrivals() async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(milliseconds: 500));

    return List.generate(
      10,
      (index) => ProductModel(
        id: 'new_$index',
        productName: 'منتج جديد ${index + 1}',
        description: 'وصف المنتج الجديد',
        price: (index + 1) * 3000.0,
        images: ['https://via.placeholder.com/300'],
        stockQuantity: 50,
        categoryId: 'cat_${index % 5}',
        marketId: 'market_${index % 3}',
        marketName: 'متجر ${index % 3 + 1}',
        rating: 0,
        reviewCount: 0,
        isNew: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  }

  /// البحث عن منتجات
  Future<List<ProductModel>> searchProducts(String query) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(milliseconds: 500));

    return List.generate(
      10,
      (index) => ProductModel(
        id: 'search_$index',
        productName: 'نتيجة بحث: $query ${index + 1}',
        description: 'وصف نتيجة البحث',
        price: (index + 1) * 2000.0,
        images: ['https://via.placeholder.com/300'],
        stockQuantity: 100,
        categoryId: 'cat_${index % 5}',
        marketId: 'market_${index % 3}',
        marketName: 'متجر ${index % 3 + 1}',
        rating: 3.5 + (index % 2),
        reviewCount: 10 + index,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  }

  /// الحصول على منتجات متجر
  Future<List<ProductModel>> getProductsByMarket(String marketId) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(milliseconds: 500));

    return List.generate(
      10,
      (index) => ProductModel(
        id: 'market_${marketId}_$index',
        productName: 'منتج المتجر $index',
        description: 'وصف منتج المتجر',
        price: (index + 1) * 1000.0,
        images: ['https://via.placeholder.com/300'],
        stockQuantity: 100,
        categoryId: 'cat_${index % 5}',
        marketId: marketId,
        marketName: 'متجر $marketId',
        rating: 4.0,
        reviewCount: 15,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  }

  /// الحصول على منتجات مشابهة
  Future<List<ProductModel>> getSimilarProducts(String productId) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(milliseconds: 500));

    return List.generate(
      5,
      (index) => ProductModel(
        id: 'similar_${productId}_$index',
        productName: 'منتج مشابه ${index + 1}',
        description: 'وصف المنتج المشابه',
        price: (index + 1) * 1500.0,
        images: ['https://via.placeholder.com/300'],
        stockQuantity: 50,
        categoryId: 'cat_1',
        marketId: 'market_1',
        marketName: 'متجر 1',
        rating: 4.0,
        reviewCount: 10,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  }

  // ========== الفئات ==========

  /// الحصول على الفئات
  Future<List<CategoryModel>> getCategories() async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      CategoryModel(
        id: 'cat_1',
        productName: 'إلكترونيات',
        icon: 'electronics',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      CategoryModel(
        id: 'cat_2',
        productName: 'ملابس',
        icon: 'clothing',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      CategoryModel(
        id: 'cat_3',
        productName: 'أطعمة',
        icon: 'food',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      CategoryModel(
        id: 'cat_4',
        productName: 'منزل',
        icon: 'home',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      CategoryModel(
        id: 'cat_5',
        productName: 'رياضة',
        icon: 'sports',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];
  }

  /// الحصول على فئة
  Future<CategoryModel?> getCategory(String categoryId) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(milliseconds: 300));
    return null;
  }

  // ========== المفضلة ==========

  /// الحصول على المفضلة
  Future<List<ProductModel>> getFavorites() async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(milliseconds: 500));
    return [];
  }

  /// إضافة/إزالة من المفضلة
  Future<bool> toggleFavorite(String productId) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }

  // ========== التقييمات ==========

  /// الحصول على تقييمات منتج
  Future<List<ReviewModel>> getProductReviews(String productId) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(milliseconds: 500));

    return List.generate(
      5,
      (index) => ReviewModel(
        id: 'review_$index',
        userId: 'user_$index',
        userName: 'مستخدم $index',
        productId: productId,
        rating: 4.0 + (index % 2),
        comment: 'تقييم تجريبي للمنتج $index',
        createdAt: DateTime.now().subtract(Duration(days: index)),
      ),
    );
  }

  /// إضافة تقييم
  Future<bool> addReview(ReviewModel review) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }
}
