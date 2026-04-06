import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/wallet_provider.dart';
import 'screens/wallet/wallet_screen.dart';
import 'theme/color_constants.dart';

void main() {
  runApp(const FlexYemenApp());
}

class FlexYemenApp extends StatelessWidget {
  const FlexYemenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WalletProvider()..loadWallet(),
      child: MaterialApp(
        title: 'Flex Yemen',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.goldColor,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.goldColor),
          fontFamily: 'Cairo',
        ),
        home: const WalletScreen(),
      ),
    );
  }
}
