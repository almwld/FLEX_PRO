import 'dart:convert';

enum ViewMode { lite, pro, expert }

class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String? avatarUrl;
  final String userType;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool isVerified;
  final bool isGuest;
  final ViewMode viewMode;
  final bool isPro;
  final DateTime? proExpiryDate;
  final int proLevel;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    this.avatarUrl,
    this.userType = 'customer',
    this.createdAt,
    this.updatedAt,
    this.isVerified = false,
    this.isGuest = false,
    this.viewMode = ViewMode.lite,
    this.isPro = false,
    this.proExpiryDate,
    this.proLevel = 1,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? json['full_name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      avatarUrl: json['avatarUrl'] ?? json['avatar_url'],
      userType: json['userType'] ?? json['user_type'] ?? 'customer',
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      isVerified: json['isVerified'] ?? json['is_verified'] ?? false,
      isGuest: json['isGuest'] ?? json['is_guest'] ?? false,
      viewMode: json['viewMode'] != null
          ? ViewMode.values.firstWhere((e) => e.name == json['viewMode'])
          : ViewMode.lite,
      isPro: json['isPro'] ?? json['is_pro'] ?? false,
      proExpiryDate: json['proExpiryDate'] != null ? DateTime.parse(json['proExpiryDate']) : null,
      proLevel: json['proLevel'] ?? json['pro_level'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'fullName': fullName,
    'email': email,
    'phone': phone,
    'avatarUrl': avatarUrl,
    'userType': userType,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    'isVerified': isVerified,
    'isGuest': isGuest,
    'viewMode': viewMode.name,
    'isPro': isPro,
    'proExpiryDate': proExpiryDate?.toIso8601String(),
    'proLevel': proLevel,
  };

  UserModel copyWith({bool? isPro, int? proLevel, DateTime? proExpiryDate, ViewMode? viewMode}) {
    return UserModel(
      id: id,
      fullName: fullName,
      email: email,
      phone: phone,
      avatarUrl: avatarUrl,
      userType: userType,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      isVerified: isVerified,
      isGuest: isGuest,
      viewMode: viewMode ?? this.viewMode,
      isPro: isPro ?? this.isPro,
      proExpiryDate: proExpiryDate ?? this.proExpiryDate,
      proLevel: proLevel ?? this.proLevel,
    );
  }
}
