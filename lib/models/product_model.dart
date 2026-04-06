import 'package:flutter/material.dart';

class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? discountPrice;
  final bool hasDiscount;
  final bool isFavorite;
  final List<String> images;
  final String categoryId;
  final String? marketId;
  final String? marketName;
  final int stockQuantity;
  final bool isInStock;
  final double rating;
  final int reviewCount;
  final DateTime createdAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.discountPrice,
    this.hasDiscount = false,
    this.isFavorite = false,
    required this.images,
    required this.categoryId,
    this.marketId,
    this.marketName,
    this.stockQuantity = 0,
    this.isInStock = true,
    this.rating = 0.0,
    this.reviewCount = 0,
    required this.createdAt,
  });

  double get discountPercent {
    if (!hasDiscount || discountPrice == null) return 0;
    return ((price - discountPrice!) / price * 100).roundToDouble();
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? json['productName'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      discountPrice: json['discountPrice']?.toDouble(),
      hasDiscount: json['hasDiscount'] ?? false,
      isFavorite: json['isFavorite'] ?? false,
      images: json['images'] != null ? List<String>.from(json['images']) : [],
      categoryId: json['categoryId'] ?? '',
      marketId: json['marketId'],
      marketName: json['marketName'],
      stockQuantity: json['stockQuantity'] ?? 0,
      isInStock: json['isInStock'] ?? true,
      rating: (json['rating'] ?? 0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'price': price,
    'discountPrice': discountPrice,
    'hasDiscount': hasDiscount,
    'isFavorite': isFavorite,
    'images': images,
    'categoryId': categoryId,
    'marketId': marketId,
    'marketName': marketName,
    'stockQuantity': stockQuantity,
    'isInStock': isInStock,
    'rating': rating,
    'reviewCount': reviewCount,
    'createdAt': createdAt.toIso8601String(),
  };
}

  ProductModel copyWith({
    bool? isFavorite,
  }) {
    return ProductModel(
      id: id,
      name: name,
      description: description,
      price: price,
      discountPrice: discountPrice,
      hasDiscount: hasDiscount,
      isFavorite: isFavorite ?? this.isFavorite,
      images: images,
      categoryId: categoryId,
      marketId: marketId,
      marketName: marketName,
      stockQuantity: stockQuantity,
      isInStock: isInStock,
      rating: rating,
      reviewCount: reviewCount,
      createdAt: createdAt,
    );
  }
