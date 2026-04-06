import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/local_storage_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final LocalStorageService? _storageService;
  
  bool _isLoggedIn = false;
  String? _userName;
  
  AuthProvider({LocalStorageService? storageService}) : _storageService = storageService;
  
  bool get isLoggedIn => _isLoggedIn;
  String? get userName => _userName;
  
  Future<void> login(String email, String password) async {
    _isLoggedIn = true;
    _userName = email.split('@').first;
    await _storageService?.saveData('is_logged_in', true);
    notifyListeners();
  }
  
  Future<void> logout() async {
    _isLoggedIn = false;
    _userName = null;
    await _storageService?.saveData('is_logged_in', false);
    notifyListeners();
  }
  
  Future<void> loadAuthState() async {
    final saved = await _storageService?.getData('is_logged_in');
    _isLoggedIn = saved == true;
    notifyListeners();
  }
  
  Future<void> forgotPassword(String email) async {
    // محاكاة
    await Future.delayed(const Duration(seconds: 1));
  }
  
  Future<bool> verifyOtp(String phone, String code, String purpose) async {
    await Future.delayed(const Duration(seconds: 1));
    return code.length == 6;
  }
  
  Future<bool> sendOtp(String phone) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}
