import 'package:flutter/material.dart';
import '../services/storage/local_storage_service.dart';

enum ViewMode { lite, pro, expert }

class ViewModeProvider extends ChangeNotifier {
  ViewMode _currentMode = ViewMode.lite;
  bool _isDarkMode = false;
  String _selectedTheme = 'gold';
  bool _showAnimations = true;
  bool _compactMode = false;
  
  ViewMode get currentMode => _currentMode;
  bool get isPro => _currentMode == ViewMode.pro;
  bool get isExpert => _currentMode == ViewMode.expert;
  bool get isLite => _currentMode == ViewMode.lite;
  bool get isDarkMode => _isDarkMode;
  String get selectedTheme => _selectedTheme;
  bool get showAnimations => _showAnimations;
  bool get compactMode => _compactMode;
  
  ViewModeProvider() {
    _loadSettings();
  }
  
  void _loadSettings() {
    final savedMode = LocalStorageService.getViewMode();
    _currentMode = ViewMode.values.firstWhere(
      (e) => e.name == savedMode,
      orElse: () => ViewMode.lite,
    );
    _isDarkMode = LocalStorageService.isDarkMode();
    notifyListeners();
  }
  
  void setMode(ViewMode mode) {
    if (_currentMode != mode) {
      _currentMode = mode;
      LocalStorageService.setViewMode(mode.name);
      notifyListeners();
    }
  }
  
  void toggleMode() {
    if (_currentMode == ViewMode.lite) {
      setMode(ViewMode.pro);
    } else if (_currentMode == ViewMode.pro) {
      setMode(ViewMode.expert);
    } else {
      setMode(ViewMode.lite);
    }
  }
  
  void setLiteMode() => setMode(ViewMode.lite);
  void setProMode() => setMode(ViewMode.pro);
  void setExpertMode() => setMode(ViewMode.expert);
  
  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    LocalStorageService.setDarkMode(_isDarkMode);
    notifyListeners();
  }
  
  void setDarkMode(bool value) {
    if (_isDarkMode != value) {
      _isDarkMode = value;
      LocalStorageService.setDarkMode(_isDarkMode);
      notifyListeners();
    }
  }
  
  void setTheme(String theme) {
    if (_selectedTheme != theme) {
      _selectedTheme = theme;
      notifyListeners();
    }
  }
  
  void toggleAnimations() {
    _showAnimations = !_showAnimations;
    notifyListeners();
  }
  
  void setShowAnimations(bool value) {
    if (_showAnimations != value) {
      _showAnimations = value;
      notifyListeners();
    }
  }
  
  void toggleCompactMode() {
    _compactMode = !_compactMode;
    notifyListeners();
  }
  
  void setCompactMode(bool value) {
    if (_compactMode != value) {
      _compactMode = value;
      notifyListeners();
    }
  }
  
  String getModeName() {
    switch (_currentMode) {
      case ViewMode.lite:
        return 'وضع Lite';
      case ViewMode.pro:
        return 'وضع PRO';
      case ViewMode.expert:
        return 'وضع Expert';
    }
  }
  
  String getModeDescription() {
    switch (_currentMode) {
      case ViewMode.lite:
        return 'واجهة بسيطة مع الميزات الأساسية';
      case ViewMode.pro:
        return 'ميزات متقدمة وإحصائيات مفصلة';
      case ViewMode.expert:
        return 'جميع الميزات مع تحكم كامل';
    }
  }
  
  IconData getModeIcon() {
    switch (_currentMode) {
      case ViewMode.lite:
        return Icons.flash_on;
      case ViewMode.pro:
        return Icons.workspace_premium;
      case ViewMode.expert:
        return Icons.star;
    }
  }
  
  Color getModeColor() {
    switch (_currentMode) {
      case ViewMode.lite:
        return Colors.grey;
      case ViewMode.pro:
        return const Color(0xFFD4AF37);
      case ViewMode.expert:
        return Colors.purple;
    }
  }
  
  // ميزات كل وضع
  List<String> getModeFeatures() {
    switch (_currentMode) {
      case ViewMode.lite:
        return [
          'واجهة بسيطة وسهلة',
          'الوصول السريع للميزات الأساسية',
          'تصفح المنتجات',
          'إدارة الطلبات',
          'المحفظة الإلكترونية',
        ];
      case ViewMode.pro:
        return [
          'جميع ميزات Lite',
          '10 أسواق متخصصة',
          '25 قسم رئيسي',
          '30 منتج رائج',
          'إحصائيات حية',
          'تبويبات متقدمة',
          'زر الإجراءات السريعة',
        ];
      case ViewMode.expert:
        return [
          'جميع ميزات PRO',
          'لوحة تحكم كاملة',
          'تحليلات متقدمة',
          'إدارة البائعين',
          'تقارير مفصلة',
          'إنجازات ومكافآت',
          'دورات أكاديمية',
          'دعم فني مميز',
        ];
    }
  }
  
  // التحقق من توفر ميزة
  bool isFeatureAvailable(String feature) {
    final features = getModeFeatures();
    return features.contains(feature);
  }
  
  // الحد الأقصى للعناصر المعروضة
  int getMaxDisplayItems() {
    switch (_currentMode) {
      case ViewMode.lite:
        return 10;
      case ViewMode.pro:
        return 30;
      case ViewMode.expert:
        return 100;
    }
  }
  
  // عدد الأعمدة في الشبكة
  int getGridColumns() {
    switch (_currentMode) {
      case ViewMode.lite:
        return 2;
      case ViewMode.pro:
        return 3;
      case ViewMode.expert:
        return 4;
    }
  }
  
  // حجم البطاقات
  double getCardSize() {
    switch (_currentMode) {
      case ViewMode.lite:
        return 1.0;
      case ViewMode.pro:
        return 0.9;
      case ViewMode.expert:
        return 0.8;
    }
  }
  
  // عرض الشريط الجانبي
  bool get showSidebar => _currentMode == ViewMode.expert;
  
  // عرض الرسوم البيانية
  bool get showCharts => _currentMode != ViewMode.lite;
  
  // عرض الإحصائيات المتقدمة
  bool get showAdvancedStats => _currentMode == ViewMode.expert;
  
  // عرض أدوات التحكم السريع
  bool get showQuickActions => _currentMode != ViewMode.lite;
  
  // عرض الفلاتر المتقدمة
  bool get showAdvancedFilters => _currentMode == ViewMode.expert;
  
  // عرض التصدير
  bool get showExportOptions => _currentMode == ViewMode.expert;
  
  // عرض الإشعارات المباشرة
  bool get showLiveNotifications => _currentMode != ViewMode.lite;
}
