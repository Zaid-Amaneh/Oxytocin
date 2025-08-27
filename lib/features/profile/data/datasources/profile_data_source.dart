import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:oxytocin/core/Utils/services/url_container.dart';
import 'package:oxytocin/features/profile/data/model/user_profile_model.dart';
import 'package:oxytocin/core/Utils/services/secure_storage_service.dart';

abstract class ProfileDataSource {
  Future<UserProfileModel> getProfile();
  Future<UserProfileModel> updateProfile(UserProfileModel profile);
  Future<UserProfileModel> updateProfileFields(
    Map<String, dynamic> updatedFields,
  );
  Future<void> logout();
}

class ProfileDataSourceImpl implements ProfileDataSource {
  final SecureStorageService _secureStorageService;

  ProfileDataSourceImpl() : _secureStorageService = SecureStorageService();
  Future<String> _refreshAccessToken() async {
    final String? refreshToken = await _secureStorageService.getRefreshToken();

    if (refreshToken == null || refreshToken.isEmpty) {
      throw Exception('لا يوجد refresh token، يرجى تسجيل الدخول مرة أخرى');
    }

    final String refreshUrl = '${UrlContainer.domainUrl}/api/auth/refresh/';

    try {
      final response = await http.post(
        Uri.parse(refreshUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $refreshToken',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final newAccessToken = jsonData['access'];
        await _secureStorageService.saveAccessToken(newAccessToken);
        return newAccessToken;
      } else {
        throw Exception('انتهت الجلسة، يرجى تسجيل الدخول مرة أخرى');
      }
    } catch (e) {
      throw Exception('انتهت الجلسة، يرجى تسجيل الدخول مرة أخرى');
    }
  }

  Future<UserProfileModel> _updateProfileWithImage(
    Map<String, dynamic> updatedFields,
    String authToken,
    String url,
  ) async {
    var request = http.MultipartRequest('PATCH', Uri.parse(url));
    request.headers['Authorization'] = 'Bearer $authToken';

    // أضف الصورة كملف
    final imageFile = updatedFields['image'] as File;
    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        imageFile.path,
        filename: 'profile_image.jpg',
      ),
    );

    // أضف باقي الحقول (بما فيها الحقول المتداخلة مثل user)
    updatedFields.forEach((key, value) {
      if (key == 'image' || value == null) return;
      if (value is Map<String, dynamic>) {
        // أرسل الحقول المتداخلة كسلسلة JSON
        request.fields[key] = jsonEncode(value);
      } else if (value is String) {
        request.fields[key] = value;
      } else if (value is bool) {
        request.fields[key] = value.toString();
      } else if (value is num) {
        request.fields[key] = value.toString();
      }
    });

    var response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(responseBody);
      return UserProfileModel.fromJson(jsonData);
    } else {
      throw Exception('فشل في تحديث الصورة: ${response.statusCode}');
    }
  }

  @override
  Future<UserProfileModel> getProfile() async {
    String? authToken = await _secureStorageService.getAccessToken();

    if (authToken == null || authToken.isEmpty) {
      throw Exception('Token غير موجود، يرجى تسجيل الدخول مرة أخرى');
    }

    final String url = '${UrlContainer.domainUrl}/api/patients/me/';

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 401) {
        final newAccessToken = await _refreshAccessToken();
        response = await http.get(
          Uri.parse(url),
          headers: {
            'Authorization': 'Bearer $newAccessToken',
            'Content-Type': 'application/json',
          },
        );
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
    String? authToken = await _secureStorageService.getAccessToken();

    if (authToken == null || authToken.isEmpty) {
      throw Exception('Token غير موجود، يرجى تسجيل الدخول مرة أخرى');
    }

    final String url = '${UrlContainer.domainUrl}/api/patients/me/';

    try {
      var response = await http.put(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(profile.toJson()),
      );
      if (response.statusCode == 401) {
        final newAccessToken = await _refreshAccessToken();
        response = await http.put(
          Uri.parse(url),
          headers: {
            'Authorization': 'Bearer $newAccessToken',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(profile.toJson()),
        );
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

  @override
  Future<UserProfileModel> updateProfileFields(
    Map<String, dynamic> updatedFields,
  ) async {
    String? authToken = await _secureStorageService.getAccessToken();

    if (authToken == null || authToken.isEmpty) {
      throw Exception('Token غير موجود، يرجى تسجيل الدخول مرة أخرى');
    }

    final String url = '${UrlContainer.domainUrl}/api/patients/me/';

    if (updatedFields.containsKey('image') && updatedFields['image'] is File) {
      return await _updateProfileWithImage(updatedFields, authToken, url);
    }
    try {
      final fieldsToSend = Map<String, dynamic>.from(updatedFields);
      fieldsToSend.remove('image');
      var response = await http.patch(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(fieldsToSend),
      );
      if (response.statusCode == 401) {
        final newAccessToken = await _refreshAccessToken();
        response = await http.patch(
          Uri.parse(url),
          headers: {
            'Authorization': 'Bearer $newAccessToken',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(fieldsToSend),
        );
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        final updatedProfile = UserProfileModel.fromJson(jsonData);
        return updatedProfile;
      } else {
        throw Exception(
          'فشل في تحديث البيانات: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('فشل في تحديث البيانات: $e');
    }
  }

  @override
  Future<void> logout() async {
    String? authToken = await _secureStorageService.getAccessToken();

    await _secureStorageService.deleteAll();

    await Future.delayed(const Duration(milliseconds: 500));

    String? tokenAfterClearing = await _secureStorageService.getAccessToken();

    if (authToken != null && authToken.isNotEmpty) {
      final String url = '${UrlContainer.domainUrl}/api/users/';
      try {
        var response = await http.delete(
          Uri.parse(url),
          headers: {
            'Authorization': 'Bearer $authToken',
            'Content-Type': 'application/json',
          },
        );
        if (response.statusCode == 401) {
          try {
            final newAccessToken = await _refreshAccessToken();
            response = await http.delete(
              Uri.parse(url),
              headers: {
                'Authorization': 'Bearer $newAccessToken',
                'Content-Type': 'application/json',
              },
            );
          } catch (refreshError) {}
        }

        if (response.statusCode == 200 || response.statusCode == 204) {
        } else {}
      } catch (e) {}
    } else {}
  }
}
