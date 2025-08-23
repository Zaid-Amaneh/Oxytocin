import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:oxytocin/core/Utils/services/i_secure_storage_service.dart';
import 'package:oxytocin/core/Utils/services/secure_storage_service.dart';
import 'dart:convert';
import 'package:oxytocin/core/Utils/services/url_container.dart';
import 'package:oxytocin/features/auth_complete/data/models/complete_register_model.dart';

class ProfileRemoteDataSource {
  final ISecureStorageService _secureStorageService = SecureStorageService();

  Future<bool> checkProfileExists() async {
    final String? authToken = await _secureStorageService.getAccessToken();
    final String url = '${UrlContainer.baseUrl}patients/profile/';

    try {
      if (authToken == null || authToken.isEmpty) {
        return false;
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return true;
      }
      if (response.statusCode == 404) {
        return false;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> uploadProfileImage(File imageFile) async {
    final String? authToken = await _secureStorageService.getAccessToken();
    final String url = '${UrlContainer.baseUrl}users/images/';
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers['Authorization'] = 'Bearer $authToken';

      request.files.add(
        await http.MultipartFile.fromPath('image', imageFile.path),
      );
      var response = await request.send();
      if (response.statusCode != 200 && response.statusCode != 201) {
        final errorBody = await response.stream.bytesToString();
        throw Exception(
          'فشل في رفع الصورة: ${response.statusCode} - $errorBody',
        );
      } else {
        final successBody = await response.stream.bytesToString();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> completeRegister(
    CompleteRegisterRequestModel requestModel,
  ) async {
    final String? authToken = await _secureStorageService.getAccessToken();
    final String? refreshToken = await _secureStorageService.getRefreshToken();

    final String url = '${UrlContainer.baseUrl}patients/complete-register/';
    try {
      if (authToken == null || authToken.isEmpty) {
        throw Exception('Token غير موجود، يرجى تسجيل الدخول مرة أخرى');
      }

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Refresh': 'Bearer $refreshToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestModel.toJson()),
      );
      if (response.statusCode == 401) {
        throw Exception('Token منتهي الصلاحية، يرجى تسجيل الدخول مرة أخرى');
      }
      if (response.statusCode == 400) {
        try {
          final errorData = jsonDecode(response.body);
          if (errorData is Map<String, dynamic>) {
            if (errorData.containsKey('non_field_errors')) {
              final errors = errorData['non_field_errors'] as List;
              if (errors.isNotEmpty &&
                  errors.first.toString().contains('ملف شخصي سابقا')) {
                return;
              }
            }
          }
        } catch (parseError) {}
      }

      if (response.statusCode != 201 && response.statusCode != 200) {
        try {
          final errorData = jsonDecode(response.body);
          if (errorData is Map<String, dynamic>) {
            String errorMessage = 'فشل في إرسال البيانات';

            if (errorData.containsKey('detail')) {
              errorMessage = errorData['detail'];
            } else if (errorData.containsKey('message')) {
              errorMessage = errorData['message'];
            } else if (errorData.containsKey('error')) {
              errorMessage = errorData['error'];
            } else if (errorData.containsKey('non_field_errors')) {
              final errors = errorData['non_field_errors'] as List;
              if (errors.isNotEmpty) {
                errorMessage = errors.first.toString();
              }
            }

            throw Exception(errorMessage);
          }
        } catch (parseError) {
          throw Exception('فشل في إرسال البيانات: ${response.statusCode}');
        }

        throw Exception('فشل في إرسال البيانات: ${response.statusCode}');
      }
    } catch (e) {
      throw e;
    }
  }
}
