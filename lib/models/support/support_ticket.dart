import 'package:flutter/material.dart';

enum TicketStatus { open, inProgress, waiting, resolved, closed }

enum TicketPriority { low, medium, high, urgent }

enum TicketCategory {
  general,
  technical,
  billing,
  account,
  security,
  featureRequest,
  bugReport,
  other,
}

class SupportTicket {
  final String id;
  final String userId;
  final String userName;
  final String? userAvatar;
  final String subject;
  final String description;
  final TicketCategory category;
  final TicketPriority priority;
  final TicketStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? resolvedAt;
  final String? assignedTo;
  final String? assignedToName;
  final List<TicketMessage>? messages;
  final List<String>? attachments;
  final String? relatedOrderId;
  final String? relatedTransactionId;
  final double? satisfactionRating;
  
  SupportTicket({
    required this.id,
    required this.userId,
    required this.userName,
    this.userAvatar,
    required this.subject,
    required this.description,
    required this.category,
    this.priority = TicketPriority.medium,
    this.status = TicketStatus.open,
    required this.createdAt,
    this.updatedAt,
    this.resolvedAt,
    this.assignedTo,
    this.assignedToName,
    this.messages,
    this.attachments,
    this.relatedOrderId,
    this.relatedTransactionId,
    this.satisfactionRating,
  });
  
