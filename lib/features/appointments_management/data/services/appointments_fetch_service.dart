import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:oxytocin/core/constants/api_endpoints.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/core/Utils/services/secure_storage_service.dart';
import 'package:oxytocin/features/appointments_management/data/models/appointments_response_model.dart';

class AppointmentsFetchService {
  final http.Client client;
  final SecureStorageService secureStorageService = SecureStorageService();
  final Logger _logger = Logger();

  AppointmentsFetchService(this.client);

  Future<AppointmentsResponseModel> getAppointments({
    required String status,
    int page = 1,
    int pageSize = 10,
  }) async {
    final Map<String, String> queryParams = {
      'status': status,
      'page': page.toString(),
      'page_size': pageSize.toString(),
    };

    final uri = Uri.parse(
      ApiEndpoints.appointments,
    ).replace(queryParameters: queryParams);

    String? accessToken = await secureStorageService.getAccessToken();
    _logger.f(accessToken);
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
        "Initial Get Appointments response: ${response.statusCode}, URL: $uri, Body: ${response.body}",
      );

      if (response.statusCode == 200) {
        _logger.i("Appointments fetched successfully for status: $status.");
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        return AppointmentsResponseModel.fromJson(data);
      } else if (response.statusCode == 401) {
        _logger.w("Access token expired. Attempting to refresh...");
        return await _refreshTokenAndRetryGetAppointments(
          status: status,
          page: page,
          pageSize: pageSize,
        );
      } else {
        _logger.e(
          "Server error while fetching appointments: ${response.statusCode}",
        );
        throw const ServerFailure();
      }
    } catch (e) {
      if (e is Failure) rethrow;
      _logger.e("Network failure while fetching appointments: ${e.toString()}");
      throw const NetworkFailure();
    }
  }

  Future<AppointmentsResponseModel> _refreshTokenAndRetryGetAppointments({
    required String status,
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

      _logger.i(
        "Retrying the original get appointments request with new token",
      );

      final Map<String, String> queryParams = {
        'status': status,
        'page': page.toString(),
        'page_size': pageSize.toString(),
      };
      final originalUri = Uri.parse(
        ApiEndpoints.appointments,
      ).replace(queryParameters: queryParams);

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
        _logger.i("Successfully fetched appointments after token refresh.");
        final data = jsonDecode(utf8.decode(retryResponse.bodyBytes));
        return AppointmentsResponseModel.fromJson(data);
      } else {
        _logger.e(
          "Failed to fetch appointments even after token refresh: ${retryResponse.statusCode}",
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
