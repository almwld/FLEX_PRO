// lib/utils/helpers.dart

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// أدوات مساعدة
class Helpers {
  /// توليد معرف عشوائي
  static String generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString() +
        Random().nextInt(9999).toString().padLeft(4, '0');
  }

  /// توليد رمز عشوائي
  static String generateCode(int length) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(random.nextInt(chars.length)),
      ),
    );
  }

  /// توليد OTP
  static String generateOTP(int length) {
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => '0123456789'.codeUnitAt(random.nextInt(10)),
      ),
    );
  }

  /// نسخ إلى الحافظة
  static Future<void> copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }

  /// قراءة من الحافظة
  static Future<String?> pasteFromClipboard() async {
    final data = await Clipboard.getData('text/plain');
    return data?.text;
  }

  /// التحقق من صحة البريد الإلكتروني
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  /// التحقق من صحة رقم الهاتف اليمني
  static bool isValidYemeniPhone(String phone) {
    return RegExp(r'^\+967[7|1|3][0-9]{8}$').hasMatch(phone);
  }

  /// تنسيق رقم الهاتف
  static String formatPhoneNumber(String phone) {
    if (phone.startsWith('+967')) {
      return phone;
    }
    if (phone.startsWith('00')) {
      return '+${phone.substring(2)}';
    }
    if (phone.startsWith('0')) {
      return '+967${phone.substring(1)}';
    }
    return '+967$phone';
  }

  /// إخفاء رقم الهاتف
  static String maskPhoneNumber(String phone) {
    if (phone.length < 8) return phone;
    return '${phone.substring(0, 4)}****${phone.substring(phone.length - 3)}';
  }

  /// إخفاء البريد الإلكتروني
  static String maskEmail(String email) {
    if (!email.contains('@')) return email;
    final parts = email.split('@');
    final local = parts[0];
    final domain = parts[1];
    if (local.length <= 2) return email;
    return '${local.substring(0, 2)}***@$domain';
  }

  /// تحويل الأرقام الإنجليزية إلى عربية
  static String toArabicNumbers(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    String result = input;
    for (int i = 0; i < english.length; i++) {
      result = result.replaceAll(english[i], arabic[i]);
    }
    return result;
  }

  /// تحويل الأرقام العربية إلى إنجليزية
  static String toEnglishNumbers(String input) {
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    String result = input;
    for (int i = 0; i < arabic.length; i++) {
      result = result.replaceAll(arabic[i], english[i]);
    }
    return result;
  }

  /// حساب نسبة الخصم
  static double calculateDiscountPercent(double originalPrice, double salePrice) {
    if (originalPrice <= 0) return 0;
    return ((originalPrice - salePrice) / originalPrice * 100).roundToDouble();
  }

  /// حساب السعر بعد الخصم
  static double calculateDiscountedPrice(double originalPrice, double discountPercent) {
    return originalPrice - (originalPrice * discountPercent / 100);
  }

  /// تنسيق حجم الملف
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  /// تنسيق المدة
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours}س ${minutes}د';
    } else if (minutes > 0) {
      return '${minutes}د ${seconds}ث';
    } else {
      return '${seconds}ث';
    }
  }

  /// إظهار حوار
  static Future<T?> showCustomDialog<T>({
    required BuildContext context,
    required Widget child,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: child,
      ),
    );
  }

  /// إظهار Bottom Sheet
  static Future<T?> showCustomBottomSheet<T>({
    required BuildContext context,
    required Widget child,
    bool isScrollControlled = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => child,
    );
  }

  /// انتظار
  static Future<void> delay(int milliseconds) async {
    await Future.delayed(Duration(milliseconds: milliseconds));
  }

  /// تسجيل في الكونسول
  static void log(dynamic message, {String tag = 'FlexYemen'}) {
    debugPrint('[$tag] $message');
  }
}

/// أدوات التحقق
class Validators {
  /// التحقق من الحقل المطلوب
  static String? required(String? value, {String fieldName = 'هذا الحقل'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName مطلوب';
    }
    return null;
  }

  /// التحقق من البريد الإلكتروني
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'البريد الإلكتروني مطلوب';
    }
    if (!Helpers.isValidEmail(value)) {
      return 'البريد الإلكتروني غير صحيح';
    }
    return null;
  }

  /// التحقق من رقم الهاتف
  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'رقم الهاتف مطلوب';
    }
    if (!Helpers.isValidYemeniPhone(value)) {
      return 'رقم الهاتف غير صحيح';
    }
    return null;
  }

  /// التحقق من كلمة المرور
  static String? password(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) {
      return 'كلمة المرور مطلوبة';
    }
    if (value.length < minLength) {
      return 'كلمة المرور يجب أن تكون $minLength أحرف على الأقل';
    }
    return null;
  }

  /// التحقق من تأكيد كلمة المرور
  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'تأكيد كلمة المرور مطلوب';
    }
    if (value != password) {
      return 'كلمتا المرور غير متطابقتين';
    }
    return null;
  }

  /// التحقق من الحد الأدنى للطول
  static String? minLength(String? value, int length, {String fieldName = 'هذا الحقل'}) {
    if (value == null || value.length < length) {
      return '$fieldName يجب أن يكون $length أحرف على الأقل';
    }
    return null;
  }

  /// التحقق من الحد الأقصى للطول
  static String? maxLength(String? value, int length, {String fieldName = 'هذا الحقل'}) {
    if (value != null && value.length > length) {
      return '$fieldName يجب أن لا يتجاوز $length حرف';
    }
    return null;
  }

  /// التحقق من الرقم
  static String? numeric(String? value, {String fieldName = 'هذا الحقل'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName مطلوب';
    }
    if (double.tryParse(value) == null) {
      return '$fieldName يجب أن يكون رقماً';
    }
    return null;
  }

  /// التحقق من النطاق
  static String? range(String? value, double min, double max, {String fieldName = 'هذا الحقل'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName مطلوب';
    }
    final number = double.tryParse(value);
    if (number == null) {
      return '$fieldName يجب أن يكون رقماً';
    }
    if (number < min || number > max) {
      return '$fieldName يجب أن يكون بين $min و $max';
    }
    return null;
  }
}
