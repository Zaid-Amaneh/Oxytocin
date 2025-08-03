# Profile Feature - واجهة الملف الشخصي

## نظرة عامة
تم تصميم واجهة الملف الشخصي بطريقة نظيفة واحترافية مع مراعاة أفضل الممارسات في Flutter و Clean Architecture.

## البنية
```
lib/features/profile/
├── data/
│   ├── datasources/
│   │   └── profile_data_source.dart
│   ├── model/
│   │   └── user_profile_model.dart
│   └── repositories/
│       └── profile_repository_impl.dart
├── domain/
│   └── usecases/
│       ├── get_user_profile_usecase.dart
│       ├── update_user_profile_usecase.dart
│       └── logout_usecase.dart
├── presentation/
│   ├── cubit/
│   │   ├── profile_cubit.dart
│   │   └── profile_state.dart
│   ├── view/
│   │   ├── profile_view.dart
│   │   └── profile_test_view.dart
│   └── widget/
│       ├── profile_header_card.dart
│       └── profile_menu_section.dart
└── di/
    └── profile_dependency_injection.dart
```

## المميزات

### 1. بطاقة رأس الملف الشخصي (ProfileHeaderCard)
- عرض صورة المستخدم مع تصميم دائري جميل
- عرض اسم المستخدم وعمره
- رسالة تحفيزية حول شرب الماء
- خلفية متدرجة مع نمط زخرفي

### 2. قائمة الخيارات (ProfileMenuSection)
- **حسابي**: إدارة معلومات الحساب
- **سجلاتي الطبية**: عرض السجلات الطبية
- **المفضلة**: الأطباء المفضلين
- **الإعدادات**: إعدادات التطبيق
- **تسجيل الخروج**: تسجيل الخروج من التطبيق

### 3. حالات التطبيق
- **تحميل**: عرض مؤشر تحميل جميل
- **خطأ**: عرض رسالة خطأ مع زر إعادة المحاولة
- **محمّل**: عرض البيانات بنجاح

## كيفية الاستخدام

### 1. إضافة ProfileCubit إلى التطبيق
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/features/profile/di/profile_dependency_injection.dart';

// في MaterialApp أو أي widget آخر
BlocProvider(
  create: (context) => ProfileDependencyInjection.getProfileCubit(),
  child: ProfileView(),
)
```

### 2. استخدام ProfileView مباشرة
```dart
import 'package:oxytocin/features/profile/presentation/view/profile_test_view.dart';

// في التطبيق
ProfileTestView()
```

### 3. التنقل إلى الواجهة
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const ProfileTestView(),
  ),
);
```

## التصميم

### الألوان المستخدمة
- **الأزرق الأساسي**: `AppColors.kPrimaryColor1` (#000957)
- **الأزرق الثانوي**: `AppColors.kPrimaryColor2` (#344CB7)
- **الخلفية**: `AppColors.background` (أبيض)
- **النص الأساسي**: `AppColors.textPrimary` (أسود)
- **النص الثانوي**: `AppColors.textSecondary` (#666666)
- **الخطأ**: `AppColors.error` (#FF4D4F)

### الخطوط المستخدمة
- **AlmaraiBold**: للعناوين الرئيسية
- **AlmaraiRegular**: للنصوص العادية
- **CairoExtraBold**: للعناوين الكبيرة

### التأثيرات البصرية
- **الظلال**: ظلال ناعمة للبطاقات
- **التحولات**: انتقالات سلسة بين الحالات
- **الرسوم المتحركة**: تأثيرات fade و slide
- **الزوايا المنحنية**: تصميم عصري مع زوايا دائرية

## الممارسات المتبعة

### 1. Clean Architecture
- فصل واضح بين الطبقات (Data, Domain, Presentation)
- استخدام Repository Pattern
- استخدام Use Cases للعمليات التجارية

### 2. State Management
- استخدام BLoC/Cubit لإدارة الحالة
- حالات واضحة ومحددة
- معالجة الأخطاء بشكل مناسب

### 3. Responsive Design
- استخدام SizeConfig للأحجام المتجاوبة
- تصميم يعمل على جميع أحجام الشاشات
- دعم الاتجاهات المختلفة (RTL/LTR)

### 4. Error Handling
- معالجة شاملة للأخطاء
- رسائل خطأ واضحة للمستخدم
- إمكانية إعادة المحاولة

## التخصيص

### تخصيص الألوان
يمكن تخصيص الألوان من خلال تعديل `lib/core/theme/app_colors.dart`

### تخصيص الخطوط
يمكن تخصيص الخطوط من خلال تعديل `lib/core/Utils/app_styles.dart`

### تخصيص الأحجام
يمكن تخصيص الأحجام من خلال تعديل `lib/core/Utils/size_config.dart`

## المساهمة
عند إضافة ميزات جديدة أو تعديل الواجهة، يرجى:
1. اتباع نفس نمط الكود الموجود
2. إضافة تعليقات توضيحية
3. اختبار الواجهة على أحجام شاشات مختلفة
4. التأكد من عمل التصميم مع الاتجاه RTL 