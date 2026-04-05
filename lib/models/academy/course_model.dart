import 'package:flutter/material.dart';

enum CourseLevel { beginner, intermediate, advanced, expert }

enum CourseStatus { draft, published, archived }

class CourseModel {
  final String id;
  final String title;
  final String description;
  final String? thumbnail;
  final String? previewVideo;
  final String instructorId;
  final String instructorName;
  final String? instructorAvatar;
  final String? instructorBio;
  final CourseLevel level;
  final CourseStatus status;
  final double price;
  final double? originalPrice;
  final bool isFree;
  final int duration; // بالدقائق
  final int lessonCount;
  final int studentCount;
  final double? rating;
  final int? reviewCount;
  final List<String> categories;
  final List<String>? tags;
  final List<CourseLesson>? lessons;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? publishedAt;
  final bool isFeatured;
  final String? certificateTemplate;
  final List<String>? requirements;
  final List<String>? outcomes;
  
  CourseModel({
    required this.id,
    required this.title,
    required this.description,
    this.thumbnail,
    this.previewVideo,
    required this.instructorId,
    required this.instructorName,
    this.instructorAvatar,
    this.instructorBio,
    required this.level,
    this.status = CourseStatus.draft,
    required this.price,
    this.originalPrice,
    this.isFree = false,
    required this.duration,
    required this.lessonCount,
    this.studentCount = 0,
    this.rating,
    this.reviewCount,
    required this.categories,
    this.tags,
    this.lessons,
    required this.createdAt,
    this.updatedAt,
    this.publishedAt,
    this.isFeatured = false,
    this.certificateTemplate,
    this.requirements,
    this.outcomes,
  });
  
  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      thumbnail: json['thumbnail'],
      previewVideo: json['preview_video'],
      instructorId: json['instructor_id'] ?? '',
      instructorName: json['instructor_name'] ?? '',
      instructorAvatar: json['instructor_avatar'],
      instructorBio: json['instructor_bio'],
      level: CourseLevel.values.firstWhere(
        (e) => e.name == json['level'],
        orElse: () => CourseLevel.beginner,
      ),
      status: CourseStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => CourseStatus.draft,
      ),
      price: (json['price'] ?? 0).toDouble(),
      originalPrice: json['original_price']?.toDouble(),
      isFree: json['is_free'] ?? false,
      duration: json['duration'] ?? 0,
      lessonCount: json['lesson_count'] ?? 0,
      studentCount: json['student_count'] ?? 0,
      rating: json['rating']?.toDouble(),
      reviewCount: json['review_count'],
      categories: List<String>.from(json['categories'] ?? []),
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
      lessons: json['lessons'] != null 
          ? (json['lessons'] as List).map((l) => CourseLesson.fromJson(l)).toList()
          : null,
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      publishedAt: json['published_at'] != null ? DateTime.parse(json['published_at']) : null,
      isFeatured: json['is_featured'] ?? false,
      certificateTemplate: json['certificate_template'],
      requirements: json['requirements'] != null ? List<String>.from(json['requirements']) : null,
      outcomes: json['outcomes'] != null ? List<String>.from(json['outcomes']) : null,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'thumbnail': thumbnail,
      'preview_video': previewVideo,
      'instructor_id': instructorId,
      'instructor_name': instructorName,
      'instructor_avatar': instructorAvatar,
      'instructor_bio': instructorBio,
      'level': level.name,
      'status': status.name,
      'price': price,
      'original_price': originalPrice,
      'is_free': isFree,
      'duration': duration,
      'lesson_count': lessonCount,
      'student_count': studentCount,
      'rating': rating,
      'review_count': reviewCount,
      'categories': categories,
      'tags': tags,
      'lessons': lessons?.map((l) => l.toJson()).toList(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'published_at': publishedAt?.toIso8601String(),
      'is_featured': isFeatured,
      'certificate_template': certificateTemplate,
      'requirements': requirements,
      'outcomes': outcomes,
    };
  }
  
  // نص المستوى
  String get levelText {
    switch (level) {
      case CourseLevel.beginner:
        return 'مبتدئ';
      case CourseLevel.intermediate:
        return 'متوسط';
      case CourseLevel.advanced:
        return 'متقدم';
      case CourseLevel.expert:
        return 'خبير';
    }
  }
  
  // لون المستوى
  Color get levelColor {
    switch (level) {
      case CourseLevel.beginner:
        return Colors.green;
      case CourseLevel.intermediate:
        return Colors.blue;
      case CourseLevel.advanced:
        return Colors.orange;
      case CourseLevel.expert:
        return Colors.purple;
    }
  }
  
  // نسبة الخصم
  int? get discountPercentage {
    if (originalPrice == null || originalPrice == 0 || isFree) return null;
    return (((originalPrice! - price) / originalPrice!) * 100).round();
  }
  
  // السعر النهائي
  double get finalPrice => isFree ? 0 : price;
  
  // تنسيق المدة
  String get formattedDuration {
    final hours = duration ~/ 60;
    final minutes = duration % 60;
    if (hours > 0) {
      return '$hours ساعة ${minutes > 0 ? '$minutes دقيقة' : ''}';
    }
    return '$minutes دقيقة';
  }
  
  // تاريخ النشر
  String get formattedDate {
    return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
  }
  
  CourseModel copyWith({
    String? id,
    String? title,
    String? description,
    String? thumbnail,
    String? previewVideo,
    String? instructorId,
    String? instructorName,
    String? instructorAvatar,
    String? instructorBio,
    CourseLevel? level,
    CourseStatus? status,
    double? price,
    double? originalPrice,
    bool? isFree,
    int? duration,
    int? lessonCount,
    int? studentCount,
    double? rating,
    int? reviewCount,
    List<String>? categories,
    List<String>? tags,
    List<CourseLesson>? lessons,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? publishedAt,
    bool? isFeatured,
    String? certificateTemplate,
    List<String>? requirements,
    List<String>? outcomes,
  }) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      thumbnail: thumbnail ?? this.thumbnail,
      previewVideo: previewVideo ?? this.previewVideo,
      instructorId: instructorId ?? this.instructorId,
      instructorName: instructorName ?? this.instructorName,
      instructorAvatar: instructorAvatar ?? this.instructorAvatar,
      instructorBio: instructorBio ?? this.instructorBio,
      level: level ?? this.level,
      status: status ?? this.status,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      isFree: isFree ?? this.isFree,
      duration: duration ?? this.duration,
      lessonCount: lessonCount ?? this.lessonCount,
      studentCount: studentCount ?? this.studentCount,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      categories: categories ?? this.categories,
      tags: tags ?? this.tags,
      lessons: lessons ?? this.lessons,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      publishedAt: publishedAt ?? this.publishedAt,
      isFeatured: isFeatured ?? this.isFeatured,
      certificateTemplate: certificateTemplate ?? this.certificateTemplate,
      requirements: requirements ?? this.requirements,
      outcomes: outcomes ?? this.outcomes,
    );
  }
}

