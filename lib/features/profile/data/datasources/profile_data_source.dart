import 'package:oxytocin/features/profile/data/model/user_profile_model.dart';

abstract class ProfileDataSource {
  Future<UserProfileModel> getUserProfile();
  Future<UserProfileModel> updateUserProfile(UserProfileModel profile);
  Future<void> logout();
}

class ProfileDataSourceImpl implements ProfileDataSource {
  @override
  Future<UserProfileModel> getUserProfile() async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Mock data - في التطبيق الحقيقي سيتم جلب البيانات من API
    return UserProfileModel(
      id: '1',
      name: 'طارق خليل',
      age: 30,
      profileImage: null, // سيتم استخدام صورة افتراضية
      email: 'tariq.khalil@example.com',
      phone: '+966501234567',
      address: 'الرياض، المملكة العربية السعودية',
      medicalHistory: 'لا توجد سجلات طبية سابقة',
      favorites: ['د. أحمد محمد', 'د. فاطمة علي'],
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    );
  }

  @override
  Future<UserProfileModel> updateUserProfile(UserProfileModel profile) async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 1000));

    // Mock update - في التطبيق الحقيقي سيتم إرسال البيانات إلى API
    return profile.copyWith(updatedAt: DateTime.now());
  }

  @override
  Future<void> logout() async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock logout - في التطبيق الحقيقي سيتم إرسال طلب تسجيل الخروج إلى API
    // وحذف البيانات المحلية
  }
}
