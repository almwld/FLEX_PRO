import 'dart:convert';

/// نموذج المنتج
class ProductModel {
  final String id;
  final String name;
  final String name;
  final String title;
  final String description;
  final double price;
  final double? discountPrice;
  final bool hasDiscount;
  final bool isFavorite;
  final double? discountPrice;
  final bool hasDiscount;
  final bool isFavorite;
  final String? marketId;
  final String? marketName;
  final int stockQuantity;
  final bool isInStock;
  final double? originalPrice;
  final List<String> images;
  final String category;
  final String? subcategory;
  final String city;
  final String sellerId;
  final String sellerName;
  final String? sellerAvatar;
  final double? rating;
  final int? reviewCount;
  final DateTime createdAt;
  final bool isFeatured;
  final bool isAuction;
  final DateTime? auctionEndTime;
  final double? currentBid;
  final int? quantity;
  final String? condition; // new, used, refurbished
  final List<String>? tags;
  final double? discount;
  final bool isActive;
  final int viewCount;
  final int favoriteCount;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    this.originalPrice,
    required this.images,
    required this.category,
    this.subcategory,
    required this.city,
    required this.sellerId,
    required this.sellerName,
    this.sellerAvatar,
    this.rating,
    this.reviewCount,
    required this.createdAt,
    this.isFeatured = false,
    this.isAuction = false,
    this.auctionEndTime,
    this.currentBid,
    this.quantity,
    this.condition,
    this.tags,
    this.discount,
    this.isActive = true,
    this.viewCount = 0,
    this.favoriteCount = 0,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      originalPrice: json['original_price']?.toDouble(),
      images: List<String>.from(json['images'] ?? []),
      category: json['category'] ?? '',
      subcategory: json['subcategory'],
      city: json['city'] ?? '',
      sellerId: json['seller_id'] ?? '',
      sellerName: json['seller_name'] ?? '',
      sellerAvatar: json['seller_avatar'],
      rating: json['rating']?.toDouble(),
      reviewCount: json['review_count'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      isFeatured: json['is_featured'] ?? false,
      isAuction: json['is_auction'] ?? false,
      auctionEndTime: json['auction_end_time'] != null 
          ? DateTime.parse(json['auction_end_time']) 
          : null,
      currentBid: json['current_bid']?.toDouble(),
      quantity: json['quantity'],
      condition: json['condition'],
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
      discount: json['discount']?.toDouble(),
      isActive: json['is_active'] ?? true,
      viewCount: json['view_count'] ?? 0,
      favoriteCount: json['favorite_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'original_price': originalPrice,
      'images': images,
      'category': category,
      'subcategory': subcategory,
      'city': city,
      'seller_id': sellerId,
      'seller_name': sellerName,
      'seller_avatar': sellerAvatar,
      'rating': rating,
      'review_count': reviewCount,
      'created_at': createdAt.toIso8601String(),
      'is_featured': isFeatured,
      'is_auction': isAuction,
      'auction_end_time': auctionEndTime?.toIso8601String(),
      'current_bid': currentBid,
      'quantity': quantity,
      'condition': condition,
      'tags': tags,
      'discount': discount,
      'is_active': isActive,
      'view_count': viewCount,
      'favorite_count': favoriteCount,
    };
  }
  
  // حساب نسبة الخصم
  int? get discountPercentage {
    if (originalPrice == null || originalPrice == 0) return null;
    return (((originalPrice! - price) / originalPrice!) * 100).round();
  }
  
  // السعر بعد الخصم
  double get finalPrice {
    if (discount != null && discount! > 0) {
      return price - (price * discount! / 100);
    }
    return price;
  }
  
  // حالة المنتج
  String get conditionText {
    switch (condition) {
      case 'new':
        return 'جديد';
      case 'used':
        return 'مستعمل';
      case 'refurbished':
        return 'مجدد';
      default:
        return 'جديد';
    }
  }
  
  // هل المزاد نشط
  bool get isAuctionActive {
    if (!isAuction || auctionEndTime == null) return false;
    return auctionEndTime!.isAfter(DateTime.now());
  }
  
