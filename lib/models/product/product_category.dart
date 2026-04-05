import 'package:flutter/material.dart';

class ProductCategory {
  final String id;
  final String name;
  final String? parentId;
  final String? imageUrl;
  final IconData? icon;
  final String? description;
  final int? productCount;
  final bool isActive;
  final List<ProductCategory>? subcategories;
  final Color? color;
  
  ProductCategory({
    required this.id,
    required this.name,
    this.parentId,
    this.imageUrl,
    this.icon,
    this.description,
    this.productCount,
    this.isActive = true,
    this.subcategories,
    this.color,
  });
  
  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      parentId: json['parent_id'],
      imageUrl: json['image_url'],
      icon: json['icon'] != null ? IconData(json['icon'], fontFamily: 'MaterialIcons') : null,
      description: json['description'],
      productCount: json['product_count'],
      isActive: json['is_active'] ?? true,
      subcategories: json['subcategories'] != null 
          ? (json['subcategories'] as List).map((s) => ProductCategory.fromJson(s)).toList()
          : null,
      color: json['color'] != null ? Color(json['color']) : null,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'parent_id': parentId,
      'image_url': imageUrl,
      'icon': icon?.codePoint,
      'description': description,
      'product_count': productCount,
      'is_active': isActive,
      'subcategories': subcategories?.map((s) => s.toJson()).toList(),
      'color': color?.value,
    };
  }
  
  bool get isMainCategory => parentId == null;
}

