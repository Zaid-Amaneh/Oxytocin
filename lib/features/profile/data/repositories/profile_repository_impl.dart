import 'package:oxytocin/features/profile/data/datasources/profile_data_source.dart';
import 'package:oxytocin/features/profile/data/model/user_profile_model.dart';

class ProfileRepository {
  final ProfileDataSource dataSource;

  ProfileRepository(this.dataSource);

  Future<UserProfileModel> getProfile() async {
    try {
      return await dataSource.getProfile();
    } catch (e) {
      throw Exception('فشل في جلب البيانات: ${e.toString()}');
    }
  }

  Future<UserProfileModel> updateProfile(
    Map<String, dynamic> updatedFields,
  ) async {
    try {
      return await dataSource.updateProfileFields(updatedFields);
    } catch (e) {
      throw Exception('فشل في التحديث: ${e.toString()}');
    }
  }

  Future<void> logout() async {
    try {
      await dataSource.logout();
    } catch (e) {}
  }
}
