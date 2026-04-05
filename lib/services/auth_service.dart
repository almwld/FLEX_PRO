// lib/services/auth_service.dart

import '../models/models.dart';

/// خدمة المصادقة
class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // ========== تسجيل الدخول ==========

  /// تسجيل الدخول بالبريد وكلمة المرور
  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    // TODO: ربط مع API
    // محاكاة للاستجابة
    await Future.delayed(const Duration(seconds: 1));

    // محاكاة نجاح تسجيل الدخول
    return AuthResponse(
      success: true,
      message: 'تم تسجيل الدخول بنجاح',
      token: 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
      user: UserModel(
        id: 'user_1',
        fullName: 'محمد أحمد',
        email: email,
        phone: '+967777123456',
        avatarUrl: null,
        viewMode: ViewMode.lite,
        isPro: false,
        proLevel: 0,
        isVerified: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  }

  /// تسجيل الدخول برقم الهاتف
  Future<AuthResponse> loginWithPhone({
    required String phone,
    required String otp,
  }) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(seconds: 1));

    return AuthResponse(
      success: true,
      message: 'تم تسجيل الدخول بنجاح',
      token: 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
      user: UserModel(
        id: 'user_1',
        fullName: 'محمد أحمد',
        email: 'user@example.com',
        phone: phone,
        avatarUrl: null,
        viewMode: ViewMode.lite,
        isPro: false,
        proLevel: 0,
        isVerified: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  }

  /// إرسال رمز OTP
  Future<bool> sendOTP(String phone) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  /// إنشاء حساب جديد
  Future<AuthResponse> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(seconds: 1));

    return AuthResponse(
      success: true,
      message: 'تم إنشاء الحساب بنجاح',
      token: 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
      user: UserModel(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        fullName: fullName,
        email: email,
        phone: phone,
        avatarUrl: null,
        viewMode: ViewMode.lite,
        isPro: false,
        proLevel: 0,
        isVerified: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  }

  /// تسجيل الخروج
  Future<void> logout() async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(milliseconds: 500));
  }

  /// الحصول على المستخدم الحالي
  Future<UserModel?> getCurrentUser() async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(milliseconds: 500));

    return UserModel(
      id: 'user_1',
      fullName: 'محمد أحمد',
      email: 'user@example.com',
      phone: '+967777123456',
      avatarUrl: null,
      viewMode: ViewMode.lite,
      isPro: false,
      proLevel: 0,
      isVerified: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  /// تحديث الملف الشخصي
  Future<UserModel?> updateProfile({
    required String userId,
    String? fullName,
    String? email,
    String? phone,
    String? avatarUrl,
    ViewMode? viewMode,
  }) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(seconds: 1));

    return UserModel(
      id: userId,
      fullName: fullName ?? 'محمد أحمد',
      email: email ?? 'user@example.com',
      phone: phone ?? '+967777123456',
      avatarUrl: avatarUrl,
      viewMode: viewMode ?? ViewMode.lite,
      isPro: false,
      proLevel: 0,
      isVerified: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  /// تغيير كلمة المرور
  Future<bool> changePassword({
    required String userId,
    required String currentPassword,
    required String newPassword,
  }) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  /// إعادة تعيين كلمة المرور
  Future<bool> resetPassword(String email) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  /// ترقية إلى PRO
  Future<UserModel?> upgradeToPro({
    required String userId,
    required int level,
  }) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(seconds: 1));

    return UserModel(
      id: userId,
      fullName: 'محمد أحمد',
      email: 'user@example.com',
      phone: '+967777123456',
      avatarUrl: null,
      viewMode: ViewMode.pro,
      isPro: true,
      proLevel: level,
      isVerified: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  /// التحقق من البريد الإلكتروني
  Future<bool> verifyEmail(String token) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  /// التحقق من رقم الهاتف
  Future<bool> verifyPhone(String phone, String otp) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  /// حذف الحساب
  Future<bool> deleteAccount(String userId) async {
    // TODO: ربط مع API
    await Future.delayed(const Duration(seconds: 1));
    return true;
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
