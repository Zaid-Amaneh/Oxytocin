import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:oxytocin/core/constants/api_endpoints.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/core/Utils/services/secure_storage_service.dart';

class FavoritesService {
  final http.Client client;
  final SecureStorageService secureStorageService = SecureStorageService();
  final Logger _logger = Logger();

  FavoritesService(this.client);

  Future<void> addDoctorToFavorites({required int doctorId}) async {
    final uri = Uri.parse(ApiEndpoints.favorites);

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
    final body = jsonEncode({'doctor_id': doctorId});

    try {
      final response = await client.post(uri, headers: headers, body: body);
      _logger.t(
        "Initial Add to Favorite response: ${response.statusCode}, Body: ${response.body}",
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        _logger.i("Doctor added to favorites successfully.");
        return;
      } else if (response.statusCode == 401) {
        _logger.i("Access token expired. Attempting to refresh...");
        return await _refreshTokenAndRetry(doctorId: doctorId);
      } else {
        throw const ServerFailure();
      }
    } catch (e) {
      if (e is Failure) rethrow;
      _logger.e("Network failure while adding to favorites: ${e.toString()}");
      throw const NetworkFailure();
    }
  }

  Future<void> _refreshTokenAndRetry({required int doctorId}) async {
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
      final newRefreshToken = newTokens['refresh'];

      await secureStorageService.saveAccessToken(newAccessToken);
      await secureStorageService.saveRefreshToken(newRefreshToken);

      _logger.i("Retrying the original add to favorite request with new token");
      final originalUri = Uri.parse(ApiEndpoints.favorites);
      final retryHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $newAccessToken',
      };
      final retryBody = jsonEncode({'doctor_id': doctorId});

      final retryResponse = await client.post(
        originalUri,
        headers: retryHeaders,
        body: retryBody,
      );

      if (retryResponse.statusCode == 201 || retryResponse.statusCode == 200) {
        _logger.i(
          "Successfully added doctor to favorites after token refresh.",
        );
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

  Future<void> deleteDoctorFromFavorites({required int doctorId}) async {
    final uri = Uri.parse("${ApiEndpoints.favorites}$doctorId/");

    String? accessToken = await secureStorageService.getAccessToken();
    if (accessToken == null) {
      _logger.e("No access token found. User needs to login.");
      throw const AuthenticationFailure();
    }

    final headers = {'Authorization': 'Bearer $accessToken'};

    try {
      final response = await client.delete(uri, headers: headers);
      _logger.t(
        "Initial Delete Favorite response: ${response.statusCode}, Body: ${response.body}",
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        _logger.i("Doctor removed from favorites successfully.");
        return;
      } else if (response.statusCode == 401) {
        _logger.i("Access token expired. Attempting to refresh...");
        return await _refreshTokenAndRetryDelete(doctorId: doctorId);
      } else {
        throw const ServerFailure();
      }
    } catch (e) {
      if (e is Failure) rethrow;
      _logger.e(
        "Network failure while deleting from favorites: ${e.toString()}",
      );
      throw const NetworkFailure();
    }
  }

  Future<void> _refreshTokenAndRetryDelete({required int doctorId}) async {
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
      final newRefreshToken = newTokens['refresh'];

      await secureStorageService.saveAccessToken(newAccessToken);
      await secureStorageService.saveRefreshToken(newRefreshToken);

      _logger.i("Retrying the original delete favorite request with new token");
      final originalUri = Uri.parse("${ApiEndpoints.favorites}/$doctorId");
      final retryHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $newAccessToken',
      };

      final retryResponse = await client.delete(
        originalUri,
        headers: retryHeaders,
      );

      if (retryResponse.statusCode == 200 || retryResponse.statusCode == 204) {
        _logger.i(
          "Successfully deleted doctor from favorites after token refresh.",
        );
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
