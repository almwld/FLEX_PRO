// lib/providers/notification_provider.dart

import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/services.dart';

/// حالات الإشعارات
enum NotificationStatus {
  initial,
  loading,
  loaded,
  error,
}

/// Provider الإشعارات
class NotificationProvider extends ChangeNotifier {
  final NotificationService _notificationService;

  NotificationProvider({required NotificationService notificationService})
      : _notificationService = notificationService;

  // ========== الحالة ==========
  NotificationStatus _status = NotificationStatus.initial;
  List<NotificationModel> _notifications = [];
  NotificationSettings _settings = NotificationSettings();
  String? _errorMessage;
  int _unreadCount = 0;
  bool _isLoadingMore = false;
  int _currentPage = 1;
  bool _hasMore = true;

  // ========== Getters ==========
  NotificationStatus get status => _status;
  List<NotificationModel> get notifications => _notifications;
  NotificationSettings get settings => _settings;
  String? get errorMessage => _errorMessage;
  int get unreadCount => _unreadCount;
  bool get isLoading => _status == NotificationStatus.loading;
  bool get isLoadingMore => _isLoadingMore;
  bool get hasMore => _hasMore;

  /// الإشعارات غير المقروءة
  List<NotificationModel> get unreadNotifications {
    return _notifications.where((n) => !n.isRead).toList();
  }

  /// الإشعارات المقروءة
  List<NotificationModel> get readNotifications {
    return _notifications.where((n) => n.isRead).toList();
  }

  // ========== Methods ==========

  /// تحميل الإشعارات
  Future<void> loadNotifications({
    bool refresh = false,
    int page = 1,
    int limit = 20,
  }) async {
    if (refresh) {
      _currentPage = 1;
      _notifications = [];
      _hasMore = true;
    }

    if (page > 1) {
      _isLoadingMore = true;
    } else {
      _status = NotificationStatus.loading;
    }

    _clearError();
    notifyListeners();

    try {
      final notifications = await _notificationService.getNotifications(
        page: page,
        limit: limit,
      );

      if (notifications.isNotEmpty) {
        if (page == 1) {
          _notifications = notifications;
        } else {
          _notifications.addAll(notifications);
        }
        _currentPage++;
        _hasMore = notifications.length >= limit;
      } else {
        _hasMore = false;
      }

      _updateUnreadCount();
      _status = NotificationStatus.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _status = NotificationStatus.error;
    } finally {
      _isLoadingMore = false;
      notifyListeners();
    }
  }

  /// تحميل المزيد من الإشعارات
  Future<void> loadMoreNotifications() async {
    if (_isLoadingMore || !_hasMore) return;
    await loadNotifications(page: _currentPage);
  }

  /// تحميل الإعدادات
  Future<void> loadSettings() async {
    try {
      _settings = await _notificationService.getSettings();
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
    }
  }

  /// تحديث الإعدادات
  Future<void> updateSettings(NotificationSettings newSettings) async {
    try {
      final result = await _notificationService.updateSettings(newSettings);
      if (result) {
        _settings = newSettings;
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = e.toString();
    }
  }

  /// تبديل إعداد
  Future<void> toggleSetting(String key) async {
    try {
      final newSettings = _settings.copyWith();
      // تحديث الإعداد حسب المفتاح
      switch (key) {
        case 'enabled':
          await updateSettings(newSettings.copyWith(enabled: !newSettings.enabled));
          break;
        case 'transactions':
          await updateSettings(newSettings.copyWith(transactions: !newSettings.transactions));
          break;
        case 'promotions':
          await updateSettings(newSettings.copyWith(promotions: !newSettings.promotions));
          break;
        case 'orders':
          await updateSettings(newSettings.copyWith(orders: !newSettings.orders));
          break;
        case 'messages':
          await updateSettings(newSettings.copyWith(messages: !newSettings.messages));
          break;
        case 'alerts':
          await updateSettings(newSettings.copyWith(alerts: !newSettings.alerts));
          break;
        case 'sound':
          await updateSettings(newSettings.copyWith(sound: !newSettings.sound));
          break;
        case 'vibration':
          await updateSettings(newSettings.copyWith(vibration: !newSettings.vibration));
          break;
      }
    } catch (e) {
      _errorMessage = e.toString();
    }
  }

  /// تحديد إشعار كمقروء
  Future<void> markAsRead(String notificationId) async {
    try {
      final result = await _notificationService.markAsRead(notificationId);

      if (result) {
        final index = _notifications.indexWhere((n) => n.id == notificationId);
        if (index >= 0) {
          _notifications[index] = _notifications[index].copyWith(
            isRead: true,
            readAt: DateTime.now(),
          );
          _updateUnreadCount();
          notifyListeners();
        }
      }
    } catch (e) {
      _errorMessage = e.toString();
    }
  }

  /// تحديد جميع الإشعارات كمقروءة
  Future<void> markAllAsRead() async {
    try {
      final result = await _notificationService.markAllAsRead();

      if (result) {
        _notifications = _notifications.map((n) {
          if (!n.isRead) {
            return n.copyWith(isRead: true, readAt: DateTime.now());
          }
          return n;
        }).toList();
        _unreadCount = 0;
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = e.toString();
    }
  }

  /// حذف إشعار
  Future<void> deleteNotification(String notificationId) async {
    try {
      final result = await _notificationService.deleteNotification(notificationId);

      if (result) {
        _notifications.removeWhere((n) => n.id == notificationId);
        _updateUnreadCount();
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = e.toString();
    }
  }

  /// حذف جميع الإشعارات
  Future<void> deleteAllNotifications() async {
    try {
      final result = await _notificationService.deleteAllNotifications();

      if (result) {
        _notifications = [];
        _unreadCount = 0;
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = e.toString();
    }
  }

  /// إضافة إشعار محلي
  void addLocalNotification(NotificationModel notification) {
    _notifications.insert(0, notification);
    if (!notification.isRead) {
      _unreadCount++;
    }
    notifyListeners();
  }

  /// تحديث العدد غير المقروء
  void _updateUnreadCount() {
    _unreadCount = _notifications.where((n) => !n.isRead).length;
  }

  /// مسح الخطأ
  void clearError() {
    _clearError();
    notifyListeners();
  }

  /// إعادة تعيين
  void reset() {
    _status = NotificationStatus.initial;
    _notifications = [];
    _settings = NotificationSettings();
    _errorMessage = null;
    _unreadCount = 0;
    _hasMore = true;
    _currentPage = 1;
    notifyListeners();
  }

  // ========== Private Methods ==========

  void _clearError() {
    _errorMessage = null;
  }
}
