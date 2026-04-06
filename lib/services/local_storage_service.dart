import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static late SharedPreferences _prefs;
  
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  
  static Future<void> saveData(String key, dynamic value) async {
    if (value is String) {
      await _prefs.setString(key, value);
    } else if (value is bool) {
      await _prefs.setBool(key, value);
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    }
  }
  
  static Future<dynamic> getData(String key) async {
    return _prefs.get(key);
  }
  
  static Future<void> removeData(String key) async {
    await _prefs.remove(key);
  }
  
  static Future<void> clearAll() async {
    await _prefs.clear();
  }
}
