import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String? _userName;
  
  bool get isLoggedIn => _isLoggedIn;
  String? get userName => _userName;
  
  Future<void> login(String email, String password) async {
    _isLoggedIn = true;
    _userName = email.split('@').first;
    notifyListeners();
  }
  
  Future<void> logout() async {
    _isLoggedIn = false;
    _userName = null;
    notifyListeners();
  }
  
  Future<void> forgotPassword(String email) async {
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
