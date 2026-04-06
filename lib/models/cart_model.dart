class CartItemModel {
  final String id;
  final String productId;
  final String productName;
  final String? productImage;
  final double price;
  final double? originalPrice;
  final int quantity;
  final double total;
  final String? marketId;
  final String? marketName;

  CartItemModel({
    required this.id,
    required this.productId,
    required this.productName,
    this.productImage,
    required this.price,
    this.originalPrice,
    required this.quantity,
    required this.total,
    this.marketId,
    this.marketName,
  });

  double get itemTotal => price * quantity;
  double get totalSavings => originalPrice != null ? (originalPrice! - price) * quantity : 0;
  bool get hasDiscount => originalPrice != null && originalPrice! > price;
  int get maxQuantity => 99;

  factory CartItemModel.fromProduct(dynamic product, {int quantity = 1}) {
    return CartItemModel(
      id: '${product.id}_${DateTime.now().millisecondsSinceEpoch}',
      productId: product.id,
      productName: product.name,
      productImage: product.images != null && product.images.isNotEmpty ? product.images.first : null,
      price: product.discountPrice ?? product.price,
      originalPrice: product.hasDiscount ? product.price : null,
      quantity: quantity,
      total: (product.discountPrice ?? product.price) * quantity,
      marketId: product.marketId,
      marketName: product.marketName,
    );
  }

  CartItemModel copyWith({int? quantity, double? total}) {
    return CartItemModel(
      id: id,
      productId: productId,
      productName: productName,
      productImage: productImage,
      price: price,
      originalPrice: originalPrice,
      quantity: quantity ?? this.quantity,
      total: total ?? this.total,
      marketId: marketId,
      marketName: marketName,
    );
  }

}

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
    required this.items,
    required this.createdAt,
    required this.updatedAt,
    this.couponCode,
    this.discountAmount,
    this.shippingCost = 0,
  });

  double get subtotal => items.fold(0, (sum, item) => sum + item.itemTotal);
  double get total => subtotal - (discountAmount ?? 0) + shippingCost;
  int get itemCount => items.length;
  int get totalQuantity => items.fold(0, (sum, item) => sum + item.quantity);

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      items: (json['items'] as List?)?.map((i) => CartItemModel.fromProduct(i)).toList() ?? [],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : DateTime.now(),
      couponCode: json['couponCode'],
      discountAmount: json['discountAmount']?.toDouble(),
      shippingCost: json['shippingCost']?.toDouble() ?? 0,
    );
  }

}

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'items': [],
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
