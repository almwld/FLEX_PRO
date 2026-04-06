import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String name;
  final String? imageUrl;
  final String? parentId;
  
  CategoryModel({
    required this.id,
    required this.name,
    this.imageUrl,
    this.parentId,
  });
  
  IconData get iconData {
    switch (name) {
      case 'إلكترونيات': return Icons.electrical_services;
      case 'ملابس': return Icons.checkroom;
      case 'أطعمة': return Icons.restaurant;
      case 'منزل': return Icons.home;
      case 'رياضة': return Icons.sports_soccer;
      default: return Icons.category;
    }
  }
  
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'],
      parentId: json['parentId'],
    );
  }
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'imageUrl': imageUrl,
    'parentId': parentId,
  };
}
