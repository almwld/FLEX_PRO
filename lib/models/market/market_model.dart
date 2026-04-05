import 'package:flutter/material.dart';

class MarketModel {
  final String id;
  final String name;
  final String? description;
  final String? imageUrl;
  final IconData? icon;
  final Color color;
  final double change;
  final double changePercentage;
  final String volume;
  final int items;
  final int merchants;
  final bool isActive;
  final List<MarketItem> topItems;
  final DateTime? lastUpdated;
  
  MarketModel({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    this.icon,
    required this.color,
    required this.change,
    required this.changePercentage,
    required this.volume,
    required this.items,
    this.merchants = 0,
    this.isActive = true,
    required this.topItems,
    this.lastUpdated,
  });
  
  factory MarketModel.fromJson(Map<String, dynamic> json) {
    return MarketModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      imageUrl: json['image_url'],
      icon: json['icon'] != null ? IconData(json['icon'], fontFamily: 'MaterialIcons') : null,
      color: Color(json['color'] ?? 0xFFD4AF37),
      change: (json['change'] ?? 0).toDouble(),
      changePercentage: (json['change_percentage'] ?? 0).toDouble(),
      volume: json['volume'] ?? '0',
      items: json['items'] ?? 0,
      merchants: json['merchants'] ?? 0,
      isActive: json['is_active'] ?? true,
      topItems: (json['top_items'] as List?)
          ?.map((e) => MarketItem.fromJson(e))
          .toList() ?? [],
      lastUpdated: json['last_updated'] != null 
          ? DateTime.parse(json['last_updated']) 
          : null,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image_url': imageUrl,
      'icon': icon?.codePoint,
      'color': color.value,
      'change': change,
      'change_percentage': changePercentage,
      'volume': volume,
      'items': items,
      'merchants': merchants,
      'is_active': isActive,
      'top_items': topItems.map((e) => e.toJson()).toList(),
      'last_updated': lastUpdated?.toIso8601String(),
    };
  }
  
  // هل السوق مرتفع
  bool get isUp => change >= 0;
  
  // لون التغيير
  Color get changeColor => isUp ? const Color(0xFF00A15C) : const Color(0xFFE5493A);
  
  // أيقونة التغيير
  IconData get changeIcon => isUp ? Icons.trending_up : Icons.trending_down;
}

class MarketItem {
  final String id;
  final String name;
  final double price;
  final double change;
  final double changePercentage;
  final String? image;
  final String category;
  final String? unit;
  final double? high24h;
  final double? low24h;
  
  MarketItem({
    required this.id,
    required this.name,
    required this.price,
    required this.change,
    required this.changePercentage,
    this.image,
    required this.category,
    this.unit,
    this.high24h,
    this.low24h,
  });
  
  factory MarketItem.fromJson(Map<String, dynamic> json) {
    return MarketItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      change: (json['change'] ?? 0).toDouble(),
      changePercentage: (json['change_percentage'] ?? 0).toDouble(),
      image: json['image'],
      category: json['category'] ?? '',
      unit: json['unit'],
      high24h: json['high_24h']?.toDouble(),
      low24h: json['low_24h']?.toDouble(),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'change': change,
      'change_percentage': changePercentage,
      'image': image,
      'category': category,
      'unit': unit,
      'high_24h': high24h,
      'low_24h': low24h,
    };
  }
  
  // هل السعر مرتفع
  bool get isUp => change >= 0;
  
  // لون التغيير
  Color get changeColor => isUp ? const Color(0xFF00A15C) : const Color(0xFFE5493A);
}

