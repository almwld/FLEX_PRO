// lib/providers/product_provider.dart

import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/services.dart';

/// حالات المنتجات
enum ProductStatus {
  initial,
  loading,
  loaded,
  error,
  loadingMore,
}

/// Provider المنتجات
class ProductProvider extends ChangeNotifier {
  final ProductService _productService;

  ProductProvider({required ProductService productService})
      : _productService = productService;

  // ========== الحالة ==========
  ProductStatus _status = ProductStatus.initial;
  List<ProductModel> _products = [];
  List<ProductModel> _featuredProducts = [];
  List<ProductModel> _newArrivals = [];
  List<ProductModel> _searchResults = [];
  ProductModel? _selectedProduct;
  List<CategoryModel> _categories = [];
  CategoryModel? _selectedCategory;
  String? _errorMessage;
  bool _hasMore = true;
  int _currentPage = 1;

  // ========== Getters ==========
  ProductStatus get status => _status;
  List<ProductModel> get products => _products;
  List<ProductModel> get featuredProducts => _featuredProducts;
  List<ProductModel> get newArrivals => _newArrivals;
  List<ProductModel> get searchResults => _searchResults;
  ProductModel? get selectedProduct => _selectedProduct;
  List<CategoryModel> get categories => _categories;
  CategoryModel? get selectedCategory => _selectedCategory;
  String? get errorMessage => _errorMessage;
  bool get hasMore => _hasMore;
  bool get isLoading => _status == ProductStatus.loading;
  bool get isLoadingMore => _status == ProductStatus.loadingMore;

  // ========== Methods ==========

  /// تحميل المنتجات
  Future<void> loadProducts({
    bool refresh = false,
    int page = 1,
    int limit = 20,
    String? categoryId,
    String? searchQuery,
    Map<String, dynamic>? filters,
  }) async {
    if (refresh) {
      _currentPage = 1;
      _products = [];
      _hasMore = true;
    }

    if (page > 1) {
      _status = ProductStatus.loadingMore;
    } else {
      _status = ProductStatus.loading;
    }

    _clearError();
    notifyListeners();

    try {
      final products = await _productService.getProducts(
        page: page,
        limit: limit,
        categoryId: categoryId,
        
      );

      if (products.isNotEmpty) {
        if (page == 1) {
          _products = products;
        } else {
          _products.addAll(products);
        }
        _currentPage++;
        _hasMore = products.length >= limit;
      } else {
        _hasMore = false;
      }

      _status = ProductStatus.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _status = ProductStatus.error;
    } finally {
      notifyListeners();
    }
  }

  /// تحميل المزيد من المنتجات
  Future<void> loadMoreProducts() async {
    if (_status == ProductStatus.loadingMore || !_hasMore) return;
    await loadProducts(page: _currentPage);
  }

  /// تحميل المنتجات المميزة
  Future<void> loadFeaturedProducts() async {
    _status = ProductStatus.loading;
    _clearError();
    notifyListeners();

    try {
      _featuredProducts = await _productService.getFeaturedProducts();
      _status = ProductStatus.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _status = ProductStatus.error;
    } finally {
      notifyListeners();
    }
  }

  /// تحميل المنتجات الجديدة
  Future<void> loadNewArrivals() async {
    _status = ProductStatus.loading;
    _clearError();
    notifyListeners();

    try {
      _newArrivals = await _productService.getNewArrivals();
      _status = ProductStatus.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _status = ProductStatus.error;
    } finally {
      notifyListeners();
    }
  }

  /// تحميل تفاصيل منتج
  Future<void> loadProductDetails(String productId) async {
    _status = ProductStatus.loading;
    _clearError();
    notifyListeners();

    try {
      _selectedProduct = await _productService.getProductDetails(productId);
      _status = ProductStatus.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _status = ProductStatus.error;
    } finally {
      notifyListeners();
    }
  }

  /// البحث عن منتجات
  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }

    _status = ProductStatus.loading;
    _clearError();
    notifyListeners();

    try {
      _searchResults = await _productService.searchProducts(query);
      _status = ProductStatus.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _status = ProductStatus.error;
    } finally {
      notifyListeners();
    }
  }

  /// تحميل الفئات
  Future<void> loadCategories() async {
    _status = ProductStatus.loading;
    _clearError();
    notifyListeners();

    try {
      _categories = await _productService.getCategories();
      _status = ProductStatus.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _status = ProductStatus.error;
    } finally {
      notifyListeners();
    }
  }

  /// اختيار فئة
  void selectCategory(CategoryModel? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  /// تصفية حسب الفئة
  Future<void> filterByCategory(String categoryId) async {
    await loadProducts(categoryId: categoryId, refresh: true);
  }

  /// الحصول على منتجات متجر
  Future<List<ProductModel>> getProductsByMarket(String marketId) async {
    try {
      return await _productService.getProductsByMarket(marketId);
    } catch (e) {
      _errorMessage = e.toString();
      return [];
    }
  }

  /// الحصول على منتجات مشابهة
  Future<List<ProductModel>> getSimilarProducts(String productId) async {
    try {
      return await _productService.getSimilarProducts(productId);
    } catch (e) {
      _errorMessage = e.toString();
      return [];
    }
  }

  /// إضافة/إزالة من المفضلة
  Future<bool> toggleFavorite(String productId) async {
    try {
      final result = await _productService.toggleFavorite(productId);

      // تحديث المنتج في القوائم
      _updateProductInLists(productId, (p) => p.copyWith(isFavorite: result));

      notifyListeners();
      return result;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  /// تحميل المفضلة
  Future<void> loadFavorites() async {
    _status = ProductStatus.loading;
    _clearError();
    notifyListeners();

    try {
      _products = await _productService.getFavorites();
      _status = ProductStatus.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _status = ProductStatus.error;
    } finally {
      notifyListeners();
    }
  }

  /// مسح نتائج البحث
  void clearSearch() {
    _searchResults = [];
    notifyListeners();
  }

  /// مسح المنتج المحدد
  void clearSelectedProduct() {
    _selectedProduct = null;
    notifyListeners();
  }

  /// مسح الخطأ
  void clearError() {
    _clearError();
    notifyListeners();
  }

  /// إعادة تعيين
  void reset() {
    _status = ProductStatus.initial;
    _products = [];
    _featuredProducts = [];
    _newArrivals = [];
    _searchResults = [];
    _selectedProduct = null;
    _categories = [];
    _selectedCategory = null;
    _errorMessage = null;
    _hasMore = true;
    _currentPage = 1;
    notifyListeners();
  }

  // ========== Private Methods ==========

  void _updateProductInLists(String productId, ProductModel Function(ProductModel) update) {
    // تحديث في قائمة المنتجات
    final productIndex = _products.indexWhere((p) => p.id == productId);
    if (productIndex >= 0) {
      _products[productIndex] = update(_products[productIndex]);
    }

    // تحديث في المنتجات المميزة
    final featuredIndex = _featuredProducts.indexWhere((p) => p.id == productId);
    if (featuredIndex >= 0) {
      _featuredProducts[featuredIndex] = update(_featuredProducts[featuredIndex]);
    }

    // تحديث في المنتجات الجديدة
    final newArrivalIndex = _newArrivals.indexWhere((p) => p.id == productId);
    if (newArrivalIndex >= 0) {
      _newArrivals[newArrivalIndex] = update(_newArrivals[newArrivalIndex]);
    }

    // تحديث المنتج المحدد
    if (_selectedProduct?.id == productId) {
      _selectedProduct = update(_selectedProduct!);
    }
  }

  void _clearError() {
    _errorMessage = null;
  }
}
