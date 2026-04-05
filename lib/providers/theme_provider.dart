// lib/providers/theme_provider.dart

import 'package:flutter/material.dart';
import '../services/services.dart';

/// Provider السمة والثيم
class ThemeProvider extends ChangeNotifier {
  final LocalStorageService _storageService;

  ThemeProvider({required LocalStorageService storageService})
      : _storageService = storageService {
    _loadThemeSettings();
  }

  // ========== الحالة ==========
  ThemeMode _themeMode = ThemeMode.system;
  bool _isDarkMode = false;
  Color _primaryColor = const Color(0xFFD4AF37); // الذهبي
  double _fontScale = 1.0;
  bool _isLoaded = false;

  // ========== Getters ==========
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _isDarkMode;
  bool get isSystemMode => _themeMode == ThemeMode.system;
  bool get isLightMode => _themeMode == ThemeMode.light;
  Color get primaryColor => _primaryColor;
  double get fontScale => _fontScale;
  bool get isLoaded => _isLoaded;

  // ========== Methods ==========

  /// تحميل إعدادات السمة
  Future<void> _loadThemeSettings() async {
    try {
      final themeMode = await _storageService.getThemeMode();
      final isDark = await _storageService.getIsDarkMode();
      final fontScale = await _storageService.getFontScale();

      _themeMode = themeMode;
      _isDarkMode = isDark;
      _fontScale = fontScale;
      _isLoaded = true;

      notifyListeners();
    } catch (e) {
      _isLoaded = true;
      notifyListeners();
    }
  }

  /// تعيين وضع السمة
  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;

    if (mode == ThemeMode.dark) {
      _isDarkMode = true;
    } else if (mode == ThemeMode.light) {
      _isDarkMode = false;
    }

    await _storageService.saveThemeMode(mode);
    await _storageService.saveIsDarkMode(_isDarkMode);

    notifyListeners();
  }

  /// تبديل الوضع المظلم/الفاتح
  Future<void> toggleDarkMode() async {
    _isDarkMode = !_isDarkMode;
    _themeMode = _isDarkMode ? ThemeMode.dark : ThemeMode.light;

    await _storageService.saveThemeMode(_themeMode);
    await _storageService.saveIsDarkMode(_isDarkMode);

    notifyListeners();
  }

  /// تعيين الوضع المظلم
  Future<void> setDarkMode(bool value) async {
    _isDarkMode = value;
    _themeMode = value ? ThemeMode.dark : ThemeMode.light;

    await _storageService.saveThemeMode(_themeMode);
    await _storageService.saveIsDarkMode(_isDarkMode);

    notifyListeners();
  }

  /// تعيين اللون الأساسي
  Future<void> setPrimaryColor(Color color) async {
    _primaryColor = color;
    await _storageService.savePrimaryColor(color.value);
    notifyListeners();
  }

  /// تعيين مقياس الخط
  Future<void> setFontScale(double scale) async {
    if (scale < 0.8 || scale > 1.5) return;

    _fontScale = scale;
    await _storageService.saveFontScale(scale);
    notifyListeners();
  }

  /// زيادة مقياس الخط
  Future<void> increaseFontScale() async {
    if (_fontScale < 1.5) {
      _fontScale = double.parse((_fontScale + 0.1).toStringAsFixed(1));
      await _storageService.saveFontScale(_fontScale);
      notifyListeners();
    }
  }

  /// تقليل مقياس الخط
  Future<void> decreaseFontScale() async {
    if (_fontScale > 0.8) {
      _fontScale = double.parse((_fontScale - 0.1).toStringAsFixed(1));
      await _storageService.saveFontScale(_fontScale);
      notifyListeners();
    }
  }

  /// إعادة تعيين الإعدادات
  Future<void> resetSettings() async {
    _themeMode = ThemeMode.system;
    _isDarkMode = false;
    _primaryColor = const Color(0xFFD4AF37);
    _fontScale = 1.0;

    await _storageService.saveThemeMode(_themeMode);
    await _storageService.saveIsDarkMode(_isDarkMode);
    await _storageService.saveFontScale(_fontScale);

    notifyListeners();
  }
}
