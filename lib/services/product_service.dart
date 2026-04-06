import '../models/product_model.dart';
import '../models/category_model.dart';

class ProductService {
  Future<List<ProductModel>> getProducts({int page = 1, int limit = 20, String? categoryId}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [];
  }
  
  Future<ProductModel?> getProductDetails(String productId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return null;
  }
  
  Future<List<ProductModel>> searchProducts(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [];
  }
  
  Future<List<ProductModel>> getFeaturedProducts() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [];
  }
  
  Future<List<ProductModel>> getNewArrivals() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [];
  }
  
  Future<List<ProductModel>> getProductsByCategory(String categoryId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [];
  }
  
  Future<List<ProductModel>> getProductsByMarket(String marketId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [];
  }
  
  Future<List<ProductModel>> getSimilarProducts(String productId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [];
  }
  
  Future<List<CategoryModel>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [];
  }
  
  Future<bool> toggleFavorite(String productId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }
  
  Future<List<ProductModel>> getFavorites() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [];
  }
}
