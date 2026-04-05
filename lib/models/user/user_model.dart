class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String? avatarUrl;
  final String userType; // customer, merchant, guest
  final DateTime? createdAt;
  final bool isVerified;
  final bool isGuest;
  final ViewMode viewMode;
  
  // بيانات إضافية
  final String? nationalId;
  final String? nationality;
  final DateTime? birthDate;
  final String? address;
  final String? city;
  final String? jobTitle;
  final String? companyName;
  
  // بيانات PRO
  final bool isPro;
  final DateTime? proExpiryDate;
  final int proLevel; // 1: Lite, 2: PRO, 3: Expert

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    this.avatarUrl,
    this.userType = 'customer',
    this.createdAt,
    this.isVerified = false,
    this.isGuest = false,
    this.viewMode = ViewMode.lite,
    this.nationalId,
    this.nationality,
    this.birthDate,
    this.address,
    this.city,
    this.jobTitle,
    this.companyName,
    this.isPro = false,
    this.proExpiryDate,
    this.proLevel = 1,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      fullName: json['full_name'] ?? json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      avatarUrl: json['avatar_url'],
      userType: json['user_type'] ?? 'customer',
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      isVerified: json['is_verified'] ?? false,
      isGuest: json['is_guest'] ?? false,
      viewMode: ViewMode.values.firstWhere(
        (e) => e.name == json['view_mode'],
        orElse: () => ViewMode.lite,
      ),
      nationalId: json['national_id'],
      nationality: json['nationality'],
      birthDate: json['birth_date'] != null ? DateTime.parse(json['birth_date']) : null,
      address: json['address'],
      city: json['city'],
      jobTitle: json['job_title'],
      companyName: json['company_name'],
      isPro: json['is_pro'] ?? false,
      proExpiryDate: json['pro_expiry_date'] != null ? DateTime.parse(json['pro_expiry_date']) : null,
      proLevel: json['pro_level'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'avatar_url': avatarUrl,
      'user_type': userType,
      'created_at': createdAt?.toIso8601String(),
      'is_verified': isVerified,
      'is_guest': isGuest,
      'view_mode': viewMode.name,
      'national_id': nationalId,
      'nationality': nationality,
      'birth_date': birthDate?.toIso8601String(),
      'address': address,
      'city': city,
      'job_title': jobTitle,
      'company_name': companyName,
      'is_pro': isPro,
      'pro_expiry_date': proExpiryDate?.toIso8601String(),
      'pro_level': proLevel,
    };
  }
  
  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phone,
    String? avatarUrl,
    String? userType,
    DateTime? createdAt,
    bool? isVerified,
    bool? isGuest,
    ViewMode? viewMode,
    String? nationalId,
    String? nationality,
    DateTime? birthDate,
    String? address,
    String? city,
    String? jobTitle,
    String? companyName,
    bool? isPro,
    DateTime? proExpiryDate,
    int? proLevel,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      userType: userType ?? this.userType,
      createdAt: createdAt ?? this.createdAt,
      isVerified: isVerified ?? this.isVerified,
      isGuest: isGuest ?? this.isGuest,
      viewMode: viewMode ?? this.viewMode,
      nationalId: nationalId ?? this.nationalId,
      nationality: nationality ?? this.nationality,
      birthDate: birthDate ?? this.birthDate,
      address: address ?? this.address,
      city: city ?? this.city,
      jobTitle: jobTitle ?? this.jobTitle,
      companyName: companyName ?? this.companyName,
      isPro: isPro ?? this.isPro,
      proExpiryDate: proExpiryDate ?? this.proExpiryDate,
      proLevel: proLevel ?? this.proLevel,
    );
  }
  
  String get proLevelName {
    switch (proLevel) {
      case 1:
        return 'Lite';
      case 2:
        return 'PRO';
      case 3:
        return 'Expert';
      default:
        return 'Lite';
    }
  }
  
  bool get isProActive {
    if (!isPro || proExpiryDate == null) return false;
    return proExpiryDate!.isAfter(DateTime.now());
  }
}

enum ViewMode { lite, pro, expert }
