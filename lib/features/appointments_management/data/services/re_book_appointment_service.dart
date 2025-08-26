import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:oxytocin/core/constants/api_endpoints.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/core/Utils/services/secure_storage_service.dart';
import 'package:oxytocin/features/book_appointment/data/models/book_appointment_request_model.dart';
import 'package:oxytocin/features/book_appointment/data/models/booked_appointment_model.dart';

class ReBookAppointmentService {
  final http.Client client;
  final SecureStorageService secureStorageService = SecureStorageService();
  final Logger _logger = Logger();

  ReBookAppointmentService(this.client);

  Future<BookedAppointmentModel> reBookAppointment({
    required int clinicId,
    required BookAppointmentRequestModel bookingData,
  }) async {
    final uri = Uri.parse(
      '${ApiEndpoints.baseURL}/api/appointments/$clinicId/update/',
    );

    String? accessToken = await secureStorageService.getAccessToken();
    if (accessToken == null) {
      _logger.e("No access token found. User needs to login.");
      throw const AuthenticationFailure();
    }
    _logger.f(accessToken);
    _logger.f(clinicId);
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    final body = jsonEncode(bookingData.toJson());

    try {
      final response = await client.put(uri, headers: headers, body: body);
      _logger.t(
        "Initial Book Appointment response: ${response.statusCode}, Body: ${response.body}",
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        _logger.i("Appointment booked successfully.");
        final data = jsonDecode(response.body);
        return BookedAppointmentModel.fromJson(data);
      } else if (response.statusCode == 401) {
        _logger.w("Access token expired. Attempting to refresh...");
        return await _refreshTokenAndRetry(
          clinicId: clinicId,
          bookingData: bookingData,
        );
      } else {
        final errorData = jsonDecode(response.body);
        final errorMessage = errorData['visit_time'][0] as String;
        Logger().e(errorMessage);
        if (errorMessage.contains('هذا الوقت محجوز من قبل مريض آخر')) {
          throw const AppointmentNotAvailableFailure();
        }
        throw const ServerFailure();
      }
    } catch (e) {
      if (e is Failure) rethrow;
      _logger.e("Network failure while booking appointment: ${e.toString()}");
      throw const NetworkFailure();
    }
  }

  Future<BookedAppointmentModel> _refreshTokenAndRetry({
    required int clinicId,
    required BookAppointmentRequestModel bookingData,
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

      _logger.i("Retrying the original booking request with new token");

      final originalUri = Uri.parse(
        '${ApiEndpoints.baseURL}/api/appointments/$clinicId/update/',
      );
      final retryHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $newAccessToken',
      };
      final retryBody = jsonEncode(bookingData.toJson());

      final retryResponse = await client.put(
        originalUri,
        headers: retryHeaders,
        body: retryBody,
      );

      if (retryResponse.statusCode == 201 || retryResponse.statusCode == 200) {
        _logger.i("Successfully Rebooked appointment after token refresh.");
        final data = jsonDecode(retryResponse.body);
        return BookedAppointmentModel.fromJson(data);
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
