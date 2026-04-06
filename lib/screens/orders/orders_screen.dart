import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('طلباتي'),
        backgroundColor: const Color(0xFFD4AF37),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt_long, size: 80, color: Color(0xFFD4AF37)),
            SizedBox(height: 16),
            Text('لا توجد طلبات حالية', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('سيتم عرض طلباتك هنا', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
