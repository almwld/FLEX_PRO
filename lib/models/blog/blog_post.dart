class BlogPost {
  final String id;
  final String title;
  final String content;
  final String? excerpt;
  final String? featuredImage;
  final List<String>? images;
  final String authorId;
  final String authorName;
  final String? authorAvatar;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final List<String> categories;
  final List<String>? tags;
  final int viewCount;
  final int likeCount;
  final int commentCount;
  final bool isPublished;
  final bool isFeatured;
  final String? metaTitle;
  final String? metaDescription;
  
  BlogPost({
    required this.id,
    required this.title,
    required this.content,
    this.excerpt,
    this.featuredImage,
    this.images,
    required this.authorId,
    required this.authorName,
    this.authorAvatar,
    required this.createdAt,
    this.updatedAt,
    required this.categories,
    this.tags,
    this.viewCount = 0,
    this.likeCount = 0,
    this.commentCount = 0,
    this.isPublished = true,
    this.isFeatured = false,
    this.metaTitle,
    this.metaDescription,
  });
  
  factory BlogPost.fromJson(Map<String, dynamic> json) {
    return BlogPost(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      excerpt: json['excerpt'],
      featuredImage: json['featured_image'],
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      authorId: json['author_id'] ?? '',
      authorName: json['author_name'] ?? '',
      authorAvatar: json['author_avatar'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      categories: List<String>.from(json['categories'] ?? []),
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
      viewCount: json['view_count'] ?? 0,
      likeCount: json['like_count'] ?? 0,
      commentCount: json['comment_count'] ?? 0,
      isPublished: json['is_published'] ?? true,
      isFeatured: json['is_featured'] ?? false,
      metaTitle: json['meta_title'],
      metaDescription: json['meta_description'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'excerpt': excerpt,
      'featured_image': featuredImage,
      'images': images,
      'author_id': authorId,
      'author_name': authorName,
      'author_avatar': authorAvatar,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'categories': categories,
      'tags': tags,
      'view_count': viewCount,
      'like_count': likeCount,
      'comment_count': commentCount,
      'is_published': isPublished,
      'is_featured': isFeatured,
      'meta_title': metaTitle,
      'meta_description': metaDescription,
    };
  }
  
  // ملخص المقال
  String get summary {
    if (excerpt != null && excerpt!.isNotEmpty) {
      return excerpt!;
    }
    if (content.length > 150) {
      return '${content.substring(0, 150)}...';
    }
    return content;
  }
  
  // تاريخ منسق
  String get formattedDate {
    return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
  }
  
  // وقت القراءة التقديري
  String get readingTime {
    final wordCount = content.split(' ').length;
    final minutes = (wordCount / 200).ceil();
    return '$minutes دقيقة قراءة';
  }
  
  BlogPost copyWith({
    String? id,
    String? title,
    String? content,
    String? excerpt,
    String? featuredImage,
    List<String>? images,
    String? authorId,
    String? authorName,
    String? authorAvatar,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? categories,
    List<String>? tags,
    int? viewCount,
    int? likeCount,
    int? commentCount,
    bool? isPublished,
    bool? isFeatured,
    String? metaTitle,
    String? metaDescription,
  }) {
    return BlogPost(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      excerpt: excerpt ?? this.excerpt,
      featuredImage: featuredImage ?? this.featuredImage,
      images: images ?? this.images,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      authorAvatar: authorAvatar ?? this.authorAvatar,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      categories: categories ?? this.categories,
      tags: tags ?? this.tags,
      viewCount: viewCount ?? this.viewCount,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      isPublished: isPublished ?? this.isPublished,
      isFeatured: isFeatured ?? this.isFeatured,
      metaTitle: metaTitle ?? this.metaTitle,
      metaDescription: metaDescription ?? this.metaDescription,
    );
  }
}

// مقالات افتراضية
final List<BlogPost> sampleBlogPosts = [
  BlogPost(
    id: '1',
    title: 'كيف تبدأ تجارتك الإلكترونية في اليمن',
    content: '''
التجارة الإلكترونية في اليمن تشهد نمواً ملحوظاً في السنوات الأخيرة. مع تطور التكنولوجيا وزيادة انتشار الإنترنت، أصبح من الأسهل than ever بدء مشروع تجاري عبر الإنترنت.

في هذا المقال، سنتناول الخطوات الأساسية لبدء تجارتك الإلكترونية بنجاح:

## 1. اختيار المنتج المناسب
اختر منتجاً تفهمه جيداً ويكون هناك طلب عليه في السوق. قم بإجراء دراسة سوق شاملة لفهم احتياجات العملاء.

## 2. إنشاء متجر إلكتروني
يمكنك استخدام منصة فلكس يمن لإنشاء متجرك الإلكتروني بسهولة. المنصة توفر جميع الأدوات اللازمة لإدارة منتجاتك وطلباتك.

## 3. التسويق الرقمي
استخدم وسائل التواصل الاجتماعي والإعلانات المدفوعة للوصول إلى عملائك المستهدفين.

## 4. خدمة العملاء
قدم خدمة عملاء ممتازة لبناء علاقات طويلة الأمد مع عملائك.

## 5. التحليل والتحسين
راقب أداء متجرك باستمرار وقم بإجراء التحسينات اللازمة لزيادة المبيعات.
    ''',
    excerpt: 'دليل شامل لبدء تجارتك الإلكترونية في اليمن مع نصائح عملية وخطوات واضحة',
    featuredImage: 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=600',
    authorId: '1',
    authorName: 'فريق فلكس يمن',
    authorAvatar: 'https://i.pravatar.cc/150?img=8',
    createdAt: DateTime.now().subtract(const Duration(days: 5)),
    categories: ['تجارة إلكترونية', 'ريادة أعمال'],
    tags: ['تجارة', 'إلكترونية', 'يمن', 'أعمال'],
    viewCount: 1250,
    likeCount: 89,
    commentCount: 23,
    isFeatured: true,
  ),
  BlogPost(
    id: '2',
    title: 'أفضل طرق الدفع الإلكتروني في اليمن',
    content: '''
مع تطور التكنولوجيا المالية، أصبحت طرق الدفع الإلكتروني أكثر انتشاراً في اليمن. في هذا المقال، نستعرض أفضل الخيارات المتاحة:

## المحافظ الإلكترونية
- فلكس باي
- جيب
- كاش
- يمن موبايل

## البطاقات البنكية
- فيزا
- ماستركارد

## التحويلات البنكية
- التحويل المحلي
- التحويل الدولي
    ''',
    excerpt: 'تعرف على أفضل طرق الدفع الإلكتروني المتاحة في اليمن ومميزات كل منها',
    featuredImage: 'https://images.unsplash.com/photo-1563013544-824ae1b704d3?w=600',
    authorId: '2',
    authorName: 'أحمد محمد',
    authorAvatar: 'https://i.pravatar.cc/150?img=11',
    createdAt: DateTime.now().subtract(const Duration(days: 3)),
    categories: ['تقنية مالية', 'دفع إلكتروني'],
    tags: ['دفع', 'إلكتروني', 'محفظة', 'بنك'],
    viewCount: 980,
    likeCount: 67,
    commentCount: 15,
    isFeatured: true,
  ),
  BlogPost(
    id: '3',
    title: 'دليلك الشامل للتسوق الآمن عبر الإنترنت',
    content: '''
التسوق عبر الإنترنت مليء بالفرص والمخاطر في آن واحد. إليك أهم النصائح للتسوق الآمن:

## التحقق من البائع
- اقرأ تقييمات البائع
- تحقق من سمعته
- راجع تاريخه في المنصة

## حماية بياناتك
- استخدم كلمات مرور قوية
- فعل التحقق بخطوتين
- لا تشارك معلوماتك مع أحد

## الدفع الآمن
- استخدم طرق دفع موثوقة
- تجنب التحويلات المباشرة
- احتفظ بسجل المعاملات
    ''',
    excerpt: 'نصائح هامة للتسوق الآمن عبر الإنترنت وحماية بياناتك الشخصية',
    featuredImage: 'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=600',
    authorId: '1',
    authorName: 'فريق فلكس يمن',
    authorAvatar: 'https://i.pravatar.cc/150?img=8',
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    categories: ['أمان', 'تسوق'],
    tags: ['أمان', 'تسوق', 'حماية', 'إنترنت'],
    viewCount: 750,
    likeCount: 45,
    commentCount: 12,
  ),
  BlogPost(
    id: '4',
    title: 'أحدث اتجاهات التجارة الإلكترونية 2026',
    content: '''
عالم التجارة الإلكترونية يتطور باستمرار. إليك أهم الاتجاهات لهذا العام:

## الذكاء الاصطناعي
- chatbots للخدمة العملاء
- التوصيات الشخصية
- تحليل البيانات

## الواقع المعزز
- تجربة المنتجات افتراضياً
- جولات افتراضية في المتاجر

## التجارة الصوتية
- الطلب عبر المساعدين الصوتيين
- البحث الصوتي

## الاستدامة
- المنتجات الصديقة للبيئة
- التغليف المستدام
    ''',
    excerpt: 'تعرف على أحدث اتجاهات التجارة الإلكترونية لعام 2026 وكيفية الاستفادة منها',
    featuredImage: 'https://images.unsplash.com/photo-1553877522-43269d4ea984?w=600',
    authorId: '3',
    authorName: 'سارة أحمد',
    authorAvatar: 'https://i.pravatar.cc/150?img=5',
    createdAt: DateTime.now(),
    categories: ['تقنية', 'تجارة إلكترونية'],
    tags: ['اتجاهات', '2026', 'تقنية', 'تجارة'],
    viewCount: 520,
    likeCount: 34,
    commentCount: 8,
    isFeatured: true,
  ),
];
