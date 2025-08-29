import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:oxytocin/core/constants/api_endpoints.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/core/Utils/services/secure_storage_service.dart';
import 'package:oxytocin/features/medical_records/data/models/patient_archives_doctor_response.dart';

class ArchivesService {
  final http.Client client;
  final SecureStorageService secureStorageService = SecureStorageService();
  final Logger _logger = Logger();

  ArchivesService(this.client);

  Future<PatientArchivesDoctorResponse> getPatientArchivesForDoctor({
    required int doctorId,
    int page = 1,
    int pageSize = 10,
  }) async {
    final uri =
        Uri.parse(
          '${ApiEndpoints.baseURL}/api/patients/archives/doctors/$doctorId/',
        ).replace(
          queryParameters: {
            'page': page.toString(),
            'page_size': pageSize.toString(),
          },
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
        "Initial Get Patient Archives response: ${response.statusCode}, Body: ${response.body}",
      );

      if (response.statusCode == 200) {
        _logger.i("Patient archives fetched successfully.");
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        return PatientArchivesDoctorResponse.fromJson(data);
      } else if (response.statusCode == 401) {
        _logger.w("Access token expired. Attempting to refresh...");
        return await _refreshTokenAndRetry(
          doctorId: doctorId,
          page: page,
          pageSize: pageSize,
        );
      } else {
        _logger.e(
          "Server error while fetching archives: ${response.statusCode}, Body: ${response.body}",
        );
        throw const ServerFailure();
      }
    } catch (e) {
      if (e is Failure) rethrow;
      _logger.e("Network failure while fetching archives: ${e.toString()}");
      throw const NetworkFailure();
    }
  }

  Future<PatientArchivesDoctorResponse> _refreshTokenAndRetry({
    required int doctorId,
    required int page,
    required int pageSize,
  }) async {
    final refreshToken = await secureStorageService.getRefreshToken();
    if (refreshToken == null) {
      _logger.e("No refresh token found. Deleting all tokens.");
      await secureStorageService.deleteAll();
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

      _logger.i("Retrying the original archives request with new token");

      final originalUri =
          Uri.parse(
            '${ApiEndpoints.baseURL}/api/patients/archives/doctors/$doctorId/',
          ).replace(
            queryParameters: {
              'page': page.toString(),
              'page_size': pageSize.toString(),
            },
          );

      final retryHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $newAccessToken',
      };

      final retryResponse = await client.get(
        originalUri,
        headers: retryHeaders,
      );

      if (retryResponse.statusCode == 200) {
        _logger.i("Successfully fetched archives after token refresh.");
        final data = jsonDecode(utf8.decode(retryResponse.bodyBytes));
        return PatientArchivesDoctorResponse.fromJson(data);
      } else {
        _logger.e(
          "Server error on retry: ${retryResponse.statusCode}, Body: ${retryResponse.body}",
        );
        throw const ServerFailure();
      }
    } else {
      _logger.e("Refresh token is invalid or expired. Deleting tokens.");
      await secureStorageService.deleteAll();
      throw const AuthenticationFailure();
    }
  }
}