  factory SupportTicket.fromJson(Map<String, dynamic> json) {
    return SupportTicket(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      userName: json['user_name'] ?? '',
      userAvatar: json['user_avatar'],
      subject: json['subject'] ?? '',
      description: json['description'] ?? '',
      category: TicketCategory.values.firstWhere(
        (e) => e.name == json['category'],
        orElse: () => TicketCategory.general,
      ),
      priority: TicketPriority.values.firstWhere(
        (e) => e.name == json['priority'],
        orElse: () => TicketPriority.medium,
      ),
      status: TicketStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => TicketStatus.open,
      ),
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      resolvedAt: json['resolved_at'] != null ? DateTime.parse(json['resolved_at']) : null,
      assignedTo: json['assigned_to'],
      assignedToName: json['assigned_to_name'],
      messages: json['messages'] != null 
          ? (json['messages'] as List).map((m) => TicketMessage.fromJson(m)).toList()
          : null,
      attachments: json['attachments'] != null ? List<String>.from(json['attachments']) : null,
      relatedOrderId: json['related_order_id'],
      relatedTransactionId: json['related_transaction_id'],
      satisfactionRating: json['satisfaction_rating']?.toDouble(),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'user_name': userName,
      'user_avatar': userAvatar,
      'subject': subject,
      'description': description,
      'category': category.name,
      'priority': priority.name,
      'status': status.name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'resolved_at': resolvedAt?.toIso8601String(),
      'assigned_to': assignedTo,
      'assigned_to_name': assignedToName,
      'messages': messages?.map((m) => m.toJson()).toList(),
      'attachments': attachments,
      'related_order_id': relatedOrderId,
      'related_transaction_id': relatedTransactionId,
      'satisfaction_rating': satisfactionRating,
    };
  }
  
  // نص الفئة
  String get categoryText {
    switch (category) {
      case TicketCategory.general:
        return 'استفسار عام';
      case TicketCategory.technical:
        return 'دعم فني';
      case TicketCategory.billing:
        return 'فواتير ومدفوعات';
      case TicketCategory.account:
        return 'الحساب';
      case TicketCategory.security:
        return 'الأمان';
      case TicketCategory.featureRequest:
        return 'طلب ميزة';
      case TicketCategory.bugReport:
        return 'إبلاغ عن خطأ';
      case TicketCategory.other:
        return 'أخرى';
    }
  }
  
  // أيقونة الفئة
  IconData get categoryIcon {
    switch (category) {
      case TicketCategory.general:
        return Icons.help_outline;
      case TicketCategory.technical:
        return Icons.build;
      case TicketCategory.billing:
        return Icons.payment;
      case TicketCategory.account:
        return Icons.person;
      case TicketCategory.security:
        return Icons.security;
      case TicketCategory.featureRequest:
        return Icons.lightbulb;
      case TicketCategory.bugReport:
        return Icons.bug_report;
      case TicketCategory.other:
        return Icons.more_horiz;
    }
  }
  
  // نص الأولوية
  String get priorityText {
    switch (priority) {
      case TicketPriority.low:
        return 'منخفضة';
      case TicketPriority.medium:
        return 'متوسطة';
      case TicketPriority.high:
        return 'عالية';
      case TicketPriority.urgent:
        return 'عاجلة';
    }
  }
  
  // لون الأولوية
  Color get priorityColor {
    switch (priority) {
      case TicketPriority.low:
        return Colors.grey;
      case TicketPriority.medium:
        return Colors.blue;
      case TicketPriority.high:
        return Colors.orange;
      case TicketPriority.urgent:
        return Colors.red;
    }
  }
  
  // نص الحالة
  String get statusText {
    switch (status) {
      case TicketStatus.open:
        return 'مفتوحة';
      case TicketStatus.inProgress:
        return 'قيد المعالجة';
      case TicketStatus.waiting:
        return 'في انتظار الرد';
      case TicketStatus.resolved:
        return 'تم الحل';
      case TicketStatus.closed:
        return 'مغلقة';
    }
  }
  
  // لون الحالة
  Color get statusColor {
    switch (status) {
      case TicketStatus.open:
        return Colors.green;
      case TicketStatus.inProgress:
        return Colors.blue;
      case TicketStatus.waiting:
        return Colors.orange;
      case TicketStatus.resolved:
        return const Color(0xFF00A15C);
      case TicketStatus.closed:
        return Colors.grey;
    }
  }
  
  // هل التذكرة مفتوحة
  bool get isOpen => status == TicketStatus.open || status == TicketStatus.inProgress || status == TicketStatus.waiting;
  
  // عدد الرسائل
  int get messageCount => messages?.length ?? 0;
  
  // آخر تحديث
  String get lastUpdateText {
    final date = updatedAt ?? createdAt;
    final now = DateTime.now();
    final diff = now.difference(date);
    
    if (diff.inDays == 0) {
      if (diff.inHours == 0) {
        return 'منذ ${diff.inMinutes} دقيقة';
      }
      return 'منذ ${diff.inHours} ساعة';
    } else if (diff.inDays == 1) {
      return 'أمس';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
  
  SupportTicket copyWith({
    String? id,
    String? userId,
    String? userName,
    String? userAvatar,
    String? subject,
    String? description,
    TicketCategory? category,
    TicketPriority? priority,
    TicketStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? resolvedAt,
    String? assignedTo,
    String? assignedToName,
    List<TicketMessage>? messages,
    List<String>? attachments,
    String? relatedOrderId,
    String? relatedTransactionId,
    double? satisfactionRating,
  }) {
    return SupportTicket(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      subject: subject ?? this.subject,
      description: description ?? this.description,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      assignedTo: assignedTo ?? this.assignedTo,
      assignedToName: assignedToName ?? this.assignedToName,
      messages: messages ?? this.messages,
      attachments: attachments ?? this.attachments,
      relatedOrderId: relatedOrderId ?? this.relatedOrderId,
      relatedTransactionId: relatedTransactionId ?? this.relatedTransactionId,
      satisfactionRating: satisfactionRating ?? this.satisfactionRating,
    );
  }
}

class TicketMessage {
  final String id;
  final String senderId;
  final String senderName;
  final String? senderAvatar;
  final bool isStaff;
  final String message;
  final DateTime createdAt;
  final List<String>? attachments;
  
  TicketMessage({
    required this.id,
    required this.senderId,
    required this.senderName,
    this.senderAvatar,
    this.isStaff = false,
    required this.message,
    required this.createdAt,
    this.attachments,
  });
  
  factory TicketMessage.fromJson(Map<String, dynamic> json) {
    return TicketMessage(
      id: json['id'] ?? '',
      senderId: json['sender_id'] ?? '',
      senderName: json['sender_name'] ?? '',
      senderAvatar: json['sender_avatar'],
      isStaff: json['is_staff'] ?? false,
      message: json['message'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      attachments: json['attachments'] != null ? List<String>.from(json['attachments']) : null,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender_id': senderId,
      'sender_name': senderName,
      'sender_avatar': senderAvatar,
      'is_staff': isStaff,
      'message': message,
      'created_at': createdAt.toIso8601String(),
      'attachments': attachments,
    };
  }
  
  // وقت الرسالة
  String get formattedTime {
    return '${createdAt.hour}:${createdAt.minute.toString().padLeft(2, '0')}';
  }
}

// تذاكر افتراضية
final List<SupportTicket> sampleTickets = [
  SupportTicket(
    id: 'TKT-001',
    userId: '1',
    userName: 'أحمد محمد',
    subject: 'مشكلة في الدفع',
    description: 'لم يتم إتمام عملية الدفع رغم خصم المبلغ من حسابي',
    category: TicketCategory.billing,
    priority: TicketPriority.high,
    status: TicketStatus.inProgress,
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    updatedAt: DateTime.now().subtract(const Duration(hours: 5)),
    assignedToName: 'خالد الدعم',
    messages: [
      TicketMessage(
        id: 'MSG-001',
        senderId: '1',
        senderName: 'أحمد محمد',
        message: 'السلام عليكم، قمت بإجراء عملية دفع لكنها لم تكتمل',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      TicketMessage(
        id: 'MSG-002',
        senderId: 'staff-1',
        senderName: 'خالد الدعم',
        isStaff: true,
        message: 'وعليكم السلام، نعتذر عن الإزعاج. سنقوم بفحص المشكلة',
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      ),
    ],
  ),
  SupportTicket(
    id: 'TKT-002',
    userId: '1',
    userName: 'أحمد محمد',
    subject: 'استفسار عن الشحن',
    description: 'متى سيتم شحن طلبي رقم ORD-002؟',
    category: TicketCategory.general,
    priority: TicketPriority.low,
    status: TicketStatus.resolved,
    createdAt: DateTime.now().subtract(const Duration(days: 5)),
    updatedAt: DateTime.now().subtract(const Duration(days: 3)),
    resolvedAt: DateTime.now().subtract(const Duration(days: 3)),
    satisfactionRating: 5,
  ),
  SupportTicket(
    id: 'TKT-003',
    userId: '1',
    userName: 'أحمد محمد',
    subject: 'طلب إضافة ميزة',
    description: 'أقترح إضافة خاصية البحث الصوتي في التطبيق',
    category: TicketCategory.featureRequest,
    priority: TicketPriority.medium,
    status: TicketStatus.open,
    createdAt: DateTime.now().subtract(const Duration(hours: 12)),
  ),
];
