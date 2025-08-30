import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:oxytocin/core/constants/api_endpoints.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/core/Utils/services/secure_storage_service.dart';
import 'package:oxytocin/features/manage_medical_records/data/models/specialty_access_model.dart';

class SpecialtyAccessService {
  final http.Client client;
  final SecureStorageService secureStorageService = SecureStorageService();
  final Logger _logger = Logger();

  SpecialtyAccessService(this.client);

  Future<List<SpecialtyAccess>> getSpecialtyAccessList() async {
    final uri = Uri.parse(
      '${ApiEndpoints.baseURL}/api/patients/specialties/access/',
    );

    String? accessToken = await secureStorageService.getAccessToken();
    if (accessToken == null) {
      _logger.e("No access token found. User needs to login.");
      throw const AuthenticationFailure();
    }

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    try {
      final response = await client.get(uri, headers: headers);
      _logger.t(
        "Initial Get Specialty Access List response: ${response.statusCode}, Body: ${response.body}",
      );

      if (response.statusCode == 200) {
        _logger.i("Specialty access list fetched successfully.");
        final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

        return data.map((json) => SpecialtyAccess.fromJson(json)).toList();
      } else if (response.statusCode == 401) {
        _logger.w("Access token expired. Attempting to refresh...");
        return await _refreshTokenAndRetry();
      } else {
        _logger.e(
          "Server error while fetching specialty access list: ${response.statusCode}, Body: ${response.body}",
        );
        throw const ServerFailure();
      }
    } catch (e) {
      if (e is Failure) rethrow;
      _logger.e(
        "Network failure while fetching specialty access list: ${e.toString()}",
      );
      throw const NetworkFailure();
    }
  }

  Future<List<SpecialtyAccess>> _refreshTokenAndRetry() async {
    final refreshToken = await secureStorageService.getRefreshToken();
    if (refreshToken == null) {
      _logger.e("No refresh token found. Deleting all tokens.");
      throw const AuthenticationFailure();
    }

    final refreshUri = Uri.parse(ApiEndpoints.refreshToken);
    final refreshResponse = await client.post(
      refreshUri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refresh': refreshToken}),
    );

    if (refreshResponse.statusCode == 200) {
      _logger.i("Token refreshed successfully.");
      final newTokens = jsonDecode(refreshResponse.body);
      final newAccessToken = newTokens['access'];

      await secureStorageService.saveAccessToken(newAccessToken);
      if (newTokens.containsKey('refresh')) {
        await secureStorageService.saveRefreshToken(newTokens['refresh']);
      }

      _logger.i("Retrying the original request with new token");
      return await getSpecialtyAccessList();
    } else {
      _logger.e("Refresh token is invalid or expired. Deleting tokens.");
      await secureStorageService.deleteAll();
      throw const AuthenticationFailure();
    }
  }

  Future<SpecialtyAccess> updateSpecialtyVisibility({
    required int specialtyAccessId,
    required String visibility,
  }) async {
    final uri = Uri.parse(
      '${ApiEndpoints.baseURL}/api/patients/specialties/access/$specialtyAccessId/',
    );

    String? accessToken = await secureStorageService.getAccessToken();
    if (accessToken == null) {
      _logger.e("No access token found for update. User needs to login.");
      throw const AuthenticationFailure();
    }

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final body = jsonEncode({'visibility': visibility});

    try {
      final response = await client.put(uri, headers: headers, body: body);
      _logger.t(
        "Update Specialty Visibility response: ${response.statusCode}, Body: ${response.body}",
      );

      if (response.statusCode == 200) {
        _logger.i(
          "Specialty visibility updated successfully for ID: $specialtyAccessId",
        );
        return SpecialtyAccess.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)),
        );
      } else if (response.statusCode == 401) {
        _logger.w(
          "Access token expired. Attempting to refresh and retry update...",
        );
        return await _refreshTokenAndRetryUpdate(
          specialtyAccessId: specialtyAccessId,
          visibility: visibility,
        );
      } else {
        _logger.e(
          "Server error while updating specialty visibility: ${response.statusCode}, Body: ${response.body}",
        );
        throw const ServerFailure();
      }
    } catch (e) {
      if (e is Failure) rethrow;
      _logger.e(
        "Network failure while updating specialty visibility: ${e.toString()}",
      );
      throw const NetworkFailure();
    }
  }

  Future<SpecialtyAccess> _refreshTokenAndRetryUpdate({
    required int specialtyAccessId,
    required String visibility,
  }) async {
    final refreshToken = await secureStorageService.getRefreshToken();
    if (refreshToken == null) {
      _logger.e("No refresh token found. Deleting all tokens.");
      throw const AuthenticationFailure();
    }

    final refreshUri = Uri.parse(ApiEndpoints.refreshToken);
    final refreshResponse = await client.put(
      refreshUri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refresh': refreshToken}),
    );

    if (refreshResponse.statusCode == 200) {
      _logger.i("Token refreshed successfully.");
      final newTokens = jsonDecode(refreshResponse.body);
      await secureStorageService.saveAccessToken(newTokens['access']);
      if (newTokens.containsKey('refresh')) {
        await secureStorageService.saveRefreshToken(newTokens['refresh']);
      }

      _logger.i("Retrying the update request with new token");
      return await updateSpecialtyVisibility(
        specialtyAccessId: specialtyAccessId,
        visibility: visibility,
      );
    } else {
      _logger.e("Refresh token is invalid or expired. Deleting tokens.");
      await secureStorageService.deleteAll();
      throw const AuthenticationFailure();
    }
  }
}