  // الوقت المتبقي للمزاد
  String? get auctionTimeLeft {
    if (!isAuctionActive) return null;
    final diff = auctionEndTime!.difference(DateTime.now());
    if (diff.inDays > 0) return '${diff.inDays} يوم';
    if (diff.inHours > 0) return '${diff.inHours} ساعة';
    if (diff.inMinutes > 0) return '${diff.inMinutes} دقيقة';
    return '${diff.inSeconds} ثانية';
  }
  
  ProductModel copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    double? originalPrice,
    List<String>? images,
    String? category,
    String? subcategory,
    String? city,
    String? sellerId,
    String? sellerName,
    String? sellerAvatar,
    double? rating,
    int? reviewCount,
    DateTime? createdAt,
    bool? isFeatured,
    bool? isAuction,
    DateTime? auctionEndTime,
    double? currentBid,
    int? quantity,
    String? condition,
    List<String>? tags,
    double? discount,
    bool? isActive,
    int? viewCount,
    int? favoriteCount,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      images: images ?? this.images,
      category: category ?? this.category,
      subcategory: subcategory ?? this.subcategory,
      city: city ?? this.city,
      sellerId: sellerId ?? this.sellerId,
      sellerName: sellerName ?? this.sellerName,
      sellerAvatar: sellerAvatar ?? this.sellerAvatar,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      createdAt: createdAt ?? this.createdAt,
      isFeatured: isFeatured ?? this.isFeatured,
      isAuction: isAuction ?? this.isAuction,
      auctionEndTime: auctionEndTime ?? this.auctionEndTime,
      currentBid: currentBid ?? this.currentBid,
      quantity: quantity ?? this.quantity,
      condition: condition ?? this.condition,
      tags: tags ?? this.tags,
      discount: discount ?? this.discount,
      isActive: isActive ?? this.isActive,
      viewCount: viewCount ?? this.viewCount,
      favoriteCount: favoriteCount ?? this.favoriteCount,
    );
  }
  
  String toRawJson() => jsonEncode(toJson());
  
  factory ProductModel.fromRawJson(String str) => ProductModel.fromJson(jsonDecode(str));
}

// منتجات افتراضية
final List<ProductModel> sampleProducts = [
  ProductModel(
    id: '1',
    title: 'آيفون 15 برو ماكس',
    description: 'هاتف آيفون 15 برو ماكس 256GB - تيتانيوم طبيعي',
    price: 450000,
    originalPrice: 500000,
    images: ['https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400'],
    category: 'إلكترونيات',
    city: 'صنعاء',
    sellerId: '1',
    sellerName: 'متجر التقنية',
    rating: 4.9,
    reviewCount: 128,
    createdAt: DateTime.now(),
    isFeatured: true,
    condition: 'new',
    tags: ['آيفون', 'أبل', 'هاتف'],
  ),
  ProductModel(
    id: '2',
    title: 'سامسونج S24 الترا',
    description: 'سامسونج جالاكسي S24 الترا 512GB - رمادي تيتانيوم',
    price: 380000,
    images: ['https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=400'],
    category: 'إلكترونيات',
    city: 'صنعاء',
    sellerId: '1',
    sellerName: 'متجر التقنية',
    rating: 4.8,
    reviewCount: 95,
    createdAt: DateTime.now(),
    isFeatured: true,
    condition: 'new',
    tags: ['سامسونج', 'أندرويد', 'هاتف'],
  ),
  ProductModel(
    id: '3',
    title: 'ماك بوك برو M3',
    description: 'ماك بوك برو M3 14 بوصة - 18GB RAM - 512GB SSD',
    price: 1800000,
    images: ['https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400'],
    category: 'إلكترونيات',
    city: 'عدن',
    sellerId: '1',
    sellerName: 'متجر التقنية',
    rating: 4.9,
    reviewCount: 67,
    createdAt: DateTime.now(),
    isFeatured: true,
    condition: 'new',
    tags: ['أبل', 'ماك', 'لابتوب'],
  ),
];
