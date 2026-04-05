import '../../models/user/user_model.dart';
import '../storage/local_storage_service.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();
  
  UserModel? _currentUser;
  String? _authToken;
  
  UserModel? get currentUser => _currentUser;
  String? get authToken => _authToken;
  bool get isLoggedIn => _currentUser != null;
  bool get isGuest => _currentUser?.isGuest ?? false;
  
  // تهيئة الخدمة
  Future<void> initialize() async {
    final userData = LocalStorageService.getUserData();
    if (userData != null) {
      _currentUser = UserModel.fromJson(userData);
    }
    _authToken = LocalStorageService.getAuthToken();
  }
  
  // تسجيل الدخول
  Future<AuthResult> login(String email, String password) async {
    try {
      // محاكاة طلب API
      await Future.delayed(const Duration(seconds: 1));
      
      // التحقق من البيانات (محاكاة)
      if (email.isEmpty || password.isEmpty) {
        return AuthResult.error('يرجى إدخال البريد الإلكتروني وكلمة المرور');
      }
      
      // إنشاء بيانات المستخدم (محاكاة)
      final userData = UserModel(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        fullName: 'أحمد محمد',
        email: email,
        phone: '777123456',
        avatarUrl: 'https://i.pravatar.cc/150?img=11',
        userType: 'customer',
        isVerified: true,
        createdAt: DateTime.now(),
      );
      
      final token = 'token_${DateTime.now().millisecondsSinceEpoch}';
      
      await _saveAuthData(userData, token);
      
      return AuthResult.success(userData);
    } catch (e) {
      return AuthResult.error('حدث خطأ أثناء تسجيل الدخول: $e');
    }
  }
  
  // تسجيل الدخول كضيف
  Future<AuthResult> loginAsGuest() async {
    try {
      final guestData = UserModel(
        id: 'guest_${DateTime.now().millisecondsSinceEpoch}',
        fullName: 'ضيف',
        email: 'guest@flexyemen.com',
        phone: '',
        userType: 'guest',
        isGuest: true,
        createdAt: DateTime.now(),
      );
      
      await _saveAuthData(guestData, null);
      
      return AuthResult.success(guestData);
    } catch (e) {
      return AuthResult.error('حدث خطأ: $e');
    }
  }
  
  // إنشاء حساب جديد
  Future<AuthResult> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    String? avatarUrl,
  }) async {
    try {
      // محاكاة طلب API
      await Future.delayed(const Duration(seconds: 1));
      
      // التحقق من البيانات
      if (fullName.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
        return AuthResult.error('يرجى ملء جميع الحقول المطلوبة');
      }
      
      if (password.length < 6) {
        return AuthResult.error('كلمة المرور يجب أن تكون 6 أحرف على الأقل');
      }
      
      // إنشاء بيانات المستخدم
      final userData = UserModel(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        fullName: fullName,
        email: email,
        phone: phone,
        avatarUrl: avatarUrl,
        userType: 'customer',
        isVerified: false,
        createdAt: DateTime.now(),
      );
      
      final token = 'token_${DateTime.now().millisecondsSinceEpoch}';
      
      await _saveAuthData(userData, token);
      
      return AuthResult.success(userData);
    } catch (e) {
      return AuthResult.error('حدث خطأ أثناء إنشاء الحساب: $e');
    }
  }
  
  // تسجيل الخروج
  Future<void> logout() async {
    _currentUser = null;
    _authToken = null;
    await LocalStorageService.clearUserData();
    await LocalStorageService.clearAuthToken();
  }
  
  // نسيت كلمة المرور
  Future<AuthResult> forgotPassword(String email) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      if (email.isEmpty) {
        return AuthResult.error('يرجى إدخال البريد الإلكتروني');
      }
      
      // محاكاة إرسال رابط إعادة تعيين
      return AuthResult.success(null, message: 'تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني');
    } catch (e) {
      return AuthResult.error('حدث خطأ: $e');
    }
  }
  
  // إعادة تعيين كلمة المرور
  Future<AuthResult> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      if (newPassword.length < 6) {
        return AuthResult.error('كلمة المرور يجب أن تكون 6 أحرف على الأقل');
      }
      
      return AuthResult.success(null, message: 'تم إعادة تعيين كلمة المرور بنجاح');
    } catch (e) {
      return AuthResult.error('حدث خطأ: $e');
    }
  }
  
  // تحديث بيانات المستخدم
  Future<AuthResult> updateUserData(Map<String, dynamic> data) async {
    try {
      if (_currentUser == null) {
        return AuthResult.error('المستخدم غير مسجل الدخول');
      }
      
      final updatedUser = _currentUser!.copyWith(
        fullName: data['full_name'],
        email: data['email'],
        phone: data['phone'],
        avatarUrl: data['avatar_url'],
        address: data['address'],
        city: data['city'],
        jobTitle: data['job_title'],
        companyName: data['company_name'],
      );
      
      await _saveAuthData(updatedUser, _authToken);
      
      return AuthResult.success(updatedUser);
    } catch (e) {
      return AuthResult.error('حدث خطأ: $e');
    }
  }
  
  // تغيير كلمة المرور
  Future<AuthResult> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      if (newPassword.length < 6) {
        return AuthResult.error('كلمة المرور الجديدة يجب أن تكون 6 أحرف على الأقل');
      }
      
      return AuthResult.success(null, message: 'تم تغيير كلمة المرور بنجاح');
    } catch (e) {
      return AuthResult.error('حدث خطأ: $e');
    }
  }
  
  // التحقق من رمز OTP
  Future<AuthResult> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      if (otp.length != 6) {
        return AuthResult.error('رمز التحقق يجب أن يكون 6 أرقام');
      }
      
      return AuthResult.success(null, message: 'تم التحقق بنجاح');
    } catch (e) {
      return AuthResult.error('حدث خطأ: $e');
    }
  }
  
  // إرسال رمز OTP
  Future<AuthResult> sendOtp(String phone) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      return AuthResult.success(null, message: 'تم إرسال رمز التحقق');
    } catch (e) {
      return AuthResult.error('حدث خطأ: $e');
    }
  }
  
  // التحقق من الهوية (KYC)
  Future<AuthResult> verifyIdentity({
    required String nationalId,
    required String nationality,
    required DateTime birthDate,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      
      if (_currentUser == null) {
        return AuthResult.error('المستخدم غير مسجل الدخول');
      }
      
      final updatedUser = _currentUser!.copyWith(
        nationalId: nationalId,
        nationality: nationality,
        birthDate: birthDate,
        isVerified: true,
      );
      
      await _saveAuthData(updatedUser, _authToken);
      
      return AuthResult.success(updatedUser, message: 'تم التحقق من الهوية بنجاح');
    } catch (e) {
      return AuthResult.error('حدث خطأ: $e');
    }
  }
  
  // حفظ بيانات المصادقة
  Future<void> _saveAuthData(UserModel user, String? token) async {
    _currentUser = user;
    _authToken = token;
    
    await LocalStorageService.saveUserData(user.toJson());
    if (token != null) {
      await LocalStorageService.saveAuthToken(token);
    }
  }
  
  // التحقق من صلاحية الرمز
  Future<bool> validateToken() async {
    if (_authToken == null) return false;
    
    try {
      // محاكاة التحقق من صلاحية الرمز
      await Future.delayed(const Duration(milliseconds: 500));
      return true;
    } catch (e) {
      return false;
    }
  }
  
  // تحديث الرمز
  Future<String?> refreshToken() async {
    try {
      if (_authToken == null) return null;
      
      // محاكاة تحديث الرمز
      await Future.delayed(const Duration(milliseconds: 500));
      
      final newToken = 'refreshed_token_${DateTime.now().millisecondsSinceEpoch}';
      _authToken = newToken;
      await LocalStorageService.saveAuthToken(newToken);
      
      return newToken;
    } catch (e) {
      return null;
    }
  }
}

class AuthResult {
  final bool success;
  final UserModel? user;
  final String? message;
  final String? error;
  
  AuthResult._({
    required this.success,
    this.user,
    this.message,
    this.error,
  });
  
  factory AuthResult.success(UserModel? user, {String? message}) {
    return AuthResult._(
      success: true,
      user: user,
      message: message,
    );
  }
  
  factory AuthResult.error(String error) {
    return AuthResult._(
      success: false,
      error: error,
    );
  }
}
