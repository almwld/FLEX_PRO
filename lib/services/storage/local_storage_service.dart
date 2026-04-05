import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static SharedPreferences? _prefs;
  
  // تهيئة الخدمة
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  
  // التحقق من التهيئة
  static SharedPreferences get _preferences {
    if (_prefs == null) {
      throw Exception('LocalStorageService not initialized. Call init() first.');
    }
    return _prefs!;
  }
  
  // حفظ قيمة نصية
  static Future<bool> setString(String key, String value) async {
    return await _preferences.setString(key, value);
  }
  
  // الحصول على قيمة نصية
  static String? getString(String key, {String? defaultValue}) {
    return _preferences.getString(key) ?? defaultValue;
  }
  
  // حفظ قيمة رقمية صحيحة
  static Future<bool> setInt(String key, int value) async {
    return await _preferences.setInt(key, value);
  }
  
  // الحصول على قيمة رقمية صحيحة
  static int getInt(String key, {int defaultValue = 0}) {
    return _preferences.getInt(key) ?? defaultValue;
  }
  
  // حفظ قيمة رقمية عشرية
  static Future<bool> setDouble(String key, double value) async {
    return await _preferences.setDouble(key, value);
  }
  
  // الحصول على قيمة رقمية عشرية
  static double getDouble(String key, {double defaultValue = 0.0}) {
    return _preferences.getDouble(key) ?? defaultValue;
  }
  
  // حفظ قيمة منطقية
  static Future<bool> setBool(String key, bool value) async {
    return await _preferences.setBool(key, value);
  }
  
  // الحصول على قيمة منطقية
  static bool getBool(String key, {bool defaultValue = false}) {
    return _preferences.getBool(key) ?? defaultValue;
  }
  
  // حفظ قائمة نصية
  static Future<bool> setStringList(String key, List<String> value) async {
    return await _preferences.setStringList(key, value);
  }
  
  // الحصول على قائمة نصية
  static List<String> getStringList(String key, {List<String>? defaultValue}) {
    return _preferences.getStringList(key) ?? defaultValue ?? [];
  }
  
  // حفظ كائن JSON
  static Future<bool> setJson(String key, Map<String, dynamic> value) async {
    return await _preferences.setString(key, jsonEncode(value));
  }
  
  // الحصول على كائن JSON
  static Map<String, dynamic>? getJson(String key) {
    final String? jsonString = _preferences.getString(key);
    if (jsonString == null || jsonString.isEmpty) return null;
    try {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }
  
  // حفظ قائمة كائنات JSON
  static Future<bool> setJsonList(String key, List<Map<String, dynamic>> value) async {
    return await _preferences.setString(key, jsonEncode(value));
  }
  
  // الحصول على قائمة كائنات JSON
  static List<Map<String, dynamic>> getJsonList(String key) {
    final String? jsonString = _preferences.getString(key);
    if (jsonString == null || jsonString.isEmpty) return [];
    try {
      final List<dynamic> list = jsonDecode(jsonString);
      return list.map((e) => e as Map<String, dynamic>).toList();
    } catch (e) {
      return [];
    }
  }
  
  // حذف قيمة
  static Future<bool> remove(String key) async {
    return await _preferences.remove(key);
  }
  
  // التحقق من وجود مفتاح
  static bool containsKey(String key) {
    return _preferences.containsKey(key);
  }
  
  // مسح جميع البيانات
  static Future<bool> clear() async {
    return await _preferences.clear();
  }
  
  // الحصول على جميع المفاتيح
  static Set<String> getKeys() {
    return _preferences.getKeys();
  }
  
  // ==================== دوال مساعدة محددة ====================
  
  // حفظ بيانات المستخدم
  static Future<bool> saveUserData(Map<String, dynamic> userData) async {
    return await setJson('user_data', userData);
  }
  
  // الحصول على بيانات المستخدم
  static Map<String, dynamic>? getUserData() {
    return getJson('user_data');
  }
  
  // حذف بيانات المستخدم
  static Future<bool> clearUserData() async {
    return await remove('user_data');
  }
  
  // التحقق من تسجيل الدخول
  static bool isLoggedIn() {
    return getJson('user_data') != null;
  }
  
  // حفظ رمز المصادقة
  static Future<bool> saveAuthToken(String token) async {
    return await setString('auth_token', token);
  }
  
  // الحصول على رمز المصادقة
  static String? getAuthToken() {
    return getString('auth_token');
  }
  
  // حذف رمز المصادقة
  static Future<bool> clearAuthToken() async {
    return await remove('auth_token');
  }
  
  // حفظ حالة الوضع الليلي
  static Future<bool> setDarkMode(bool isDarkMode) async {
    return await setBool('is_dark_mode', isDarkMode);
  }
  
  // الحصول على حالة الوضع الليلي
  static bool isDarkMode() {
    return getBool('is_dark_mode', defaultValue: false);
  }
  
  // حفظ اللغة المختارة
  static Future<bool> setLanguage(String languageCode) async {
    return await setString('language_code', languageCode);
  }
  
  // الحصول على اللغة المختارة
  static String getLanguage() {
    return getString('language_code', defaultValue: 'ar')!;
  }
  
  // حفظ وضع العرض (Lite/PRO/Expert)
  static Future<bool> setViewMode(String mode) async {
    return await setString('view_mode', mode);
  }
  
  // الحصول على وضع العرض
  static String getViewMode() {
    return getString('view_mode', defaultValue: 'lite')!;
  }
  
  // حفظ بيانات المحفظة
  static Future<bool> saveWalletData(Map<String, dynamic> walletData) async {
    return await setJson('wallet_data', walletData);
  }
  
  // الحصول على بيانات المحفظة
  static Map<String, dynamic>? getWalletData() {
    return getJson('wallet_data');
  }
  
  // حفظ سلة التسوق
  static Future<bool> saveCart(List<Map<String, dynamic>> cartItems) async {
    return await setJsonList('cart_items', cartItems);
  }
  
  // الحصول على سلة التسوق
  static List<Map<String, dynamic>> getCart() {
    return getJsonList('cart_items');
  }
  
  // إضافة عنصر إلى السلة
  static Future<bool> addToCart(Map<String, dynamic> item) async {
    final cart = getCart();
    cart.add(item);
    return await saveCart(cart);
  }
  
  // إزالة عنصر من السلة
  static Future<bool> removeFromCart(String itemId) async {
    final cart = getCart();
    cart.removeWhere((item) => item['id'] == itemId);
    return await saveCart(cart);
  }
  
  // مسح السلة
  static Future<bool> clearCart() async {
    return await remove('cart_items');
  }
  
  // حفظ المفضلة
  static Future<bool> saveFavorites(List<String> productIds) async {
    return await setStringList('favorite_products', productIds);
  }
  
  // الحصول على المفضلة
  static List<String> getFavorites() {
    return getStringList('favorite_products');
  }
  
  // إضافة إلى المفضلة
  static Future<bool> addToFavorites(String productId) async {
    final favorites = getFavorites();
    if (!favorites.contains(productId)) {
      favorites.add(productId);
      return await saveFavorites(favorites);
    }
    return true;
  }
  
  // إزالة من المفضلة
  static Future<bool> removeFromFavorites(String productId) async {
    final favorites = getFavorites();
    favorites.remove(productId);
    return await saveFavorites(favorites);
  }
  
  // حفظ الإشعارات المقروءة
  static Future<bool> saveReadNotifications(List<String> notificationIds) async {
    return await setStringList('read_notifications', notificationIds);
  }
  
  // الحصول على الإشعارات المقروءة
  static List<String> getReadNotifications() {
    return getStringList('read_notifications');
  }
  
  // حفظ إعدادات الإشعارات
  static Future<bool> saveNotificationSettings(Map<String, bool> settings) async {
    return await setJson('notification_settings', settings);
  }
  
  // الحصول على إعدادات الإشعارات
  static Map<String, dynamic> getNotificationSettings() {
    return getJson('notification_settings') ?? {
      'transactions': true,
      'orders': true,
      'promotions': true,
      'updates': true,
      'messages': true,
    };
  }
  
  // حفظ آخر وقت للمزامنة
  static Future<bool> setLastSyncTime(DateTime time) async {
    return await setString('last_sync_time', time.toIso8601String());
  }
  
  // الحصول على آخر وقت للمزامنة
  static DateTime? getLastSyncTime() {
    final timeString = getString('last_sync_time');
    if (timeString == null) return null;
    return DateTime.tryParse(timeString);
  }
  
  // حفظ بيانات التخزين المؤقت
  static Future<bool> setCache(String key, dynamic data, {Duration? expiry}) async {
    final cacheData = {
      'data': data,
      'timestamp': DateTime.now().toIso8601String(),
      'expiry': expiry?.inSeconds,
    };
    return await setJson('cache_$key', cacheData);
  }
  
  // الحصول على بيانات التخزين المؤقت
  static dynamic getCache(String key) {
    final cacheData = getJson('cache_$key');
    if (cacheData == null) return null;
    
    final timestamp = DateTime.parse(cacheData['timestamp']);
    final expiry = cacheData['expiry'] as int?;
    
    if (expiry != null) {
      final expiryTime = timestamp.add(Duration(seconds: expiry));
      if (DateTime.now().isAfter(expiryTime)) {
        remove('cache_$key');
        return null;
      }
    }
    
    return cacheData['data'];
  }
  
  // مسح التخزين المؤقت
  static Future<void> clearCache() async {
    final keys = getKeys().where((key) => key.startsWith('cache_')).toList();
    for (final key in keys) {
      await remove(key);
    }
  }
}
