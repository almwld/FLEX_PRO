import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';

class ThemeProvider extends ChangeNotifier {
  final LocalStorageService? _storageService;
  ThemeMode _themeMode = ThemeMode.light;
  
  ThemeProvider({LocalStorageService? storageService}) : _storageService = storageService;
  
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  
  Future<void> toggleTheme() async {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await _storageService?.saveData('theme_mode', _themeMode.name);
    notifyListeners();
  }
  
  Future<void> loadTheme() async {
    final saved = await _storageService?.getData('theme_mode');
    if (saved != null) {
      _themeMode = saved == 'dark' ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
    }
  }
}
