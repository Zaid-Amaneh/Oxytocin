import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oxytocin/core/Utils/services/url_container.dart';
import 'package:oxytocin/features/profile/data/model/user_profile_model.dart';
import 'package:oxytocin/core/Utils/services/secure_storage_service.dart';

abstract class ProfileDataSource {
  Future<UserProfileModel> getProfile();
  Future<UserProfileModel> updateProfile(UserProfileModel profile);
}

class ProfileDataSourceImpl implements ProfileDataSource {
  final SecureStorageService _secureStorageService;

  ProfileDataSourceImpl() : _secureStorageService = SecureStorageService();

  @override
  Future<UserProfileModel> getProfile() async {
    final String? authToken = await _secureStorageService.getAccessToken();
    if (authToken == null || authToken.isEmpty) {
      throw Exception('Token غير موجود، يرجى تسجيل الدخول مرة أخرى');
    }
    final String url = '${UrlContainer.domainUrl}/api/patients/me/';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 401) {
        throw Exception('Token منتهي الصلاحية، يرجى تسجيل الدخول مرة أخرى');
      }

      if (response.statusCode != 200) {
        throw Exception('فشل في جلب البيانات: ${response.statusCode}');
      }
      final jsonData = jsonDecode(response.body);
      final userProfile = UserProfileModel.fromJson(jsonData);
      return userProfile;
    } catch (e) {
      throw Exception('فشل في جلب البيانات: $e');
    }
  }

  @override
  Future<UserProfileModel> updateProfile(UserProfileModel profile) async {
    final String? authToken = await _secureStorageService.getAccessToken();
    if (authToken == null || authToken.isEmpty) {
      throw Exception('Token غير موجود، يرجى تسجيل الدخول مرة أخرى');
    }
    final String url = '${UrlContainer.domainUrl}/api/patients/me/';

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(profile.toJson()),
      );
      if (response.statusCode == 401) {
        throw Exception('Token منتهي الصلاحية، يرجى تسجيل الدخول مرة أخرى');
      }

      if (response.statusCode != 200) {
        throw Exception('فشل في تحديث البيانات: ${response.statusCode}');
      }
      final jsonData = jsonDecode(response.body);
      final updatedProfile = UserProfileModel.fromJson(jsonData);
      return updatedProfile;
    } catch (e) {
      throw Exception('فشل في تحديث البيانات: $e');
    }
  }
}
