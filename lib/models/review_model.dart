// lib/models/review_model.dart

/// نموذج التقييم
class ReviewModel {
  final String id;
  final String userId;
  final String userName;
  final String? userAvatar;
  final String productId;
  final String? orderId;
  final double rating;
  final String? title;
  final String comment;
  final List<String>? images;
  final int helpfulCount;
  final bool isVerifiedPurchase;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? sellerResponse;
  final DateTime? responseDate;

  ReviewModel({
    required this.id,
    required this.userId,
    required this.userName,
    this.userAvatar,
    required this.productId,
    this.orderId,
    required this.rating,
    this.title,
    required this.comment,
    this.images,
    this.helpfulCount = 0,
    this.isVerifiedPurchase = false,
    required this.createdAt,
    this.updatedAt,
    this.sellerResponse,
    this.responseDate,
  });

  /// نجوم التقييم
  String get stars {
    return '★' * rating.round() + '☆' * (5 - rating.round());
  }

  /// هل هناك رد من البائع
  bool get hasSellerResponse => sellerResponse != null && sellerResponse!.isNotEmpty;

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      userAvatar: json['userAvatar'],
      productId: json['productId'] ?? '',
      orderId: json['orderId'],
      rating: (json['rating'] ?? 0.0).toDouble(),
      title: json['title'],
      comment: json['comment'] ?? '',
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      helpfulCount: json['helpfulCount'] ?? 0,
      isVerifiedPurchase: json['isVerifiedPurchase'] ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
      sellerResponse: json['sellerResponse'],
      responseDate: json['responseDate'] != null
          ? DateTime.parse(json['responseDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userAvatar': userAvatar,
      'productId': productId,
      'orderId': orderId,
      'rating': rating,
      'title': title,
      'comment': comment,
      'images': images,
      'helpfulCount': helpfulCount,
      'isVerifiedPurchase': isVerifiedPurchase,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'sellerResponse': sellerResponse,
      'responseDate': responseDate?.toIso8601String(),
    };
  }

  ReviewModel copyWith({
    String? id,
    String? userId,
    String? userName,
    String? userAvatar,
    String? productId,
    String? orderId,
    double? rating,
    String? title,
    String? comment,
    List<String>? images,
    int? helpfulCount,
    bool? isVerifiedPurchase,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? sellerResponse,
    DateTime? responseDate,
  }) {
    return ReviewModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      productId: productId ?? this.productId,
      orderId: orderId ?? this.orderId,
      rating: rating ?? this.rating,
      title: title ?? this.title,
      comment: comment ?? this.comment,
      images: images ?? this.images,
      helpfulCount: helpfulCount ?? this.helpfulCount,
      isVerifiedPurchase: isVerifiedPurchase ?? this.isVerifiedPurchase,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      sellerResponse: sellerResponse ?? this.sellerResponse,
      responseDate: responseDate ?? this.responseDate,
    );
  }
}

/// ملخص التقييمات
class ReviewSummary {
  final double averageRating;
  final int totalReviews;
  final Map<int, int> ratingDistribution;

  ReviewSummary({
    required this.averageRating,
    required this.totalReviews,
    required this.ratingDistribution,
  });

  /// نسبة كل تقييم
  double getRatingPercent(int rating) {
    if (totalReviews == 0) return 0;
    return (ratingDistribution[rating] ?? 0) / totalReviews * 100;
  }

  factory ReviewSummary.fromReviews(List<ReviewModel> reviews) {
    if (reviews.isEmpty) {
      return ReviewSummary(
        averageRating: 0,
        totalReviews: 0,
        ratingDistribution: {5: 0, 4: 0, 3: 0, 2: 0, 1: 0},
      );
    }

    final distribution = <int, int>{5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
    double totalRating = 0;

    for (final review in reviews) {
      final rating = review.rating.round();
      distribution[rating] = (distribution[rating] ?? 0) + 1;
      totalRating += review.rating;
    }

    return ReviewSummary(
      averageRating: totalRating / reviews.length,
      totalReviews: reviews.length,
      ratingDistribution: distribution,
    );
  }
}
