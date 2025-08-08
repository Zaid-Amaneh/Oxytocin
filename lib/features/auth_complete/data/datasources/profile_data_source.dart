import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:oxytocin/core/Utils/services/i_secure_storage_service.dart';
import 'package:oxytocin/core/Utils/services/secure_storage_service.dart';
import 'dart:convert';
import 'package:oxytocin/core/Utils/services/url_container.dart';
import 'package:oxytocin/features/auth_complete/data/models/complete_register_model.dart';

class ProfileRemoteDataSource {
  final ISecureStorageService _secureStorageService = SecureStorageService();

  // دالة للتحقق من وجود الملف الشخصي
  Future<bool> checkProfileExists() async {
    final String? authToken = await _secureStorageService.getAccessToken();
    final String url = '${UrlContainer.baseUrl}patients/profile/';

    try {
      print('=== التحقق من وجود الملف الشخصي ===');
      print('URL: $url');

      if (authToken == null || authToken.isEmpty) {
        print('❌ خطأ: Token غير موجود');
        return false;
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      );

      print('Status code: ${response.statusCode}');

      // إذا كان الكود 200، فهذا يعني أن الملف الشخصي موجود
      if (response.statusCode == 200) {
        print('✅ الملف الشخصي موجود');
        return true;
      }

      // إذا كان الكود 404، فهذا يعني أن الملف الشخصي غير موجود
      if (response.statusCode == 404) {
        print('❌ الملف الشخصي غير موجود');
        return false;
      }

      print('❌ خطأ غير متوقع: ${response.statusCode}');
      return false;
    } catch (e) {
      print('❌ خطأ في التحقق من الملف الشخصي: $e');
      return false;
    }
  }

  Future<void> uploadProfileImage(File imageFile) async {
    final String? authToken = await _secureStorageService.getAccessToken();
    final String url = '${UrlContainer.baseUrl}patients/upload-profile-image/';

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers['Authorization'] = 'Bearer $authToken';

      request.files.add(
        await http.MultipartFile.fromPath('image', imageFile.path),
      );

      print('--- UPLOADING PROFILE IMAGE ---');
      print('POST URL: $url');
      print('Image Path: ${imageFile.path}');

      var response = await request.send();

      print('Status code: ${response.statusCode}');
      if (response.statusCode != 200 && response.statusCode != 201) {
        print('[HTTP] Error: Failed to upload image');
      } else {
        print('[HTTP] Image uploaded successfully.');
      }
    } catch (e) {
      print('[HTTP] Unexpected error: ${e.toString()}');
    }
  }

  Future<void> completeRegister(
    CompleteRegisterRequestModel requestModel,
  ) async {
    final String? authToken = await _secureStorageService.getAccessToken();
    final String? refreshToken = await _secureStorageService.getRefreshToken();

    final String url = '${UrlContainer.baseUrl}patients/complete-register/';
    try {
      print('=== إرسال البيانات للباك إند ===');
      print('URL: $url');
      print('Token: ${authToken != null ? "موجود" : "غير موجود"}');

      // فحص Token
      if (authToken == null || authToken.isEmpty) {
        print('❌ خطأ: Token غير موجود');
        throw Exception('Token غير موجود، يرجى تسجيل الدخول مرة أخرى');
      }

      print('Token: ${authToken.substring(0, 20)}...');

      print('--- البيانات المرسلة ---');
      print('الجنس: ${requestModel.user.gender}');
      print('تاريخ الميلاد: ${requestModel.user.birthDate}');
      print('المهنة: ${requestModel.job}');
      print('الموقع: ${requestModel.location}');
      print('خط الطول: ${requestModel.longitude}');
      print('خط العرض: ${requestModel.latitude}');
      print('زمرة الدم: ${requestModel.bloodType}');
      print('التاريخ الطبي: ${requestModel.medicalHistory}');
      print('التاريخ الجراحي: ${requestModel.surgicalHistory}');
      print('الحساسية: ${requestModel.allergies}');
      print('الأدوية: ${requestModel.medicines}');
      print('مدخن: ${requestModel.isSmoker}');
      print('شارب: ${requestModel.isDrinker}');
      print('متزوج: ${requestModel.isMarried}');
      print('--- JSON الكامل ---');
      print(jsonEncode(requestModel.toJson()));

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Refresh': 'Bearer $refreshToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestModel.toJson()),
      );

      print('=== استجابة الباك إند ===');
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 401) {
        print('❌ خطأ: Token منتهي الصلاحية');
        print('يجب تسجيل الدخول مرة أخرى');
        throw Exception('Token منتهي الصلاحية، يرجى تسجيل الدخول مرة أخرى');
      }

      // التعامل مع حالة وجود ملف شخصي مسبقاً
      if (response.statusCode == 400) {
        try {
          final errorData = jsonDecode(response.body);
          if (errorData is Map<String, dynamic>) {
            // التحقق من رسالة الخطأ
            if (errorData.containsKey('non_field_errors')) {
              final errors = errorData['non_field_errors'] as List;
              if (errors.isNotEmpty &&
                  errors.first.toString().contains('ملف شخصي سابقا')) {
                print(
                  '✅ الملف الشخصي موجود مسبقاً - سيتم الانتقال للصفحة الرئيسية',
                );
                // لا نعتبر هذا خطأ، بل نجاح في التحقق من وجود الملف
                return;
              }
            }
          }
        } catch (parseError) {
          print('❌ خطأ في تحليل رسالة الخطأ: $parseError');
        }
      }

      if (response.statusCode != 201 && response.statusCode != 200) {
        print(' فشل في إرسال البيانات');
        print('Error status: ${response.statusCode}');
        print('Error body: ${response.body}');
        try {
          final errorData = jsonDecode(response.body);
          if (errorData is Map<String, dynamic>) {
            String errorMessage = 'فشل في إرسال البيانات';

            // البحث عن رسالة الخطأ في البيانات المرجعة
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
          // إذا فشل في تحليل JSON، استخدم رسالة افتراضية
          throw Exception('فشل في إرسال البيانات: ${response.statusCode}');
        }

        throw Exception('فشل في إرسال البيانات: ${response.statusCode}');
      }
      print('✅ تم إرسال البيانات بنجاح!');
    } catch (e) {
      print('❌ خطأ غير متوقع: ${e.toString()}');
      throw e;
    }
  }
}
