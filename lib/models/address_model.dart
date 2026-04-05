// lib/models/address_model.dart

/// نوع العنوان
enum AddressType {
  home,     // منزل
  work,     // عمل
  other,    // أخرى
}

/// نموذج العنوان
class AddressModel {
  final String id;
  final String userId;
  final String name;
  final String phone;
  final AddressType type;
  final String city;
  final String? district;
  final String street;
  final String? building;
  final String? floor;
  final String? apartment;
  final String? landmark;
  final String? notes;
  final double? latitude;
  final double? longitude;
  final bool isDefault;
  final DateTime createdAt;
  final DateTime updatedAt;

  AddressModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.phone,
    this.type = AddressType.home,
    required this.city,
    this.district,
    required this.street,
    this.building,
    this.floor,
    this.apartment,
    this.landmark,
    this.notes,
    this.latitude,
    this.longitude,
    this.isDefault = false,
    required this.createdAt,
    required this.updatedAt,
  });

  /// العنوان الكامل
  String get fullAddress {
    final parts = <String>[];
    if (city.isNotEmpty) parts.add(city);
    if (district != null && district!.isNotEmpty) parts.add(district!);
    if (street.isNotEmpty) parts.add(street);
    if (building != null && building!.isNotEmpty) parts.add('مبنى: $building');
    if (floor != null && floor!.isNotEmpty) parts.add('الدور: $floor');
    if (apartment != null && apartment!.isNotEmpty) parts.add('شقة: $apartment');
    return parts.join('، ');
  }

  /// العنوان المختصر
  String get shortAddress {
    final parts = <String>[];
    if (city.isNotEmpty) parts.add(city);
    if (district != null && district!.isNotEmpty) parts.add(district!);
    if (street.isNotEmpty) parts.add(street);
    return parts.join('، ');
  }

  /// نص نوع العنوان
  String get typeText {
    switch (type) {
      case AddressType.home:
        return 'المنزل';
      case AddressType.work:
        return 'العمل';
      case AddressType.other:
        return 'أخرى';
    }
  }

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      type: AddressType.values.firstWhere(
        (e) => e.toString() == 'AddressType.${json['type']}',
        orElse: () => AddressType.home,
      ),
      city: json['city'] ?? '',
      district: json['district'],
      street: json['street'] ?? '',
      building: json['building'],
      floor: json['floor'],
      apartment: json['apartment'],
      landmark: json['landmark'],
      notes: json['notes'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      isDefault: json['isDefault'] ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'phone': phone,
      'type': type.toString().split('.').last,
      'city': city,
      'district': district,
      'street': street,
      'building': building,
      'floor': floor,
      'apartment': apartment,
      'landmark': landmark,
      'notes': notes,
      'latitude': latitude,
      'longitude': longitude,
      'isDefault': isDefault,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  AddressModel copyWith({
    String? id,
    String? userId,
    String? name,
    String? phone,
    AddressType? type,
    String? city,
    String? district,
    String? street,
    String? building,
    String? floor,
    String? apartment,
    String? landmark,
    String? notes,
    double? latitude,
    double? longitude,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AddressModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      type: type ?? this.type,
      city: city ?? this.city,
      district: district ?? this.district,
      street: street ?? this.street,
      building: building ?? this.building,
      floor: floor ?? this.floor,
      apartment: apartment ?? this.apartment,
      landmark: landmark ?? this.landmark,
      notes: notes ?? this.notes,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
