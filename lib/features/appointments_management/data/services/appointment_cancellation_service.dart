import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:oxytocin/core/constants/api_endpoints.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/core/Utils/services/secure_storage_service.dart';

class AppointmentCancellationService {
  final http.Client client;
  final SecureStorageService secureStorageService = SecureStorageService();
  final Logger _logger = Logger();

  AppointmentCancellationService(this.client);

  Future<void> cancelAppointment({required int appointmentId}) async {
    final uri = Uri.parse(
      '${ApiEndpoints.baseURL}/api/appointments/$appointmentId/cancel/',
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
      final response = await client.delete(uri, headers: headers);
      _logger.t(
        "Initial Cancel Appointment response: ${response.statusCode}, Body: ${response.body}",
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        _logger.i("Appointment cancelled successfully.");
        return;
      } else if (response.statusCode == 401) {
        _logger.w("Access token expired. Attempting to refresh...");
        return await _refreshTokenAndRetryCancel(appointmentId: appointmentId);
      } else {
        _logger.e(
          "Server error while cancelling appointment: ${response.statusCode} - ${response.body}",
        );
        throw const ServerFailure();
      }
    } catch (e) {
      if (e is Failure) rethrow;
      _logger.e(
        "Network failure while cancelling appointment: ${e.toString()}",
      );
      throw const NetworkFailure();
    }
  }

  Future<void> _refreshTokenAndRetryCancel({required int appointmentId}) async {
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

      _logger.i("Retrying the original cancel request with new token");

      final originalUri = Uri.parse(
        '${ApiEndpoints.baseURL}/api/appointments/$appointmentId/cancel/',
      );
      final retryHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $newAccessToken',
      };

      final retryResponse = await client.post(
        originalUri,
        headers: retryHeaders,
      );

      if (retryResponse.statusCode == 200 || retryResponse.statusCode == 204) {
        _logger.i("Successfully cancelled appointment after token refresh.");
        return;
      } else {
        throw const ServerFailure();
      }
    } else {
      _logger.e("Refresh token is invalid or expired. Deleting tokens.");
      await secureStorageService.deleteAll();
      throw const AuthenticationFailure();
    }
  }
}
