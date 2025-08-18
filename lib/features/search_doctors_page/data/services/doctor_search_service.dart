import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:oxytocin/core/constants/api_endpoints.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/core/Utils/services/secure_storage_service.dart';
import 'package:oxytocin/features/search_doctors_page/data/models/doctor_search_request.dart';
import 'package:oxytocin/features/search_doctors_page/data/models/search_doctors_response.dart';

class DoctorSearchService {
  final http.Client client;
  final SecureStorageService secureStorageService = SecureStorageService();

  DoctorSearchService(this.client);

  Future<SearchDoctorsResponse> searchDoctors(
    DoctorSearchRequest request,
  ) async {
    final uri = Uri.parse(
      ApiEndpoints.doctorSearch,
    ).replace(queryParameters: request.toQueryParams());

    final headers = {'Accept': 'application/json'};

    if (request.useCurrentLocation == true) {
      String? accessToken = await secureStorageService.getAccessToken();
      Logger().f(accessToken);
      headers['Authorization'] = 'Bearer $accessToken';
    }

    try {
      final response = await client.get(uri, headers: headers);
      Logger().t(
        "Initial response: ${response.statusCode}, Body: ${response.body}",
      );

      if (response.statusCode == 200) {
        return SearchDoctorsResponse.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401 &&
          request.useCurrentLocation == true) {
        Logger().i("Access token expired. Attempting to refresh...");
        return await _refreshTokenAndRetry(request);
      } else {
        throw const ServerFailure();
      }
    } catch (e) {
      if (e is Failure) rethrow;
      throw const NetworkFailure();
    }
  }

  Future<SearchDoctorsResponse> _refreshTokenAndRetry(
    DoctorSearchRequest originalRequest,
  ) async {
    final refreshToken = await secureStorageService.getRefreshToken();

    if (refreshToken == null) {
      throw const AuthenticationFailure();
    }

    final refreshUri = Uri.parse(ApiEndpoints.refreshToken);
    final refreshResponse = await client.post(
      refreshUri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refresh': refreshToken}),
    );

    if (refreshResponse.statusCode == 200) {
      Logger().i("Token refreshed successfully.");
      final newTokens = jsonDecode(refreshResponse.body);
      final newAccessToken = newTokens['access'];
      final newRefreshToken = newTokens['refresh'];
      await secureStorageService.saveAccessToken(newAccessToken);
      await secureStorageService.saveRefreshToken(newRefreshToken);

      Logger().i("Retrying the original request with new token");
      final originalUri = Uri.parse(
        ApiEndpoints.doctorSearch,
      ).replace(queryParameters: originalRequest.toQueryParams());
      final retryHeaders = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $newAccessToken',
      };

      final retryResponse = await client.get(
        originalUri,
        headers: retryHeaders,
      );

      if (retryResponse.statusCode == 200) {
        return SearchDoctorsResponse.fromJson(jsonDecode(retryResponse.body));
      } else {
        throw const ServerFailure();
      }
    } else {
      Logger().e("Refresh token is invalid or expired. Deleting tokens.");
      await secureStorageService.deleteAll();
      throw const AuthenticationFailure();
    }
  }
}
