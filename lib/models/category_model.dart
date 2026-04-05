// lib/models/category_model.dart

import 'package:flutter/material.dart';

/// نموذج الفئة/التصنيف
class CategoryModel {
  final String id;
  final String name;
  final String? nameEn;
  final String? description;
  final String? icon;
  final IconData? iconData;
  final String? imageUrl;
  final String? parentId;
  final int sortOrder;
  final bool isActive;
  final int productCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<CategoryModel> subCategories;
  final Color? color;

  CategoryModel({
    required this.id,
    required this.name,
    this.nameEn,
    this.description,
    this.icon,
    this.iconData,
    this.imageUrl,
    this.parentId,
    this.sortOrder = 0,
    this.isActive = true,
    this.productCount = 0,
    required this.createdAt,
    required this.updatedAt,
    this.subCategories = const [],
    this.color,
  });

  /// هل الفئة رئيسية
  bool get isMainCategory => parentId == null || parentId!.isEmpty;

  /// هل لديه فئات فرعية
  bool get hasSubCategories => subCategories.isNotEmpty;

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      nameEn: json['nameEn'],
      description: json['description'],
      icon: json['icon'],
      iconData: json['iconData'] != null 
          ? IconData(json['iconData'], fontFamily: 'MaterialIcons')
          : null,
      imageUrl: json['imageUrl'],
      parentId: json['parentId'],
      sortOrder: json['sortOrder'] ?? 0,
      isActive: json['isActive'] ?? true,
      productCount: json['productCount'] ?? 0,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
      subCategories: json['subCategories'] != null
          ? (json['subCategories'] as List)
              .map((c) => CategoryModel.fromJson(c))
              .toList()
          : [],
      color: json['color'] != null ? Color(json['color']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nameEn': nameEn,
      'description': description,
      'icon': icon,
      'iconData': iconData?.codePoint,
      'imageUrl': imageUrl,
      'parentId': parentId,
      'sortOrder': sortOrder,
      'isActive': isActive,
      'productCount': productCount,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'subCategories': subCategories.map((c) => c.toJson()).toList(),
      'color': color?.value,
    };
  }

  CategoryModel copyWith({
    String? id,
    String? name,
    String? nameEn,
    String? description,
    String? icon,
    IconData? iconData,
    String? imageUrl,
    String? parentId,
    int? sortOrder,
    bool? isActive,
    int? productCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<CategoryModel>? subCategories,
    Color? color,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      nameEn: nameEn ?? this.nameEn,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      iconData: iconData ?? this.iconData,
      imageUrl: imageUrl ?? this.imageUrl,
      parentId: parentId ?? this.parentId,
      sortOrder: sortOrder ?? this.sortOrder,
      isActive: isActive ?? this.isActive,
      productCount: productCount ?? this.productCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      subCategories: subCategories ?? this.subCategories,
      color: color ?? this.color,
    );
  }
}
