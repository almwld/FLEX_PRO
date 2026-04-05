// lib/models/market_model.dart

/// حالة المتجر
enum MarketStatus {
  active,      // نشط
  inactive,    // غير نشط
  suspended,   // موقوف
  pending,     // قيد المراجعة
}

/// نموذج المتجر/التاجر
class MarketModel {
  final String id;
  final String name;
  final String? nameEn;
  final String? description;
  final String? logoUrl;
  final String? coverUrl;
  final String? email;
  final String? phone;
  final String? address;
  final String? city;
  final double? latitude;
  final double? longitude;
  final MarketStatus status;
  final double rating;
  final int reviewCount;
  final int productCount;
  final int orderCount;
  final bool isVerified;
  final bool isFeatured;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> categoryIds;
  final Map<String, dynamic>? businessInfo;
  final Map<String, dynamic>? socialLinks;
  final String? website;

  MarketModel({
    required this.id,
    required this.name,
    this.nameEn,
    this.description,
    this.logoUrl,
    this.coverUrl,
    this.email,
    this.phone,
    this.address,
    this.city,
    this.latitude,
    this.longitude,
    this.status = MarketStatus.pending,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.productCount = 0,
    this.orderCount = 0,
    this.isVerified = false,
    this.isFeatured = false,
    required this.createdAt,
    required this.updatedAt,
    this.categoryIds = const [],
    this.businessInfo,
    this.socialLinks,
    this.website,
  });

  /// هل المتجر نشط
  bool get isActive => status == MarketStatus.active;

  /// نص الحالة بالعربية
  String get statusText {
    switch (status) {
      case MarketStatus.active:
        return 'نشط';
      case MarketStatus.inactive:
        return 'غير نشط';
      case MarketStatus.suspended:
        return 'موقوف';
      case MarketStatus.pending:
        return 'قيد المراجعة';
    }
  }

  factory MarketModel.fromJson(Map<String, dynamic> json) {
    return MarketModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      nameEn: json['nameEn'],
      description: json['description'],
      logoUrl: json['logoUrl'],
      coverUrl: json['coverUrl'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      city: json['city'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      status: MarketStatus.values.firstWhere(
        (e) => e.toString() == 'MarketStatus.${json['status']}',
        orElse: () => MarketStatus.pending,
      ),
      rating: (json['rating'] ?? 0.0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      productCount: json['productCount'] ?? 0,
      orderCount: json['orderCount'] ?? 0,
      isVerified: json['isVerified'] ?? false,
      isFeatured: json['isFeatured'] ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
      categoryIds: json['categoryIds'] != null
          ? List<String>.from(json['categoryIds'])
          : [],
      businessInfo: json['businessInfo'],
      socialLinks: json['socialLinks'],
      website: json['website'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nameEn': nameEn,
      'description': description,
      'logoUrl': logoUrl,
      'coverUrl': coverUrl,
      'email': email,
      'phone': phone,
      'address': address,
      'city': city,
      'latitude': latitude,
      'longitude': longitude,
      'status': status.toString().split('.').last,
      'rating': rating,
      'reviewCount': reviewCount,
      'productCount': productCount,
      'orderCount': orderCount,
      'isVerified': isVerified,
      'isFeatured': isFeatured,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'categoryIds': categoryIds,
      'businessInfo': businessInfo,
      'socialLinks': socialLinks,
      'website': website,
    };
  }

  MarketModel copyWith({
    String? id,
    String? name,
    String? nameEn,
    String? description,
    String? logoUrl,
    String? coverUrl,
    String? email,
    String? phone,
    String? address,
    String? city,
    double? latitude,
    double? longitude,
    MarketStatus? status,
    double? rating,
    int? reviewCount,
    int? productCount,
    int? orderCount,
    bool? isVerified,
    bool? isFeatured,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? categoryIds,
    Map<String, dynamic>? businessInfo,
    Map<String, dynamic>? socialLinks,
    String? website,
  }) {
    return MarketModel(
      id: id ?? this.id,
      name: name ?? this.name,
      nameEn: nameEn ?? this.nameEn,
      description: description ?? this.description,
      logoUrl: logoUrl ?? this.logoUrl,
      coverUrl: coverUrl ?? this.coverUrl,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      city: city ?? this.city,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      status: status ?? this.status,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      productCount: productCount ?? this.productCount,
      orderCount: orderCount ?? this.orderCount,
      isVerified: isVerified ?? this.isVerified,
      isFeatured: isFeatured ?? this.isFeatured,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      categoryIds: categoryIds ?? this.categoryIds,
      businessInfo: businessInfo ?? this.businessInfo,
      socialLinks: socialLinks ?? this.socialLinks,
      website: website ?? this.website,
    );
  }
}
