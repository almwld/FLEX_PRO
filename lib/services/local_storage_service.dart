// lib/services/local_storage_service.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';

/// خدمة التخزين المحلي
class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();
  factory LocalStorageService() => _instance;
  LocalStorageService._internal();

  SharedPreferences? _prefs;

  /// تهيئة الخدمة
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ========== التوكن ==========

  /// حفظ التوكن
  Future<bool> saveToken(String token) async {
    return await _prefs?.setString('auth_token', token) ?? false;
  }

  /// الحصول على التوكن
  Future<String?> getToken() async {
    return _prefs?.getString('auth_token');
  }

  /// حذف التوكن
  Future<bool> clearToken() async {
    return await _prefs?.remove('auth_token') ?? false;
  }

  // ========== المستخدم ==========

  /// حفظ بيانات المستخدم
  Future<bool> saveUser(UserModel user) async {
    final userJson = jsonEncode(user.toJson());
    return await _prefs?.setString('user_data', userJson) ?? false;
  }

  /// الحصول على بيانات المستخدم
  Future<UserModel?> getUser() async {
    final userJson = _prefs?.getString('user_data');
    if (userJson != null) {
      try {
        final userMap = jsonDecode(userJson) as Map<String, dynamic>;
        return UserModel.fromJson(userMap);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// حذف بيانات المستخدم
  Future<bool> clearUser() async {
    return await _prefs?.remove('user_data') ?? false;
  }

  // ========== السلة ==========

  /// حفظ السلة
  Future<bool> saveCart(CartModel cart) async {
    final cartJson = jsonEncode(cart.toJson());
    return await _prefs?.setString('cart_data', cartJson) ?? false;
  }

  /// الحصول على السلة
  Future<CartModel?> getCart() async {
    final cartJson = _prefs?.getString('cart_data');
    if (cartJson != null) {
      try {
        final cartMap = jsonDecode(cartJson) as Map<String, dynamic>;
        return CartModel.fromJson(cartMap);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// حذف السلة
  Future<bool> clearCart() async {
    return await _prefs?.remove('cart_data') ?? false;
  }

  // ========== إعدادات السمة ==========

  /// حفظ وضع السمة
  Future<bool> saveThemeMode(ThemeMode mode) async {
    return await _prefs?.setString('theme_mode', mode.toString()) ?? false;
  }

  /// الحصول على وضع السمة
  Future<ThemeMode> getThemeMode() async {
    final modeString = _prefs?.getString('theme_mode');
    if (modeString != null) {
      switch (modeString) {
        case 'ThemeMode.dark':
          return ThemeMode.dark;
        case 'ThemeMode.light':
          return ThemeMode.light;
        default:
          return ThemeMode.system;
      }
    }
    return ThemeMode.system;
  }

  /// حفظ الوضع المظلم
  Future<bool> saveIsDarkMode(bool value) async {
    return await _prefs?.setBool('is_dark_mode', value) ?? false;
  }

  /// الحصول على الوضع المظلم
  Future<bool> getIsDarkMode() async {
    return _prefs?.getBool('is_dark_mode') ?? false;
  }

  /// حفظ اللون الأساسي
  Future<bool> savePrimaryColor(int colorValue) async {
    return await _prefs?.setInt('primary_color', colorValue) ?? false;
  }

  /// الحصول على اللون الأساسي
  Future<int> getPrimaryColor() async {
    return _prefs?.getInt('primary_color') ?? 0xFFD4AF37;
  }

  /// حفظ مقياس الخط
  Future<bool> saveFontScale(double scale) async {
    return await _prefs?.setDouble('font_scale', scale) ?? false;
  }

  /// الحصول على مقياس الخط
  Future<double> getFontScale() async {
    return _prefs?.getDouble('font_scale') ?? 1.0;
  }

  // ========== إعدادات الإشعارات ==========

  /// حفظ إعدادات الإشعارات
  Future<bool> saveNotificationSettings(NotificationSettings settings) async {
    final settingsJson = jsonEncode(settings.toJson());
    return await _prefs?.setString('notification_settings', settingsJson) ?? false;
  }

  /// الحصول على إعدادات الإشعارات
  Future<NotificationSettings> getNotificationSettings() async {
    final settingsJson = _prefs?.getString('notification_settings');
    if (settingsJson != null) {
      try {
        final settingsMap = jsonDecode(settingsJson) as Map<String, dynamic>;
        return NotificationSettings.fromJson(settingsMap);
      } catch (e) {
        return NotificationSettings();
      }
    }
    return NotificationSettings();
  }

  // ========== المفضلة ==========

  /// حفظ المفضلة
  Future<bool> saveFavorites(List<String> productIds) async {
    return await _prefs?.setStringList('favorites', productIds) ?? false;
  }

  /// الحصول على المفضلة
  List<String> getFavorites() {
    return _prefs?.getStringList('favorites') ?? [];
  }

  /// إضافة إلى المفضلة
  Future<bool> addToFavorites(String productId) async {
    final favorites = getFavorites();
    if (!favorites.contains(productId)) {
      favorites.add(productId);
      return await saveFavorites(favorites);
    }
    return true;
  }

  /// إزالة من المفضلة
  Future<bool> removeFromFavorites(String productId) async {
    final favorites = getFavorites();
    favorites.remove(productId);
    return await saveFavorites(favorites);
  }

  /// التحقق من المفضلة
  bool isFavorite(String productId) {
    final favorites = getFavorites();
    return favorites.contains(productId);
  }

  // ========== البحث ==========

  /// حفظ سجل البحث
  Future<bool> saveSearchHistory(List<String> queries) async {
    return await _prefs?.setStringList('search_history', queries) ?? false;
  }

  /// الحصول على سجل البحث
  List<String> getSearchHistory() {
    return _prefs?.getStringList('search_history') ?? [];
  }

  /// إضافة إلى سجل البحث
  Future<bool> addToSearchHistory(String query) async {
    final history = getSearchHistory();
    // إزالة إذا موجود
    history.remove(query);
    // إضافة في البداية
    history.insert(0, query);
    // الاحتفاظ بآخر 10 فقط
    if (history.length > 10) {
      history.removeLast();
    }
    return await saveSearchHistory(history);
  }

  /// مسح سجل البحث
  Future<bool> clearSearchHistory() async {
    return await _prefs?.remove('search_history') ?? false;
  }

  // ========== العناوين ==========

  /// حفظ العناوين
  Future<bool> saveAddresses(List<AddressModel> addresses) async {
    final addressesJson = jsonEncode(addresses.map((a) => a.toJson()).toList());
    return await _prefs?.setString('addresses', addressesJson) ?? false;
  }

  /// الحصول على العناوين
  Future<List<AddressModel>> getAddresses() async {
    final addressesJson = _prefs?.getString('addresses');
    if (addressesJson != null) {
      try {
        final addressesList = jsonDecode(addressesJson) as List;
        return addressesList.map((a) => AddressModel.fromJson(a)).toList();
      } catch (e) {
        return [];
      }
    }
    return [];
  }

  // ========== مسح الكل ==========

  /// مسح جميع البيانات
  Future<bool> clearAll() async {
    return await _prefs?.clear() ?? false;
  }
}
