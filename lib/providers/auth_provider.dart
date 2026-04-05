// lib/providers/auth_provider.dart

import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/services.dart';

/// حالات المصادقة
enum AuthStatus {
  initial,
  authenticated,
  unauthenticated,
  loading,
  error,
}

/// Provider المصادقة
class AuthProvider extends ChangeNotifier {
  final AuthService _authService;
  final LocalStorageService _storageService;

  AuthProvider({
    required AuthService authService,
    required LocalStorageService storageService,
  })  : _authService = authService,
        _storageService = storageService {
    _checkAuthStatus();
  }

  // ========== الحالة ==========
  AuthStatus _status = AuthStatus.initial;
  UserModel? _user;
  String? _errorMessage;
  bool _isLoading = false;

  // ========== Getters ==========
  AuthStatus get status => _status;
  UserModel? get user => _user;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _status == AuthStatus.authenticated && _user != null;
  bool get isUnauthenticated => _status == AuthStatus.unauthenticated;
  String? get userId => _user?.id;
  String? get userName => _user?.fullName;
  String? get userEmail => _user?.email;
  String? get userPhone => _user?.phone;
  String? get userAvatar => _user?.avatarUrl;
  ViewMode get viewMode => _user?.viewMode ?? ViewMode.lite;
  bool get isPro => _user?.isPro ?? false;
  int get proLevel => _user?.proLevel ?? 0;

  // ========== Methods ==========

  /// التحقق من حالة المصادقة
  Future<void> _checkAuthStatus() async {
    _setLoading(true);
    try {
      final token = await _storageService.getToken();
      if (token != null && token.isNotEmpty) {
        final user = await _authService.getCurrentUser();
        if (user != null) {
          _user = user;
          _status = AuthStatus.authenticated;
        } else {
          _status = AuthStatus.unauthenticated;
          await _storageService.clearToken();
        }
      } else {
        _status = AuthStatus.unauthenticated;
      }
    } catch (e) {
      _status = AuthStatus.unauthenticated;
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  /// تسجيل الدخول
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _clearError();
    try {
      final response = await _authService.login(
        email: email,
        password: password,
      );

      if (response.success && response.user != null) {
        _user = response.user;
        _status = AuthStatus.authenticated;
        if (response.token != null) {
          await _storageService.saveToken(response.token!);
        }
        notifyListeners();
        return true;
      } else {
        _errorMessage = response.message ?? 'فشل تسجيل الدخول';
        _status = AuthStatus.error;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      _status = AuthStatus.error;
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// تسجيل الدخول برقم الهاتف
  Future<bool> loginWithPhone({
    required String phone,
    required String otp,
  }) async {
    _setLoading(true);
    _clearError();
    try {
      final response = await _authService.loginWithPhone(
        phone: phone,
        otp: otp,
      );

      if (response.success && response.user != null) {
        _user = response.user;
        _status = AuthStatus.authenticated;
        if (response.token != null) {
          await _storageService.saveToken(response.token!);
        }
        notifyListeners();
        return true;
      } else {
        _errorMessage = response.message ?? 'فشل تسجيل الدخول';
        _status = AuthStatus.error;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      _status = AuthStatus.error;
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// إرسال رمز OTP
  Future<bool> sendOTP(String phone) async {
    _setLoading(true);
    _clearError();
    try {
      final result = await _authService.sendOTP(phone);
      if (!result) {
        _errorMessage = 'فشل إرسال رمز التحقق';
      }
      notifyListeners();
      return result;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// إنشاء حساب جديد
  Future<bool> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    _setLoading(true);
    _clearError();
    try {
      final response = await _authService.register(
        fullName: fullName,
        email: email,
        phone: phone,
        password: password,
      );

      if (response.success && response.user != null) {
        _user = response.user;
        _status = AuthStatus.authenticated;
        if (response.token != null) {
          await _storageService.saveToken(response.token!);
        }
        notifyListeners();
        return true;
      } else {
        _errorMessage = response.message ?? 'فشل إنشاء الحساب';
        _status = AuthStatus.error;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      _status = AuthStatus.error;
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// تسجيل الخروج
  Future<void> logout() async {
    _setLoading(true);
    try {
      await _authService.logout();
      await _storageService.clearToken();
      _user = null;
      _status = AuthStatus.unauthenticated;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  /// تحديث بيانات المستخدم
  Future<bool> updateProfile({
    String? fullName,
    String? email,
    String? phone,
    String? avatarUrl,
  }) async {
    _setLoading(true);
    _clearError();
    try {
      if (_user == null) return false;

      final updatedUser = await _authService.updateProfile(
        userId: _user!.id,
        fullName: fullName,
        email: email,
        phone: phone,
        avatarUrl: avatarUrl,
      );

      if (updatedUser != null) {
        _user = updatedUser;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// تغيير كلمة المرور
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    _setLoading(true);
    _clearError();
    try {
      if (_user == null) return false;

      final result = await _authService.changePassword(
        userId: _user!.id,
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

      if (!result) {
        _errorMessage = 'فشل تغيير كلمة المرور';
        notifyListeners();
      }
      return result;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// تعيين وضع العرض
  Future<void> setViewMode(ViewMode mode) async {
    if (_user == null) return;

    try {
      final updatedUser = _user!.copyWith(viewMode: mode);
      final result = await _authService.updateProfile(
        userId: _user!.id,
        viewMode: mode,
      );

      if (result != null) {
        _user = result;
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = e.toString();
    }
  }

  /// ترقية إلى PRO
  Future<bool> upgradeToPro(int level) async {
    _setLoading(true);
    _clearError();
    try {
      if (_user == null) return false;

      final result = await _authService.upgradeToPro(
        userId: _user!.id,
        level: level,
      );

      if (result != null) {
        _user = result;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// إعادة تعيين كلمة المرور
  Future<bool> resetPassword(String email) async {
    _setLoading(true);
    _clearError();
    try {
      final result = await _authService.resetPassword(email);
      if (!result) {
        _errorMessage = 'فشل إرسال رابط إعادة التعيين';
      }
      notifyListeners();
      return result;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// مسح الخطأ
  void clearError() {
    _clearError();
    notifyListeners();
  }

  // ========== Private Methods ==========

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    if (_status == AuthStatus.error) {
      _status = AuthStatus.initial;
    }
  }
}

/// استجابة المصادقة
class AuthResponse {
  final bool success;
  final String? message;
  final UserModel? user;
  final String? token;

  AuthResponse({
    required this.success,
    this.message,
    this.user,
    this.token,
  });
}
