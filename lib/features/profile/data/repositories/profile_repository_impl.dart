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

  Future<UserProfileModel> updateProfile(UserProfileModel profile) async {
    try {
      return await dataSource.updateProfile(profile);
    } catch (e) {
      throw Exception('فشل في التحديث: ${e.toString()}');
    }
  }
}