// الأسواق الافتراضية
final List<MarketModel> defaultMarkets = [
  MarketModel(
    id: 'yemeni_market',
    name: 'السوق اليمني',
    description: 'جميع المنتجات اليمنية التقليدية',
    icon: Icons.store,
    color: const Color(0xFFD4AF37),
    change: 1250,
    changePercentage: 2.5,
    volume: '5.2M',
    items: 12500,
    merchants: 850,
    topItems: [
      MarketItem(
        id: '1',
        name: 'التمور',
        price: 3500,
        change: 150,
        changePercentage: 4.5,
        category: 'مواد غذائية',
        unit: 'كجم',
      ),
      MarketItem(
        id: '2',
        name: 'العسل',
        price: 15000,
        change: 500,
        changePercentage: 3.4,
        category: 'مواد غذائية',
        unit: 'كجم',
      ),
      MarketItem(
        id: '3',
        name: 'البن',
        price: 8000,
        change: -200,
        changePercentage: -2.4,
        category: 'مواد غذائية',
        unit: 'كجم',
      ),
    ],
  ),
  MarketModel(
    id: 'malls',
    name: 'المولات',
    description: 'أفضل المولات والمراكز التجارية',
    icon: Icons.shopping_mall,
    color: const Color(0xFF2196F3),
    change: 850,
    changePercentage: 1.8,
    volume: '3.8M',
    items: 8500,
    merchants: 420,
    topItems: [
      MarketItem(
        id: '4',
        name: 'الملابس',
        price: 15000,
        change: 500,
        changePercentage: 3.4,
        category: 'أزياء',
      ),
      MarketItem(
        id: '5',
        name: 'الإلكترونيات',
        price: 250000,
        change: 5000,
        changePercentage: 2.0,
        category: 'تقنية',
      ),
    ],
  ),
  MarketModel(
    id: 'cafes',
    name: 'المقاهي',
    description: 'مقاهي وكوفي شوب',
    icon: Icons.coffee,
    color: const Color(0xFF795548),
    change: 320,
    changePercentage: 3.2,
    volume: '1.5M',
    items: 1200,
    merchants: 180,
    topItems: [
      MarketItem(
        id: '6',
        name: 'قهوة عربية',
        price: 1500,
        change: 50,
        changePercentage: 3.4,
        category: 'مشروبات',
      ),
      MarketItem(
        id: '7',
        name: 'قهوة تركية',
        price: 1200,
        change: 30,
        changePercentage: 2.6,
        category: 'مشروبات',
      ),
    ],
  ),
  MarketModel(
    id: 'rest_houses',
    name: 'الاستراحات',
    description: 'استراحات ومنتجعات',
    icon: Icons.villa,
    color: const Color(0xFF4CAF50),
    change: 450,
    changePercentage: 2.1,
    volume: '2.1M',
    items: 350,
    merchants: 95,
    topItems: [
      MarketItem(
        id: '8',
        name: 'استراحة صغيرة',
        price: 15000,
        change: 500,
        changePercentage: 3.4,
        category: 'إيجار',
        unit: 'يوم',
      ),
      MarketItem(
        id: '9',
        name: 'استراحة كبيرة',
        price: 35000,
        change: 1000,
        changePercentage: 2.9,
        category: 'إيجار',
        unit: 'يوم',
      ),
    ],
  ),
  MarketModel(
    id: 'hotels',
    name: 'الفنادق',
    description: 'فنادق وشقق فندقية',
    icon: Icons.hotel,
    color: const Color(0xFF9C27B0),
    change: 680,
    changePercentage: 2.8,
    volume: '2.8M',
    items: 520,
    merchants: 120,
    topItems: [
      MarketItem(
        id: '10',
        name: 'غرفة فردية',
        price: 25000,
        change: 1000,
        changePercentage: 4.1,
        category: 'إقامة',
        unit: 'ليلة',
      ),
      MarketItem(
        id: '11',
        name: 'غرفة مزدوجة',
        price: 40000,
        change: 1500,
        changePercentage: 3.9,
        category: 'إقامة',
        unit: 'ليلة',
      ),
    ],
  ),
  MarketModel(
    id: 'restaurants',
    name: 'المطاعم',
    description: 'مطاعم ووجبات سريعة',
    icon: Icons.restaurant,
    color: const Color(0xFFFF5722),
    change: 920,
    changePercentage: 3.5,
    volume: '4.2M',
    items: 2800,
    merchants: 350,
    topItems: [
      MarketItem(
        id: '12',
        name: 'مندي',
        price: 8000,
        change: 300,
        changePercentage: 3.9,
        category: 'طعام',
        unit: 'شخص',
      ),
      MarketItem(
        id: '13',
        name: 'زربيان',
        price: 7000,
        change: 250,
        changePercentage: 3.7,
        category: 'طعام',
        unit: 'شخص',
      ),
    ],
  ),
  MarketModel(
    id: 'electronics',
    name: 'الإلكترونيات',
    description: 'أجهزة إلكترونية وتقنية',
    icon: Icons.devices,
    color: const Color(0xFF00BCD4),
    change: 1500,
    changePercentage: 4.2,
    volume: '6.5M',
    items: 9500,
    merchants: 280,
    topItems: [
      MarketItem(
        id: '14',
        name: 'آيفون 15',
        price: 450000,
        change: 15000,
        changePercentage: 3.4,
        category: 'هواتف',
      ),
      MarketItem(
        id: '15',
        name: 'سامسونج S24',
        price: 380000,
        change: 10000,
        changePercentage: 2.7,
        category: 'هواتف',
      ),
    ],
  ),
  MarketModel(
    id: 'cars',
    name: 'السيارات',
    description: 'سيارات جديدة ومستعملة',
    icon: Icons.directions_car,
    color: const Color(0xFFE91E63),
    change: 2100,
    changePercentage: 3.8,
    volume: '8.2M',
    items: 1800,
    merchants: 150,
    topItems: [
      MarketItem(
        id: '16',
        name: 'تويوتا كامري',
        price: 8500000,
        change: 200000,
        changePercentage: 2.4,
        category: 'سيارات',
      ),
      MarketItem(
        id: '17',
        name: 'هونداي توسان',
        price: 6200000,
        change: 150000,
        changePercentage: 2.5,
        category: 'سيارات',
      ),
    ],
  ),
  MarketModel(
    id: 'realestate',
    name: 'العقارات',
    description: 'شقق، فلل، أراضي',
    icon: Icons.apartment,
    color: const Color(0xFF8BC34A),
    change: 3500,
    changePercentage: 2.9,
    volume: '12.5M',
    items: 650,
    merchants: 85,
    topItems: [
      MarketItem(
        id: '18',
        name: 'شقة في صنعاء',
        price: 35000000,
        change: 1000000,
        changePercentage: 2.9,
        category: 'شقق',
      ),
      MarketItem(
        id: '19',
        name: 'فيلا في السنينة',
        price: 85000000,
        change: 2500000,
        changePercentage: 3.0,
        category: 'فلل',
      ),
    ],
  ),
  MarketModel(
    id: 'fashion',
    name: 'الأزياء',
    description: 'ملابس، أحذية، إكسسوارات',
    icon: Icons.checkroom,
    color: const Color(0xFFFF9800),
    change: 780,
    changePercentage: 2.4,
    volume: '3.2M',
    items: 15000,
    merchants: 520,
    topItems: [
      MarketItem(
        id: '20',
        name: 'ثوب يمني',
        price: 15000,
        change: 500,
        changePercentage: 3.4,
        category: 'ملابس',
      ),
      MarketItem(
        id: '21',
        name: 'شال يمني',
        price: 5000,
        change: 200,
        changePercentage: 4.1,
        category: 'إكسسوارات',
      ),
    ],
  ),
];