// قائمة الفئات الرئيسية
final List<ProductCategory> mainCategories = [
  ProductCategory(
    id: 'electronics',
    name: 'إلكترونيات',
    icon: Icons.devices,
    imageUrl: 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=300',
    description: 'هواتف، كمبيوترات، أجهزة إلكترونية',
    productCount: 1250,
    color: Colors.blue,
    subcategories: [
      ProductCategory(id: 'phones', name: 'جوالات', parentId: 'electronics', icon: Icons.smartphone),
      ProductCategory(id: 'laptops', name: 'كمبيوترات', parentId: 'electronics', icon: Icons.laptop),
      ProductCategory(id: 'tvs', name: 'تلفزيونات', parentId: 'electronics', icon: Icons.tv),
      ProductCategory(id: 'cameras', name: 'كاميرات', parentId: 'electronics', icon: Icons.camera_alt),
      ProductCategory(id: 'gaming', name: 'ألعاب', parentId: 'electronics', icon: Icons.sports_esports),
    ],
  ),
  ProductCategory(
    id: 'cars',
    name: 'سيارات',
    icon: Icons.directions_car,
    imageUrl: 'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=300',
    description: 'سيارات جديدة ومستعملة وقطع غيار',
    productCount: 890,
    color: Colors.red,
    subcategories: [
      ProductCategory(id: 'new_cars', name: 'سيارات جديدة', parentId: 'cars', icon: Icons.fiber_new),
      ProductCategory(id: 'used_cars', name: 'سيارات مستعملة', parentId: 'cars', icon: Icons.time_to_leave),
      ProductCategory(id: 'spare_parts', name: 'قطع غيار', parentId: 'cars', icon: Icons.build),
      ProductCategory(id: 'accessories', name: 'إكسسوارات', parentId: 'cars', icon: Icons.car_repair),
    ],
  ),
  ProductCategory(
    id: 'realestate',
    name: 'عقارات',
    icon: Icons.apartment,
    imageUrl: 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=300',
    description: 'شقق، فلل، أراضي للبيع والإيجار',
    productCount: 650,
    color: Colors.green,
    subcategories: [
      ProductCategory(id: 'apartments', name: 'شقق', parentId: 'realestate', icon: Icons.apartment),
      ProductCategory(id: 'villas', name: 'فلل', parentId: 'realestate', icon: Icons.villa),
      ProductCategory(id: 'lands', name: 'أراضي', parentId: 'realestate', icon: Icons.terrain),
      ProductCategory(id: 'commercial', name: 'تجاري', parentId: 'realestate', icon: Icons.business),
    ],
  ),
  ProductCategory(
    id: 'fashion',
    name: 'أزياء',
    icon: Icons.checkroom,
    imageUrl: 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=300',
    description: 'ملابس، أحذية، إكسسوارات',
    productCount: 2100,
    color: Colors.purple,
    subcategories: [
      ProductCategory(id: 'men', name: 'رجالي', parentId: 'fashion', icon: Icons.male),
      ProductCategory(id: 'women', name: 'نسائي', parentId: 'fashion', icon: Icons.female),
      ProductCategory(id: 'kids', name: 'أطفال', parentId: 'fashion', icon: Icons.child_care),
      ProductCategory(id: 'shoes', name: 'أحذية', parentId: 'fashion', icon: Icons.shopping_bag),
      ProductCategory(id: 'bags', name: 'حقائب', parentId: 'fashion', icon: Icons.shopping_bag),
    ],
  ),
  ProductCategory(
    id: 'furniture',
    name: 'أثاث',
    icon: Icons.chair,
    imageUrl: 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=300',
    description: 'غرف نوم، مجالس، مطابخ',
    productCount: 780,
    color: Colors.brown,
    subcategories: [
      ProductCategory(id: 'bedroom', name: 'غرف نوم', parentId: 'furniture', icon: Icons.bed),
      ProductCategory(id: 'living', name: 'مجالس', parentId: 'furniture', icon: Icons.weekend),
      ProductCategory(id: 'kitchen', name: 'مطابخ', parentId: 'furniture', icon: Icons.kitchen),
      ProductCategory(id: 'office', name: 'مكتبي', parentId: 'furniture', icon: Icons.desk),
    ],
  ),
  ProductCategory(
    id: 'restaurants',
    name: 'مطاعم',
    icon: Icons.restaurant,
    imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=300',
    description: 'وجبات، منيو، عروض طعام',
    productCount: 450,
    color: Colors.orange,
    subcategories: [
      ProductCategory(id: 'fast_food', name: 'وجبات سريعة', parentId: 'restaurants', icon: Icons.fastfood),
      ProductCategory(id: 'traditional', name: 'يمني تقليدي', parentId: 'restaurants', icon: Icons.rice_bowl),
      ProductCategory(id: 'international', name: 'عالمي', parentId: 'restaurants', icon: Icons.local_dining),
      ProductCategory(id: 'desserts', name: 'حلويات', parentId: 'restaurants', icon: Icons.cake),
    ],
  ),
  ProductCategory(
    id: 'services',
    name: 'خدمات',
    icon: Icons.build,
    imageUrl: 'https://images.unsplash.com/photo-1450101499163-c8848c66ca85?w=300',
    description: 'خدمات منزلية، مهنية، صيانة',
    productCount: 320,
    color: Colors.teal,
    subcategories: [
      ProductCategory(id: 'cleaning', name: 'تنظيف', parentId: 'services', icon: Icons.cleaning_services),
      ProductCategory(id: 'repair', name: 'صيانة', parentId: 'services', icon: Icons.handyman),
      ProductCategory(id: 'transport', name: 'نقل', parentId: 'services', icon: Icons.local_shipping),
      ProductCategory(id: 'teaching', name: 'تعليم', parentId: 'services', icon: Icons.school),
    ],
  ),
  ProductCategory(
    id: 'beauty',
    name: 'صحة وجمال',
    icon: Icons.spa,
    imageUrl: 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=300',
    description: 'مكياج، عناية بالبشرة، عطور',
    productCount: 560,
    color: Colors.pink,
    subcategories: [
      ProductCategory(id: 'makeup', name: 'مكياج', parentId: 'beauty', icon: Icons.face),
      ProductCategory(id: 'skincare', name: 'عناية بالبشرة', parentId: 'beauty', icon: Icons.water_drop),
      ProductCategory(id: 'perfumes', name: 'عطور', parentId: 'beauty', icon: Icons.local_florist),
      ProductCategory(id: 'hair', name: 'عناية بالشعر', parentId: 'beauty', icon: Icons.content_cut),
    ],
  ),
  ProductCategory(
    id: 'sports',
    name: 'رياضة',
    icon: Icons.sports,
    imageUrl: 'https://images.unsplash.com/photo-1461896836934-ffe807baa261?w=300',
    description: 'معدات رياضية، ملابس، إكسسوارات',
    productCount: 430,
    color: Colors.indigo,
    subcategories: [
      ProductCategory(id: 'gym', name: 'أجهزة رياضية', parentId: 'sports', icon: Icons.fitness_center),
      ProductCategory(id: 'outdoor', name: 'رياضات خارجية', parentId: 'sports', icon: Icons.hiking),
      ProductCategory(id: 'balls', name: 'كرات', parentId: 'sports', icon: Icons.sports_soccer),
      ProductCategory(id: 'clothing', name: 'ملابس رياضية', parentId: 'sports', icon: Icons.checkroom),
    ],
  ),
  ProductCategory(
    id: 'books',
    name: 'كتب وتعليم',
    icon: Icons.menu_book,
    imageUrl: 'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?w=300',
    description: 'كتب، دورات، مستلزمات تعليمية',
    productCount: 290,
    color: Colors.amber,
    subcategories: [
      ProductCategory(id: 'novels', name: 'روايات', parentId: 'books', icon: Icons.auto_stories),
      ProductCategory(id: 'educational', name: 'تعليمية', parentId: 'books', icon: Icons.school),
      ProductCategory(id: 'religious', name: 'دينية', parentId: 'books', icon: Icons.mosque),
      ProductCategory(id: 'children', name: 'أطفال', parentId: 'books', icon: Icons.child_care),
    ],
  ),
];

