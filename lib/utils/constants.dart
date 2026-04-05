// lib/utils/constants.dart

/// ثوابت التطبيق
class AppConstants {
  // اسم التطبيق
  static const String appName = 'فليكس يمن';
  static const String appNameEn = 'Flex Yemen';

  // إصدار التطبيق
  static const String appVersion = '1.0.0';
  static const int appVersionCode = 1;

  // API
  static const String baseUrl = 'https://api.flexyemen.com/v1';
  static const int apiTimeout = 30000; // milliseconds

  // التخزين
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String cartKey = 'cart_data';
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language';

  // العملة
  static const String defaultCurrency = 'YER';
  static const String currencySymbol = 'ر.ي';

  // الترقيم
  static const int itemsPerPage = 20;
  static const int maxImageSize = 5 * 1024 * 1024; // 5 MB

  // الوقت
  static const int otpExpiryMinutes = 5;
  static const int sessionTimeoutMinutes = 30;

  // PRO
  static const List<Map<String, dynamic>> proLevels = [
    {
      'id': 0,
      'name': 'Lite',
      'nameAr': 'لايت',
      'monthlyFee': 0,
      'features': ['محفظة رقمية', 'تسوق إلكتروني', 'دعم عبر البريد'],
    },
    {
      'id': 1,
      'name': 'PRO',
      'nameAr': 'برو',
      'monthlyFee': 5000,
      'features': [
        'جميع مميزات Lite',
        'خصم 5% على المشتريات',
        'دعم فوري',
        'شحن مجاني',
      ],
    },
    {
      'id': 2,
      'name': 'Expert',
      'nameAr': 'خبير',
      'monthlyFee': 10000,
      'features': [
        'جميع مميزات PRO',
        'خصم 10% على المشتريات',
        'أولوية في الدعم',
        'شحن مجاني سريع',
        'وصول مبكر للعروض',
      ],
    },
  ];
}

/// مسارات التطبيق
class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String loginPhone = '/login-phone';
  static const String home = '/home';
  static const String wallet = '/wallet';
  static const String walletDeposit = '/wallet/deposit';
  static const String walletWithdraw = '/wallet/withdraw';
  static const String walletTransfer = '/wallet/transfer';
  static const String walletPay = '/wallet/pay';
  static const String walletBills = '/wallet/bills';
  static const String walletGiftCards = '/wallet/gift-cards';
  static const String walletTransactions = '/wallet/transactions';
  static const String walletTransactionDetails = '/wallet/transaction-details';
  static const String walletScan = '/wallet/scan';
  static const String walletSettings = '/wallet/settings';
  static const String market = '/market';
  static const String search = '/search';
  static const String productDetails = '/product-details';
  static const String productsFeatured = '/products/featured';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String orders = '/orders';
  static const String orderDetails = '/order-details';
  static const String profile = '/profile';
  static const String profileEdit = '/profile/edit';
  static const String profileAddresses = '/profile/addresses';
  static const String profilePaymentMethods = '/profile/payment-methods';
  static const String settings = '/settings';
  static const String settingsNotifications = '/settings/notifications';
  static const String settingsSecurity = '/settings/security';
  static const String settingsLanguage = '/settings/language';
  static const String notifications = '/notifications';
  static const String offers = '/offers';
  static const String services = '/services';
  static const String servicesRecharge = '/services/recharge';
  static const String servicesInternet = '/services/internet';
  static const String servicesTv = '/services/tv';
  static const String servicesElectricity = '/services/electricity';
  static const String servicesWater = '/services/water';
  static const String support = '/support';
  static const String about = '/about';
  static const String terms = '/terms';
  static const String privacy = '/privacy';
}

/// رسائل الخطأ
class ErrorMessages {
  static const String networkError = 'حدث خطأ في الاتصال. يرجى التحقق من الإنترنت';
  static const String serverError = 'حدث خطأ في الخادم. يرجى المحاولة لاحقاً';
  static const String unauthorized = 'جلسة غير صالحة. يرجى تسجيل الدخول مرة أخرى';
  static const String notFound = 'العنصر غير موجود';
  static const String validationError = 'يرجى التحقق من البيانات المدخلة';
  static const String unknownError = 'حدث خطأ غير متوقع';
  static const String timeoutError = 'انتهت مهلة الطلب';
}

/// رسائل النجاح
class SuccessMessages {
  static const String loginSuccess = 'تم تسجيل الدخول بنجاح';
  static const String registerSuccess = 'تم إنشاء الحساب بنجاح';
  static const String logoutSuccess = 'تم تسجيل الخروج بنجاح';
  static const String updateSuccess = 'تم التحديث بنجاح';
  static const String deleteSuccess = 'تم الحذف بنجاح';
  static const String orderSuccess = 'تم إنشاء الطلب بنجاح';
  static const String paymentSuccess = 'تم الدفع بنجاح';
  static const String transferSuccess = 'تم التحويل بنجاح';
}
