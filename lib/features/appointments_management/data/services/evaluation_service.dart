import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:oxytocin/core/constants/api_endpoints.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/core/Utils/services/secure_storage_service.dart';
import 'package:oxytocin/features/appointments_management/data/models/created_evaluation_model.dart';
import 'package:oxytocin/features/appointments_management/data/models/evaluation_request_model.dart';

class EvaluationService {
  final http.Client client;
  final SecureStorageService secureStorageService = SecureStorageService();
  final Logger _logger = Logger();

  EvaluationService(this.client);

  Future<CreatedEvaluationModel> submitEvaluation({
    required EvaluationRequestModel evaluationData,
  }) async {
    final uri = Uri.parse(ApiEndpoints.evaluations);

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
    final body = jsonEncode(evaluationData.toJson());

    try {
      final response = await client.post(uri, headers: headers, body: body);
      _logger.t(
        "Initial Submit Evaluation response: ${response.statusCode}, Body: ${response.body}",
      );

      if (response.statusCode == 201) {
        _logger.i("Evaluation submitted successfully.");
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        return CreatedEvaluationModel.fromJson(data);
      } else if (response.statusCode == 401) {
        _logger.w("Access token expired. Attempting to refresh...");
        return await _refreshTokenAndRetrySubmit(
          evaluationData: evaluationData,
        );
      } else {
        _logger.e(
          "Server error while submitting evaluation: ${response.statusCode} - ${response.body}",
        );
        throw const ServerFailure();
      }
    } catch (e) {
      if (e is Failure) rethrow;
      _logger.e("Network failure while submitting evaluation: ${e.toString()}");
      throw const NetworkFailure();
    }
  }

  Future<CreatedEvaluationModel> _refreshTokenAndRetrySubmit({
    required EvaluationRequestModel evaluationData,
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
        "Retrying the original submit evaluation request with new token",
      );

      final originalUri = Uri.parse(ApiEndpoints.evaluations);
      final retryHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $newAccessToken',
      };
      final retryBody = jsonEncode(evaluationData.toJson());

      final retryResponse = await client.post(
        originalUri,
        headers: retryHeaders,
        body: retryBody,
      );

      if (retryResponse.statusCode == 201) {
        _logger.i("Successfully submitted evaluation after token refresh.");
        final data = jsonDecode(utf8.decode(retryResponse.bodyBytes));
        return CreatedEvaluationModel.fromJson(data);
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
