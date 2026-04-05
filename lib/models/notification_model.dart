// lib/models/notification_model.dart

import 'package:flutter/material.dart';

/// أنواع الإشعارات
enum NotificationType {
  system,       // نظام
  transaction,  // معاملة مالية
  order,        // طلب
  promotion,    // عرض ترويجي
  message,      // رسالة
  alert,        // تنبيه
  reminder,     // تذكير
  reward,       // مكافأة
}

/// أولوية الإشعار
enum NotificationPriority {
  low,      // منخفضة
  medium,   // متوسطة
  high,     // عالية
  urgent,   // عاجلة
}

/// نموذج الإشعار
class NotificationModel {
  final String id;
  final String userId;
  final String title;
  final String body;
  final NotificationType type;
  final NotificationPriority priority;
  final bool isRead;
  final DateTime createdAt;
  final DateTime? readAt;
  final String? imageUrl;
  final String? actionUrl;
  final Map<String, dynamic>? data;
  final String? relatedId;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.type,
    this.priority = NotificationPriority.medium,
    this.isRead = false,
    required this.createdAt,
    this.readAt,
    this.imageUrl,
    this.actionUrl,
    this.data,
    this.relatedId,
  });

  /// أيقونة نوع الإشعار
  IconData get typeIcon {
    switch (type) {
      case NotificationType.system:
        return Icons.settings;
      case NotificationType.transaction:
        return Icons.account_balance_wallet;
      case NotificationType.order:
        return Icons.shopping_bag;
      case NotificationType.promotion:
        return Icons.local_offer;
      case NotificationType.message:
        return Icons.message;
      case NotificationType.alert:
        return Icons.warning;
      case NotificationType.reminder:
        return Icons.alarm;
      case NotificationType.reward:
        return Icons.card_giftcard;
    }
  }

  /// لون أولوية الإشعار
  Color get priorityColor {
    switch (priority) {
      case NotificationPriority.low:
        return Colors.grey;
      case NotificationPriority.medium:
        return Colors.blue;
      case NotificationPriority.high:
        return Colors.orange;
      case NotificationPriority.urgent:
        return Colors.red;
    }
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      type: NotificationType.values.firstWhere(
        (e) => e.toString() == 'NotificationType.${json['type']}',
        orElse: () => NotificationType.system,
      ),
      priority: NotificationPriority.values.firstWhere(
        (e) => e.toString() == 'NotificationPriority.${json['priority']}',
        orElse: () => NotificationPriority.medium,
      ),
      isRead: json['isRead'] ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      readAt: json['readAt'] != null
          ? DateTime.parse(json['readAt'])
          : null,
      imageUrl: json['imageUrl'],
      actionUrl: json['actionUrl'],
      data: json['data'],
      relatedId: json['relatedId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
      'type': type.toString().split('.').last,
      'priority': priority.toString().split('.').last,
      'isRead': isRead,
      'createdAt': createdAt.toIso8601String(),
      'readAt': readAt?.toIso8601String(),
      'imageUrl': imageUrl,
      'actionUrl': actionUrl,
      'data': data,
      'relatedId': relatedId,
    };
  }

  NotificationModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? body,
    NotificationType? type,
    NotificationPriority? priority,
    bool? isRead,
    DateTime? createdAt,
    DateTime? readAt,
    String? imageUrl,
    String? actionUrl,
    Map<String, dynamic>? data,
    String? relatedId,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
      type: type ?? this.type,
      priority: priority ?? this.priority,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      readAt: readAt ?? this.readAt,
      imageUrl: imageUrl ?? this.imageUrl,
      actionUrl: actionUrl ?? this.actionUrl,
      data: data ?? this.data,
      relatedId: relatedId ?? this.relatedId,
    );
  }
}

/// إعدادات الإشعارات
class NotificationSettings {
  final bool enabled;
  final bool transactions;
  final bool promotions;
  final bool orders;
  final bool messages;
  final bool alerts;
  final bool reminders;
  final bool rewards;
  final bool sound;
  final bool vibration;
  final bool showPreview;

  NotificationSettings({
    this.enabled = true,
    this.transactions = true,
    this.promotions = true,
    this.orders = true,
    this.messages = true,
    this.alerts = true,
    this.reminders = true,
    this.rewards = true,
    this.sound = true,
    this.vibration = true,
    this.showPreview = true,
  });

  factory NotificationSettings.fromJson(Map<String, dynamic> json) {
    return NotificationSettings(
      enabled: json['enabled'] ?? true,
      transactions: json['transactions'] ?? true,
      promotions: json['promotions'] ?? true,
      orders: json['orders'] ?? true,
      messages: json['messages'] ?? true,
      alerts: json['alerts'] ?? true,
      reminders: json['reminders'] ?? true,
      rewards: json['rewards'] ?? true,
      sound: json['sound'] ?? true,
      vibration: json['vibration'] ?? true,
      showPreview: json['showPreview'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'enabled': enabled,
      'transactions': transactions,
      'promotions': promotions,
      'orders': orders,
      'messages': messages,
      'alerts': alerts,
      'reminders': reminders,
      'rewards': rewards,
      'sound': sound,
      'vibration': vibration,
      'showPreview': showPreview,
    };
  }

  NotificationSettings copyWith({
    bool? enabled,
    bool? transactions,
    bool? promotions,
    bool? orders,
    bool? messages,
    bool? alerts,
    bool? reminders,
    bool? rewards,
    bool? sound,
    bool? vibration,
    bool? showPreview,
  }) {
    return NotificationSettings(
      enabled: enabled ?? this.enabled,
      transactions: transactions ?? this.transactions,
      promotions: promotions ?? this.promotions,
      orders: orders ?? this.orders,
      messages: messages ?? this.messages,
      alerts: alerts ?? this.alerts,
      reminders: reminders ?? this.reminders,
      rewards: rewards ?? this.rewards,
      sound: sound ?? this.sound,
      vibration: vibration ?? this.vibration,
      showPreview: showPreview ?? this.showPreview,
    );
  }
}
