// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'providers/providers.dart';
import 'services/services.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/wallet/wallet_screen.dart';
import 'screens/market/market_screen.dart';
import 'screens/orders/orders_screen.dart';
import 'screens/profile/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة الخدمات
  final localStorageService = LocalStorageService();
  await localStorageService.init();

  // تعيين اتجاه الشاشة
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // تعيين لون شريط الحالة
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // الخدمات
        Provider<LocalStorageService>(
          create: (_) => LocalStorageService(),
        ),
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        Provider<WalletService>(
          create: (_) => WalletService(),
        ),
        Provider<ProductService>(
          create: (_) => ProductService(),
        ),
        Provider<OrderService>(
          create: (_) => OrderService(),
        ),
        Provider<NotificationService>(
          create: (_) => NotificationService(),
        ),
        // الـ Providers
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(
            authService: context.read<AuthService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => WalletProvider(
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(
            productService: context.read<ProductService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProvider(
            orderService: context.read<OrderService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => NotificationProvider(
            notificationService: context.read<NotificationService>(),
          ),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'فليكس يمن',
            debugShowCheckedModeBanner: false,
            // الترجمة
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('ar', 'YE'),
              Locale('en', 'US'),
            ],
            locale: const Locale('ar', 'YE'),
            // السمة
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            // المسارات
            initialRoute: '/',
            routes: {
              '/': (context) => const SplashScreen(),
              '/login': (context) => const LoginScreen(),
              '/register': (context) => const RegisterScreen(),
              '/home': (context) => const HomeScreen(),
              '/wallet': (context) => const WalletScreen(),
              '/market': (context) => const MarketScreen(),
              '/orders': (context) => const OrdersScreen(),
              '/profile': (context) => const ProfileScreen(),
            },
            // بناء الصفحات
            builder: (context, child) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}
