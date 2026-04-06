import 'package:flutter/material.dart';
import '../../theme/color_constants.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_text_field.dart';

class BillPaymentScreen extends StatefulWidget {
  const BillPaymentScreen({super.key});

  @override
  State<BillPaymentScreen> createState() => _BillPaymentScreenState();
}

class _BillPaymentScreenState extends State<BillPaymentScreen> {
  int _selectedBillType = 0;
  final _accountController = TextEditingController();
  
  final List<BillType> billTypes = [
    BillType(name: 'كهرباء', icon: Icons.flash_on, color: Colors.orange),
    BillType(name: 'ماء', icon: Icons.water_drop, color: Colors.blue),
    BillType(name: 'إنترنت', icon: Icons.wifi, color: Colors.purple),
    BillType(name: 'جوال', icon: Icons.phone_android, color: Colors.green),
    BillType(name: 'تلفزيون', icon: Icons.tv, color: Colors.red),
    BillType(name: 'غاز', icon: Icons.local_fire_department, color: Colors.brown),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[50],
      appBar: AppBar(
        title: const Text('دفع الفواتير'),
        backgroundColor: AppColors.goldColor,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // أنواع الفواتير
            const Text(
              'اختر نوع الفاتورة',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: billTypes.length,
                itemBuilder: (context, index) {
                  final bill = billTypes[index];
                  final isSelected = _selectedBillType == index;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedBillType = index),
                    child: Container(
                      width: 80,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? bill.color.withOpacity(0.2) : (isDark ? Colors.grey[800] : Colors.white),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? bill.color : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(bill.icon, color: bill.color, size: 32),
                          const SizedBox(height: 8),
                          Text(bill.name, style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            // رقم الحساب
            CustomTextField(
              controller: _accountController,
              label: 'رقم الحساب / المشترك',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            // المبلغ
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[800] : Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('المبلغ المستحق'),
                  Text(
                    '25,000 ر.ي',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.goldColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            GoldButton(
              text: 'دفع الفاتورة',
              onPressed: () {},
            ),
            const SizedBox(height: 16),
            // الفواتير السابقة
            const Text(
              'الفواتير السابقة',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildPreviousBills(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildPreviousBills() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.receipt, color: AppColors.goldColor),
          title: Text('فاتورة كهرباء - شهر ${index + 1}'),
          subtitle: const Text('تم الدفع'),
          trailing: const Text('25,000 ر.ي'),
          onTap: () {},
        );
      },
    );
  }
}

class BillType {
  final String name;
  final IconData icon;
  final Color color;
  BillType({required this.name, required this.icon, required this.color});
}
