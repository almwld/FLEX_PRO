// lib/models/cart_model.dart

import 'product_model.dart';

/// نموذج عنصر سلة التسوق
class CartItemModel {
  final String id;
  final String productId;
  final String productName;
  final String? productImage;
  final double price;
  final double? originalPrice;
  final int quantity;
  final String? variant;
  final Map<String, dynamic>? options;
  final double total;
  final String? marketId;
  final String? marketName;
  final int maxQuantity;
  final bool isAvailable;

  CartItemModel({
    required this.id,
    required this.productId,
    required this.productName,
    this.productImage,
    required this.price,
    this.originalPrice,
    required this.quantity,
    this.variant,
    this.options,
    required this.total,
    this.marketId,
    this.marketName,
    this.maxQuantity = 99,
    this.isAvailable = true,
  });

  /// هل هناك خصم
  bool get hasDiscount => originalPrice != null && originalPrice! > price;

  /// نسبة الخصم
  double get discountPercent {
    if (!hasDiscount) return 0;
    return ((originalPrice! - price) / originalPrice! * 100).roundToDouble();
  }

  /// إجمالي العنصر
  double get itemTotal => price * quantity;

  /// إجمالي التوفير
  double get totalSavings {
    if (!hasDiscount) return 0;
    return (originalPrice! - price) * quantity;
  }

  factory CartItemModel.fromProduct(ProductModel product, {int quantity = 1}) {
    return CartItemModel(
      id: '${product.id}_${DateTime.now().millisecondsSinceEpoch}',
      productId: product.id,
      productName: product.name,
      productImage: product.images.isNotEmpty ? product.images.first : null,
      price: product.discountPrice ?? product.price,
      originalPrice: product.hasDiscount ? product.price : null,
      quantity: quantity,
      total: (product.discountPrice ?? product.price) * quantity,
      marketId: product.marketId,
      marketName: product.marketName,
      maxQuantity: product.stockQuantity,
      isAvailable: product.isInStock,
    );
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] ?? '',
      productId: json['productId'] ?? '',
      productName: json['productName'] ?? '',
      productImage: json['productImage'],
      price: (json['price'] ?? 0.0).toDouble(),
      originalPrice: json['originalPrice']?.toDouble(),
      quantity: json['quantity'] ?? 1,
      variant: json['variant'],
      options: json['options'],
      total: (json['total'] ?? 0.0).toDouble(),
      marketId: json['marketId'],
      marketName: json['marketName'],
      maxQuantity: json['maxQuantity'] ?? 99,
      isAvailable: json['isAvailable'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'productImage': productImage,
      'price': price,
      'originalPrice': originalPrice,
      'quantity': quantity,
      'variant': variant,
      'options': options,
      'total': total,
      'marketId': marketId,
      'marketName': marketName,
      'maxQuantity': maxQuantity,
      'isAvailable': isAvailable,
    };
  }

  CartItemModel copyWith({
    String? id,
    String? productId,
    String? productName,
    String? productImage,
    double? price,
    double? originalPrice,
    int? quantity,
    String? variant,
    Map<String, dynamic>? options,
    double? total,
    String? marketId,
    String? marketName,
    int? maxQuantity,
    bool? isAvailable,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      quantity: quantity ?? this.quantity,
      variant: variant ?? this.variant,
      options: options ?? this.options,
      total: total ?? this.total,
      marketId: marketId ?? this.marketId,
      marketName: marketName ?? this.marketName,
      maxQuantity: maxQuantity ?? this.maxQuantity,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }
}

/// نموذج سلة التسوق
class CartModel {
  final String id;
  final String userId;
  final List<CartItemModel> items;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? couponCode;
  final double? discountAmount;
  final double shippingCost;

  CartModel({
    required this.id,
    required this.userId,
    this.items = const [],
    required this.createdAt,
    required this.updatedAt,
    this.couponCode,
    this.discountAmount,
    this.shippingCost = 0.0,
  });

  /// عدد العناصر
  int get itemCount => items.length;

  /// إجمالي الكمية
  int get totalQuantity => items.fold(0, (sum, item) => sum + item.quantity);

  /// المجموع الفرعي
  double get subtotal => items.fold(0, (sum, item) => sum + item.itemTotal);

  /// إجمالي الخصم
  double get totalDiscount => items.fold(0, (sum, item) => sum + item.totalSavings);

  /// إجمالي الكوبون
  double get couponDiscount => discountAmount ?? 0.0;

  /// المجموع الكلي
  double get total => subtotal - couponDiscount + shippingCost;

  /// هل السلة فارغة
  bool get isEmpty => items.isEmpty;

  /// هل هناك عناصر
  bool get isNotEmpty => items.isNotEmpty;

  /// المتاجر المختلفة في السلة
  List<String> get marketIds => items.map((i) => i.marketId).whereType<String>().toSet().toList();

  /// عدد المتاجر
  int get marketCount => marketIds.length;

  /// هل السلة تحتوي على عناصر من متاجر مختلفة
  bool get hasMultipleMarkets => marketCount > 1;

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      items: json['items'] != null
          ? (json['items'] as List)
              .map((i) => CartItemModel.fromJson(i))
              .toList()
          : [],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
      couponCode: json['couponCode'],
      discountAmount: json['discountAmount']?.toDouble(),
      shippingCost: (json['shippingCost'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'items': items.map((i) => i.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'couponCode': couponCode,
      'discountAmount': discountAmount,
      'shippingCost': shippingCost,
    };
  }

  CartModel copyWith({
    String? id,
    String? userId,
    List<CartItemModel>? items,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? couponCode,
    double? discountAmount,
    double? shippingCost,
  }) {
    return CartModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      items: items ?? this.items,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      couponCode: couponCode ?? this.couponCode,
      discountAmount: discountAmount ?? this.discountAmount,
      shippingCost: shippingCost ?? this.shippingCost,
    );
  }
}
