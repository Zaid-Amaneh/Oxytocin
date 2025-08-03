import 'package:oxytocin/features/profile/data/datasources/profile_data_source.dart';
import 'package:oxytocin/features/profile/data/model/user_profile_model.dart';

abstract class ProfileRepository {
  Future<UserProfileModel> getUserProfile();
  Future<UserProfileModel> updateUserProfile(UserProfileModel profile);
  Future<void> logout();
}

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource _dataSource;

  ProfileRepositoryImpl(this._dataSource);

  @override
  Future<UserProfileModel> getUserProfile() async {
    try {
      return await _dataSource.getUserProfile();
    } catch (e) {
      throw Exception('فشل في جلب بيانات الملف الشخصي: $e');
    }
  }

  @override
  Future<UserProfileModel> updateUserProfile(UserProfileModel profile) async {
    try {
      return await _dataSource.updateUserProfile(profile);
    } catch (e) {
      throw Exception('فشل في تحديث الملف الشخصي: $e');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _dataSource.logout();
    } catch (e) {
      throw Exception('فشل في تسجيل الخروج: $e');
    }
  }
}
