// lib/utils/extensions.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// امتدادات على String
extension StringExtensions on String {
  /// تحويل أول حرف إلى كبير
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// تحويل إلى عنوان (كل كلمة تبدأ بحرف كبير)
  String get toTitleCase {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  /// اختصار النص
  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$suffix';
  }

  /// إزالة المسافات الزائدة
  String get trimExtraSpaces {
    return replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  /// التحقق من صحة البريد الإلكتروني
  bool get isValidEmail {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }

  /// التحقق من صحة رقم الهاتف اليمني
  bool get isValidYemeniPhone {
    return RegExp(r'^\+967[7|1|3][0-9]{8}$').hasMatch(this);
  }

  /// إخفاء جزء من النص
  String mask({int start = 3, int end = 3, String mask = '*'}) {
    if (length <= start + end) return this;
    return '${substring(0, start)}${mask * (length - start - end)}${substring(length - end)}';
  }
}

/// امتدادات على DateTime
extension DateTimeExtensions on DateTime {
  /// تنسيق التاريخ
  String format([String pattern = 'yyyy-MM-dd']) {
    return DateFormat(pattern, 'ar').format(this);
  }

  /// تنسيق الوقت
  String get timeFormat {
    return DateFormat('hh:mm a', 'ar').format(this);
  }

  /// تنسيق تاريخ ووقت
  String get dateTimeFormat {
    return DateFormat('yyyy-MM-dd hh:mm a', 'ar').format(this);
  }

  /// منذ متى
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} سنة';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} شهر';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} يوم';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ساعة';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} دقيقة';
    } else {
      return 'الآن';
    }
  }

  /// هل هو اليوم
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// هل هو الأمس
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year && month == yesterday.month && day == yesterday.day;
  }

  /// بداية اليوم
  DateTime get startOfDay {
    return DateTime(year, month, day);
  }

  /// نهاية اليوم
  DateTime get endOfDay {
    return DateTime(year, month, day, 23, 59, 59);
  }
}

/// امتدادات على double
extension DoubleExtensions on double {
  /// تنسيق كعملة
  String toCurrency({String symbol = 'ر.ي', int decimalDigits = 0}) {
    final formatter = NumberFormat.currency(
      symbol: symbol,
      decimalDigits: decimalDigits,
      locale: 'ar',
    );
    return formatter.format(this);
  }

  /// تقريب إلى منزلتين عشريتين
  double get roundTo2Decimals {
    return double.parse(toStringAsFixed(2));
  }
}

/// امتدادات على int
extension IntExtensions on int {
  /// تنسيق كرقم
  String get formatNumber {
    final formatter = NumberFormat('#,###', 'ar');
    return formatter.format(this);
  }

 /// تحويل إلى مدة
  Duration get seconds => Duration(seconds: this);
  Duration get minutes => Duration(minutes: this);
  Duration get hours => Duration(hours: this);
  Duration get days => Duration(days: this);
}

/// امتدادات على BuildContext
extension BuildContextExtensions on BuildContext {
  /// السمة
  ThemeData get theme => Theme.of(this);

  /// السمة الملونة
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// حجم الشاشة
  Size get screenSize => MediaQuery.of(this).size;

  /// عرض الشاشة
  double get screenWidth => MediaQuery.of(this).size.width;

  /// ارتفاع الشاشة
  double get screenHeight => MediaQuery.of(this).size.height;

  /// الحافة العلوية
  double get topPadding => MediaQuery.of(this).padding.top;

  /// الحافة السفلية
  double get bottomPadding => MediaQuery.of(this).padding.bottom;

  /// هل الوضع المظلم
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// عرض SnackBar
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// إخفاء لوحة المفاتيح
  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }
}

/// امتدادات على List
extension ListExtensions<T> on List<T> {
  /// تقسيم القائمة
  List<List<T>> chunk(int size) {
    List<List<T>> chunks = [];
    for (var i = 0; i < length; i += size) {
      chunks.add(sublist(i, i + size > length ? length : i + size));
    }
    return chunks;
  }

  /// العنصر الأول أو null
  T? get firstOrNull => isEmpty ? null : first;

  /// العنصر الأخير أو null
  T? get lastOrNull => isEmpty ? null : last;
}

/// امتدادات على Widget
extension WidgetExtensions on Widget {
  /// إضافة هامش
  Widget padding(EdgeInsetsGeometry padding) {
    return Padding(padding: padding, child: this);
  }

  /// توسيط
  Widget get center => Center(child: this);

  /// توسيع
  Widget get expand => Expanded(child: this);

  /// مرن
  Widget flexible({int flex = 1}) => Flexible(flex: flex, child: this);

  /// إضافة إطار
  Widget border({
    Color? color,
    double width = 1,
    double radius = 0,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: color ?? Colors.grey, width: width),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: this,
    );
  }
}