// قائمة الفئات الكاملة (52 فئة)
final List<ProductCategory> allCategories = [
  ...mainCategories,
  ProductCategory(
    id: 'agriculture',
    name: 'الزراعة',
    icon: Icons.agriculture,
    imageUrl: 'https://images.unsplash.com/photo-1625246333195-78d9c38ad449?w=300',
    description: 'معدات زراعية، بذور، أسمدة',
    productCount: 180,
    color: Colors.lightGreen,
  ),
  ProductCategory(
    id: 'jewelry',
    name: 'المجوهرات',
    icon: Icons.diamond,
    imageUrl: 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=300',
    description: 'ذهب، فضة، أحجار كريمة',
    productCount: 220,
    color: Colors.yellow.shade700,
  ),
  ProductCategory(
    id: 'watches',
    name: 'الساعات',
    icon: Icons.watch,
    imageUrl: 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=300',
    description: 'ساعات فاخرة، رقمية',
    productCount: 340,
    color: Colors.grey.shade700,
  ),
  ProductCategory(
    id: 'baby',
    name: 'مستلزمات الأطفال',
    icon: Icons.baby_changing_station,
    imageUrl: 'https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?w=300',
    description: 'ألعاب، ملابس أطفال',
    productCount: 410,
    color: Colors.lightBlue,
  ),
  ProductCategory(
    id: 'pets',
    name: 'حيوانات أليفة',
    icon: Icons.pets,
    imageUrl: 'https://images.unsplash.com/photo-1450778869180-41d0601e046e?w=300',
    description: 'طعام، مستلزمات حيوانات',
    productCount: 150,
    color: Colors.deepOrange,
  ),
  ProductCategory(
    id: 'grocery',
    name: 'مواد غذائية',
    icon: Icons.shopping_basket,
    imageUrl: 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=300',
    description: 'تمور، أرز، زيت، مواد غذائية',
    productCount: 670,
    color: Colors.green.shade600,
  ),
  ProductCategory(
    id: 'coffee',
    name: 'قهوة وشاي',
    icon: Icons.coffee,
    imageUrl: 'https://images.unsplash.com/photo-1442512595331-e89e73853f31?w=300',
    description: 'بن، مكائن قهوة، شاي',
    productCount: 280,
    color: Colors.brown.shade700,
  ),
  ProductCategory(
    id: 'honey',
    name: 'عسل وتمور',
    icon: Icons.food_bank,
    imageUrl: 'https://images.unsplash.com/photo-1587049352847-4a222e784d33?w=300',
    description: 'عسل طبيعي، تمور يمنية',
    productCount: 190,
    color: Colors.amber.shade700,
  ),
  ProductCategory(
    id: 'incense',
    name: 'بخور وعود',
    icon: Icons.local_fire_department,
    imageUrl: 'https://images.unsplash.com/photo-1583422409519-37f2e1de7ec9?w=300',
    description: 'عود، بخور، مباخر',
    productCount: 120,
    color: Colors.deepPurple,
  ),
  ProductCategory(
    id: 'carpets',
    name: 'سجاد ومفروشات',
    icon: Icons.grid_on,
    imageUrl: 'https://images.unsplash.com/photo-1581539250439-c96689b516dd?w=300',
    description: 'سجاد، موكيت، مفروشات',
    productCount: 230,
    color: Colors.red.shade400,
  ),
];
