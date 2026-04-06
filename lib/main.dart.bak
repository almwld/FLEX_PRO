import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'providers/auth_provider.dart';
import 'providers/wallet_provider.dart';
import 'services/local_storage_service.dart';
import 'screens/wallet/wallet_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService.init();
  runApp(const FlexYemenApp());
}

class FlexYemenApp extends StatelessWidget {
  const FlexYemenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WalletProvider()..loadWallet(),
        ),
      ],
      child: MaterialApp(
        title: 'Flex Yemen',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          primaryColor: const Color(0xFFD4AF37),
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFD4AF37)),
        ),
        home: const WalletScreen(),
      ),
    );
  }
}
