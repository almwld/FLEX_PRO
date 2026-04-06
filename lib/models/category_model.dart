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
