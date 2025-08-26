import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:oxytocin/core/constants/api_endpoints.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/core/Utils/services/secure_storage_service.dart';

class RebookAppointmentService {
  final http.Client client;
  final SecureStorageService secureStorageService = SecureStorageService();
  final Logger _logger = Logger();

  RebookAppointmentService(this.client);

  Future<void> rebookAppointment({required int appointmentId}) async {
    final uri = Uri.parse(
      '${ApiEndpoints.baseURL}${ApiEndpoints.rebookAppointment(appointmentId)}',
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
      final response = await client.patch(uri, headers: headers);
      _logger.t(
        "Initial Rebook Appointment response: ${response.statusCode}, Body: ${response.body}",
      );

      if (response.statusCode == 200) {
        _logger.i("Appointment rebooked successfully for ID: $appointmentId.");
        return;
      } else if (response.statusCode == 401) {
        _logger.w("Access token expired. Attempting to refresh...");
        return await _refreshTokenAndRetryRebook(appointmentId: appointmentId);
      } else {
        _logger.e(
          "Server error while rebooking appointment: ${response.statusCode} - ${response.body}",
        );
        throw const ServerFailure();
      }
    } catch (e) {
      if (e is Failure) rethrow;
      _logger.e("Network failure while rebooking appointment: ${e.toString()}");
      throw const NetworkFailure();
    }
  }

  Future<void> _refreshTokenAndRetryRebook({required int appointmentId}) async {
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

      _logger.i("Retrying the original rebook request with new token");

      final originalUri = Uri.parse(
        '${ApiEndpoints.baseURL}${ApiEndpoints.rebookAppointment(appointmentId)}',
      );
      final retryHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $newAccessToken',
      };

      final retryResponse = await client.patch(
        originalUri,
        headers: retryHeaders,
      );

      if (retryResponse.statusCode == 200) {
        _logger.i("Successfully rebooked appointment after token refresh.");
        return;
      } else {
        _logger.e(
          "Failed to rebook appointment even after token refresh: ${retryResponse.statusCode} - ${retryResponse.body}",
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
