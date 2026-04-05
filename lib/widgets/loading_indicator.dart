// lib/widgets/loading_indicator.dart

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// مؤشر تحميل
class LoadingIndicator extends StatelessWidget {
  final String? message;
  final double size;

  const LoadingIndicator({
    super.key,
    this.message,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.goldPrimary),
              strokeWidth: 3,
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// مؤشر تحميل الصفحة الكاملة
class FullScreenLoading extends StatelessWidget {
  final String? message;

  const FullScreenLoading({
    super.key,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingIndicator(message: message),
    );
  }
}

/// شريط تحميل خطي
class LinearLoadingIndicator extends StatelessWidget {
  final double? value;

  const LinearLoadingIndicator({
    super.key,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: value,
      valueColor: AlwaysStoppedAnimation<Color>(AppColors.goldPrimary),
      backgroundColor: AppColors.goldPrimary.withOpacity(0.1),
    );
  }
}
