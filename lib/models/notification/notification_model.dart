import 'package:flutter/material.dart';

enum NotificationType {
  transaction,
  order,
  promo,
  system,
  update,
  message,
  alert,
  achievement,
}

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final NotificationType type;
  final DateTime createdAt;
  bool isRead;
  final String? imageUrl;
  final String? actionUrl;
  final Map<String, dynamic>? data;
  final String? senderId;
  final String? senderName;
  final String? senderAvatar;
  
  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.createdAt,
    this.isRead = false,
    this.imageUrl,
    this.actionUrl,
    this.data,
    this.senderId,
    this.senderName,
    this.senderAvatar,
  });
  
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      type: NotificationType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => NotificationType.system,
      ),
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      isRead: json['is_read'] ?? false,
      imageUrl: json['image_url'],
      actionUrl: json['action_url'],
      data: json['data'],
      senderId: json['sender_id'],
      senderName: json['sender_name'],
      senderAvatar: json['sender_avatar'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'type': type.name,
      'created_at': createdAt.toIso8601String(),
      'is_read': isRead,
      'image_url': imageUrl,
      'action_url': actionUrl,
      'data': data,
      'sender_id': senderId,
      'sender_name': senderName,
      'sender_avatar': senderAvatar,
    };
  }
  
  // لون الإشعار
  Color get color {
    switch (type) {
      case NotificationType.transaction:
        return const Color(0xFFD4AF37);
      case NotificationType.order:
        return const Color(0xFF2196F3);
      case NotificationType.promo:
        return const Color(0xFFE91E63);
      case NotificationType.system:
        return const Color(0xFF9E9E9E);
      case NotificationType.update:
        return const Color(0xFF4CAF50);
      case NotificationType.message:
        return const Color(0xFF00BCD4);
      case NotificationType.alert:
        return const Color(0xFFE5493A);
      case NotificationType.achievement:
        return const Color(0xFFFF9800);
    }
  }
  
  // أيقونة الإشعار
  IconData get icon {
    switch (type) {
      case NotificationType.transaction:
        Icons.account_balance_wallet;
        return Icons.account_balance_wallet;
      case NotificationType.order:
        return Icons.shopping_bag;
      case NotificationType.promo:
        return Icons.local_offer;
      case NotificationType.system:
        return Icons.info;
      case NotificationType.update:
        return Icons.system_update;
      case NotificationType.message:
        return Icons.message;
      case NotificationType.alert:
        return Icons.warning;
      case NotificationType.achievement:
        return Icons.emoji_events;
    }
  }
  
  // نص نوع الإشعار
  String get typeText {
    switch (type) {
      case NotificationType.transaction:
        return 'معاملة';
      case NotificationType.order:
        return 'طلب';
      case NotificationType.promo:
        return 'عرض';
      case NotificationType.system:
        return 'نظام';
      case NotificationType.update:
        return 'تحديث';
      case NotificationType.message:
        return 'رسالة';
      case NotificationType.alert:
        return 'تنبيه';
      case NotificationType.achievement:
        return 'إنجاز';
    }
  }
  
  // تاريخ منسق
  String get formattedTime {
    final now = DateTime.now();
    final diff = now.difference(createdAt);
    
    if (diff.inDays == 0) {
      if (diff.inHours == 0) {
        if (diff.inMinutes == 0) {
          return 'الآن';
        }
        return 'منذ ${diff.inMinutes} دقيقة';
      }
      return 'منذ ${diff.inHours} ساعة';
    } else if (diff.inDays == 1) {
      return 'أمس';
    } else if (diff.inDays < 7) {
      return 'منذ ${diff.inDays} أيام';
    } else {
      return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
    }
  }
  
  NotificationModel copyWith({
    String? id,
    String? title,
    String? message,
    NotificationType? type,
    DateTime? createdAt,
    bool? isRead,
    String? imageUrl,
    String? actionUrl,
    Map<String, dynamic>? data,
    String? senderId,
    String? senderName,
    String? senderAvatar,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
      imageUrl: imageUrl ?? this.imageUrl,
      actionUrl: actionUrl ?? this.actionUrl,
      data: data ?? this.data,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      senderAvatar: senderAvatar ?? this.senderAvatar,
    );
  }
}

// إشعارات افتراضية
final List<NotificationModel> sampleNotifications = [
  NotificationModel(
    id: '1',
    title: 'تم إتمام المعاملة',
    message: 'تم بنجاح تحويل 50,000 ر.ي إلى أحمد محمد',
    type: NotificationType.transaction,
    createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
    isRead: false,
  ),
  NotificationModel(
    id: '2',
    title: 'طلب جديد',
    message: 'تم استلام طلبك رقم #ORD-002',
    type: NotificationType.order,
    createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    isRead: false,
  ),
  NotificationModel(
    id: '3',
    title: 'عرض خاص!',
    message: 'خصم 20% على جميع المنتجات الإلكترونية',
    type: NotificationType.promo,
    createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    isRead: true,
  ),
  NotificationModel(
    id: '4',
    title: 'تحديث التطبيق',
    message: 'تحديث جديد متاح: إصدار 2.1.0',
    type: NotificationType.update,
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    isRead: true,
  ),
  NotificationModel(
    id: '5',
    title: 'رسالة جديدة',
    message: 'لديك رسالة جديدة من متجر التقنية',
    type: NotificationType.message,
    createdAt: DateTime.now().subtract(const Duration(hours: 3)),
    isRead: false,
    senderName: 'متجر التقنية',
    senderAvatar: 'https://i.pravatar.cc/150?img=1',
  ),
  NotificationModel(
    id: '6',
    title: 'إنجاز جديد!',
    message: 'تهانينا! لقد حصلت على شارة المشتري المميز',
    type: NotificationType.achievement,
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    isRead: true,
  ),
  NotificationModel(
    id: '7',
    title: 'تنبيه أمني',
    message: 'تم تسجيل دخول من جهاز جديد',
    type: NotificationType.alert,
    createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    isRead: false,
  ),
];
