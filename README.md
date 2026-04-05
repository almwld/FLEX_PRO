# فليكس يمن (Flex Yemen)

<div align="center">

![Flex Yemen Logo](assets/images/logo.png)

**تطبيق المحفظة الرقمية والتجارة الإلكترونية الشامل**

[![Flutter Version](https://img.shields.io/badge/Flutter-3.x-blue.svg)](https://flutter.dev)
[![Dart Version](https://img.shields.io/badge/Dart-3.x-blue.svg)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

</div>

---

## 📋 نظرة عامة

فليكس يمن هو تطبيق محفظة رقمية وتجارة إلكترونية متكامل مصمم خصيصاً للسوق اليمني. يوفر التطبيق مجموعة شاملة من الخدمات المالية والتجارية في منصة واحدة سهلة الاستخدام.

### ✨ المميزات الرئيسية

- 💳 **محفظة رقمية متكاملة**
  - إيداع وسحب الأموال
  - تحويل الأموال بين المستخدمين
  - دفع الفواتير (كهرباء، ماء، إنترنت، إلخ)
  - شراء واستبدال بطاقات الهدايا
  - سجل معاملات تفصيلي

- 🛒 **تجارة إلكترونية**
  - تصفح آلاف المنتجات
  - شراء من متاجر متعددة
  - سلة تسوق ذكية
  - تتبع الطلبات
  - نظام تقييمات ومراجعات

- 🎁 **نظام PRO**
  - ثلاثة مستويات (Lite, PRO, Expert)
  - مميزات حصرية لكل مستوى
  - خصومات خاصة
  - دعم فوري

- 🔐 **أمان متقدم**
  - مصادقة ثنائية
  - تأمين البصمة
  - تشفير البيانات
  - حماية ضد الاحتيال

- 🌍 **دعم كامل للغة العربية**
  - واجهة عربية بالكامل
  - دعم RTL
  - أرقام عربية وهندية

---

## 🚀 البدء

### المتطلبات

- Flutter 3.0 أو أحدث
- Dart 3.0 أو أحدث
- Android SDK 21+ (Android 5.0+)
- iOS 11.0+

### التثبيت

1. **استنساخ المستودع**
   ```bash
   git clone https://github.com/flexyemen/app.git
   cd flex_yemen
   ```

2. **تثبيت الاعتماديات**
   ```bash
   flutter pub get
   ```

3. **تشغيل التطبيق**
   ```bash
   flutter run
   ```

---

## 📁 هيكل المشروع

```
lib/
├── main.dart                    # نقطة الدخول الرئيسية
├── models/                      # نماذج البيانات
│   ├── user_model.dart
│   ├── wallet_model.dart
│   ├── product_model.dart
│   ├── order_model.dart
│   ├── category_model.dart
│   ├── market_model.dart
│   ├── notification_model.dart
│   ├── cart_model.dart
│   ├── address_model.dart
│   ├── review_model.dart
│   ├── coupon_model.dart
│   └── models.dart
├── providers/                   # إدارة الحالة
│   ├── auth_provider.dart
│   ├── wallet_provider.dart
│   ├── theme_provider.dart
│   ├── cart_provider.dart
│   ├── product_provider.dart
│   ├── order_provider.dart
│   ├── notification_provider.dart
│   └── providers.dart
├── services/                    # الخدمات
│   ├── local_storage_service.dart
│   ├── auth_service.dart
│   ├── wallet_service.dart
│   ├── product_service.dart
│   ├── order_service.dart
│   ├── notification_service.dart
│   └── services.dart
├── screens/                     # الشاشات
│   ├── splash_screen.dart
│   ├── auth/
│   │   ├── login_screen.dart
│   │   └── register_screen.dart
│   ├── home/
│   │   └── home_screen.dart
│   ├── wallet/
│   │   └── wallet_screen.dart
│   ├── market/
│   │   └── market_screen.dart
│   ├── orders/
│   │   └── orders_screen.dart
│   └── profile/
│       └── profile_screen.dart
├── widgets/                     # الويدجتس المشتركة
│   ├── custom_button.dart
│   ├── custom_text_field.dart
│   ├── product_card.dart
│   ├── order_list_item.dart
│   ├── transaction_list_item.dart
│   ├── loading_indicator.dart
│   ├── empty_state.dart
│   ├── error_state.dart
│   └── widgets.dart
├── theme/                       # السمات
│   └── app_theme.dart
└── utils/                       # الأدوات المساعدة
    ├── constants.dart
    ├── extensions.dart
    └── helpers.dart
```

---

## 🎨 السمات

التطبيق يدعم سمتين:

- **السمة الفاتحة**: مناسبة للاستخدام النهاري
- **السمة المظلمة**: مناسبة للاستخدام الليلي

اللون الذهبي (#D4AF37) هو اللون الرئيسي للتطبيق.

---

## 📱 الشاشات

### شاشات المصادقة
- شاشة البداية (Splash)
- تسجيل الدخول
- إنشاء حساب
- استعادة كلمة المرور
- تسجيل الدخول برقم الهاتف

### الشاشات الرئيسية
- الصفحة الرئيسية
- المحفظة
- السوق
- الطلبات
- الملف الشخصي

### شاشات المحفظة
- الرصيد والمعاملات
- إيداع
- سحب
- تحويل
- دفع الفواتير
- بطاقات الهدايا

---

## 🔧 التكوين

### Firebase
1. أنشئ مشروع في [Firebase Console](https://console.firebase.google.com/)
2. أضف تطبيق Android و iOS
3. حمل ملفات التكوين:
   - `google-services.json` (Android)
   - `GoogleService-Info.plist` (iOS)

### Stripe (المدفوعات)
1. أنشئ حساب في [Stripe](https://stripe.com/)
2. احصل على مفاتيح API
3. أضفها في ملف `.env`

---

## 📦 البناء

### Android
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

---

## 🤝 المساهمة

نرحب بمساهماتكم! يرجى اتباع الخطوات التالية:

1. انسخ المستودع (Fork)
2. أنشئ فرعاً جديداً (`git checkout -b feature/amazing-feature`)
3. ادفع التغييرات (`git commit -m 'Add amazing feature'`)
4. ادفع إلى الفرع (`git push origin feature/amazing-feature`)
5. افتح طلب سحب (Pull Request)

---

## 📄 الترخيص

هذا المشروع مرخص بموجب [MIT License](LICENSE).

---

## 📞 التواصل

- **البريد الإلكتروني**: support@flexyemen.com
- **الموقع الإلكتروني**: https://flexyemen.com
- **تويتر**: [@FlexYemen](https://twitter.com/FlexYemen)
- **فيسبوك**: [Flex Yemen](https://facebook.com/FlexYemen)

---

<div align="center">

**صنع بحب في اليمن** ❤️🇾🇪

</div>