class CourseLesson {
  final String id;
  final String title;
  final String? description;
  final String? videoUrl;
  final int duration; // بالدقائق
  final int order;
  final bool isFree;
  final bool isPublished;
  final List<String>? resources;
  final String? quizId;
  
  CourseLesson({
    required this.id,
    required this.title,
    this.description,
    this.videoUrl,
    required this.duration,
    required this.order,
    this.isFree = false,
    this.isPublished = true,
    this.resources,
    this.quizId,
  });
  
  factory CourseLesson.fromJson(Map<String, dynamic> json) {
    return CourseLesson(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'],
      videoUrl: json['video_url'],
      duration: json['duration'] ?? 0,
      order: json['order'] ?? 0,
      isFree: json['is_free'] ?? false,
      isPublished: json['is_published'] ?? true,
      resources: json['resources'] != null ? List<String>.from(json['resources']) : null,
      quizId: json['quiz_id'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'video_url': videoUrl,
      'duration': duration,
      'order': order,
      'is_free': isFree,
      'is_published': isPublished,
      'resources': resources,
      'quiz_id': quizId,
    };
  }
  
  String get formattedDuration {
    final hours = duration ~/ 60;
    final minutes = duration % 60;
    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}';
    }
    return '$minutes دقيقة';
  }
}

