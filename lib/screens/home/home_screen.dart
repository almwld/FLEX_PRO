import 'package:flutter/material.dart';
import '../../models/wallet_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('فلكس يمن'),
        backgroundColor: const Color(0xFFD4AF37),
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_balance_wallet, size: 80, color: Color(0xFFD4AF37)),
            SizedBox(height: 16),
            Text('مرحباً بك في فلكس يمن', style: TextStyle(fontSize: 24)),
            SizedBox(height: 8),
            Text('تطبيق المحفظة الرقمية والتجارة الإلكترونية', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
