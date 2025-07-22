import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:oxytocin/core/Utils/services/i_secure_storage_service.dart';
import 'package:oxytocin/core/Utils/services/secure_storage_service.dart';
import 'dart:convert';
import 'package:oxytocin/core/Utils/services/url_container.dart';
import 'package:oxytocin/features/profile/data/models/complete_register_model.dart';

class ProfileRemoteDataSource {
  final ISecureStorageService _secureStorageService = SecureStorageService();

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

    final String url = '${UrlContainer.baseUrl}patients/complete-register/';
    try {
      print('--- SENDING MEDICAL INFO TO BACKEND ---');
      print('POST URL: ' + url);
      print('POST BODY: ' + jsonEncode(requestModel.toJson()));
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestModel.toJson()),
      );
      print('--- RESPONSE FROM BACKEND ---');
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode != 201) {
        print(
          '[HTTP] Error: Failed to submit profile info, status code: ${response.statusCode}',
        );
        print('Error body: ${response.body}');
        return;
      }
      print('[HTTP] Registration completed successfully.');
    } catch (e) {
      print('[HTTP] Unexpected error: ${e.toString()}');
    }
  }
}