// دورات افتراضية
final List<CourseModel> sampleCourses = [
  CourseModel(
    id: '1',
    title: 'أساسيات التجارة الإلكترونية',
    description: 'تعلم أساسيات التجارة الإلكترونية وكيفية بدء متجرك الإلكتروني من الصفر',
    thumbnail: 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=600',
    instructorId: '1',
    instructorName: 'محمد علي',
    instructorAvatar: 'https://i.pravatar.cc/150?img=12',
    instructorBio: 'خبير في التجارة الإلكترونية مع أكثر من 10 سنوات خبرة',
    level: CourseLevel.beginner,
    status: CourseStatus.published,
    price: 0,
    isFree: true,
    duration: 180,
    lessonCount: 12,
    studentCount: 1250,
    rating: 4.8,
    reviewCount: 89,
    categories: ['تجارة إلكترونية', 'ريادة أعمال'],
    createdAt: DateTime.now().subtract(const Duration(days: 30)),
    publishedAt: DateTime.now().subtract(const Duration(days: 25)),
    isFeatured: true,
    outcomes: [
      'فهم أساسيات التجارة الإلكترونية',
      'إنشاء متجر إلكتروني ناجح',
      'التسويق الرقمي',
      'إدارة الطلبات والشحن',
    ],
  ),
  CourseModel(
    id: '2',
    title: 'التسويق الرقمي المتقدم',
    description: 'استراتيجيات متقدمة في التسويق الرقمي لزيادة المبيعات',
    thumbnail: 'https://images.unsplash.com/photo-1533750349088-cd871a92f312?w=600',
    instructorId: '2',
    instructorName: 'سارة أحمد',
    instructorAvatar: 'https://i.pravatar.cc/150?img=5',
    instructorBio: 'متخصصة في التسويق الرقمي وإدارة الحملات الإعلانية',
    level: CourseLevel.intermediate,
    status: CourseStatus.published,
    price: 25000,
    originalPrice: 35000,
    duration: 240,
    lessonCount: 18,
    studentCount: 850,
    rating: 4.9,
    reviewCount: 67,
    categories: ['تسويق', 'تسويق رقمي'],
    createdAt: DateTime.now().subtract(const Duration(days: 45)),
    publishedAt: DateTime.now().subtract(const Duration(days: 40)),
    isFeatured: true,
    outcomes: [
      'إنشاء حملات إعلانية ناجحة',
      'تحليل البيانات والمقاييس',
      'تحسين معدلات التحويل',
      'إدارة الميزانية الإعلانية',
    ],
  ),
  CourseModel(
    id: '3',
    title: 'إدارة المحافظ الإلكترونية',
    description: 'تعلم كيفية إدارة محفظتك الإلكترونية بأمان واحترافية',
    thumbnail: 'https://images.unsplash.com/photo-1563013544-824ae1b704d3?w=600',
    instructorId: '3',
    instructorName: 'خالد محمود',
    instructorAvatar: 'https://i.pravatar.cc/150?img=3',
    instructorBio: 'خبير في التقنية المالية والأمن السيبراني',
    level: CourseLevel.beginner,
    status: CourseStatus.published,
    price: 0,
    isFree: true,
    duration: 120,
    lessonCount: 8,
    studentCount: 2100,
    rating: 4.7,
    reviewCount: 156,
    categories: ['تقنية مالية', 'أمان'],
    createdAt: DateTime.now().subtract(const Duration(days: 60)),
    publishedAt: DateTime.now().subtract(const Duration(days: 55)),
    outcomes: [
      'فهم آلية عمل المحافظ الإلكترونية',
      'حماية حسابك من الاختراق',
      'إجراء المعاملات بأمان',
      'استرجاع الحساب المفقود',
    ],
  ),
  CourseModel(
    id: '4',
    title: 'تطوير تطبيقات Flutter',
    description: 'بناء تطبيقات جوال احترافية باستخدام Flutter',
    thumbnail: 'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?w=600',
    instructorId: '4',
    instructorName: 'أحمد حسن',
    instructorAvatar: 'https://i.pravatar.cc/150?img=11',
    instructorBio: 'مطور تطبيقات محترف مع خبرة في Flutter و Dart',
    level: CourseLevel.advanced,
    status: CourseStatus.published,
    price: 45000,
    originalPrice: 60000,
    duration: 480,
    lessonCount: 36,
    studentCount: 420,
    rating: 4.9,
    reviewCount: 45,
    categories: ['برمجة', 'تطوير تطبيقات'],
    createdAt: DateTime.now().subtract(const Duration(days: 20)),
    publishedAt: DateTime.now().subtract(const Duration(days: 15)),
    isFeatured: true,
    requirements: [
      'معرفة أساسية بالبرمجة',
      'فهم مفاهيم البرمجة كائنية التوجه',
    ],
    outcomes: [
      'بناء تطبيقات كاملة باستخدام Flutter',
      'العمل مع APIs وقواعد البيانات',
      'نشر التطبيق على المتاجر',
      'إدارة حالة التطبيق',
    ],
  ),
  CourseModel(
    id: '5',
    title: 'التصوير الفوتوغرافي للمنتجات',
    description: 'تعلم أسرار التصوير الاحترافي للمنتجات',
    thumbnail: 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=600',
    instructorId: '5',
    instructorName: 'ليلى عبدالله',
    instructorAvatar: 'https://i.pravatar.cc/150?img=9',
    instructorBio: 'مصورة منتجات محترفة تعمل مع علامات تجارية عالمية',
    level: CourseLevel.intermediate,
    status: CourseStatus.published,
    price: 18000,
    duration: 150,
    lessonCount: 10,
    studentCount: 680,
    rating: 4.8,
    reviewCount: 52,
    categories: ['تصوير', 'تصميم'],
    createdAt: DateTime.now().subtract(const Duration(days: 35)),
    publishedAt: DateTime.now().subtract(const Duration(days: 30)),
    outcomes: [
      'التقاط صور احترافية للمنتجات',
      'استخدام الإضاءة بشكل صحيح',
      'تحرير الصور ببرامج احترافية',
      'إعداد استوديو تصوير',
    ],
  ),
  CourseModel(
    id: '6',
    title: 'تحليل البيانات للأعمال',
    description: 'استخدم البيانات لاتخاذ قرارات تجارية smarter',
    thumbnail: 'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=600',
    instructorId: '6',
    instructorName: 'عمر فاروق',
    instructorAvatar: 'https://i.pravatar.cc/150?img=13',
    instructorBio: 'محلل بيانات مع خبرة في Fortune 500 companies',
    level: CourseLevel.advanced,
    status: CourseStatus.published,
    price: 35000,
    originalPrice: 45000,
    duration: 300,
    lessonCount: 24,
    studentCount: 320,
    rating: 4.7,
    reviewCount: 28,
    categories: ['تحليل بيانات', 'أعمال'],
    createdAt: DateTime.now().subtract(const Duration(days: 50)),
    publishedAt: DateTime.now().subtract(const Duration(days: 45)),
    requirements: [
      'معرفة أساسية بالإحصاء',
      'خبرة في استخدام Excel',
    ],
    outcomes: [
      'تحليل البيانات باستخدام Python',
      'إنشاء لوحات معلومات تفاعلية',
      'استخراج رؤى قابلة للتنفيذ',
      'التنبؤ بالاتجاهات المستقبلية',
    ],
  ),
];
