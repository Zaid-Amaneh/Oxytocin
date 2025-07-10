import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:oxytocin/core/Utils/services/url_container.dart';
import 'package:oxytocin/features/profile/data/models/complete_register_model.dart';

class ProfileRemoteDataSource {
  Future<void> completeRegister(
    CompleteRegisterRequestModel requestModel,
  ) async {
    const String authToken = "YOUR_AUTH_TOKEN_HERE";
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
