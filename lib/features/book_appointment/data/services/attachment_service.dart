import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:oxytocin/core/constants/api_endpoints.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/core/Utils/services/secure_storage_service.dart';
import 'package:oxytocin/features/book_appointment/data/models/upload_attachments_response_model.dart';

class AttachmentService {
  final SecureStorageService secureStorageService = SecureStorageService();
  final Logger _logger = Logger();
  AttachmentService();

  Future<UploadAttachmentsResponseModel> uploadAttachments({
    required int appointmentId,
    required List<String> filePaths,
  }) async {
    final uri = Uri.parse(
      '${ApiEndpoints.baseURL}/api/appointments/$appointmentId/upload-attachments/',
    );

    String? accessToken = await secureStorageService.getAccessToken();
    _logger.f(accessToken);
    if (accessToken == null) {
      _logger.e("No access token found. User needs to login.");
      throw const AuthenticationFailure();
    }

    try {
      var request = http.MultipartRequest('POST', uri);

      request.headers['Authorization'] = 'Bearer $accessToken';
      request.headers['Accept'] = 'application/json';

      for (String path in filePaths) {
        request.files.add(
          await http.MultipartFile.fromPath('attachments', path),
        );
      }

      var streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      _logger.t(
        "Initial Upload Attachments response: ${response.statusCode}, Body: ${response.body}",
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _logger.i("Attachments uploaded successfully.");
        return UploadAttachmentsResponseModel.fromJson(
          jsonDecode(response.body),
        );
      } else if (response.statusCode == 401) {
        _logger.w("Access token expired. Attempting to refresh...");
        return await _refreshTokenAndRetry(
          appointmentId: appointmentId,
          filePaths: filePaths,
        );
      } else if (response.statusCode == 400) {
        throw const InvalidUploadedFileFailure();
      } else {
        throw const ServerFailure();
      }
    } catch (e) {
      if (e is Failure) rethrow;
      _logger.e("Network failure while uploading attachments: ${e.toString()}");
      throw const NetworkFailure();
    }
  }

  Future<UploadAttachmentsResponseModel> _refreshTokenAndRetry({
    required int appointmentId,
    required List<String> filePaths,
  }) async {
    final refreshToken = await secureStorageService.getRefreshToken();
    if (refreshToken == null) {
      _logger.e("No refresh token found. Deleting all tokens.");
      await secureStorageService.deleteAll();
      throw const AuthenticationFailure();
    }

    final refreshUri = Uri.parse(ApiEndpoints.refreshToken);
    final refreshResponse = await http.post(
      refreshUri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refresh': refreshToken}),
    );

    if (refreshResponse.statusCode == 200) {
      _logger.i("Token refreshed successfully.");
      final newTokens = jsonDecode(refreshResponse.body);
      final newAccessToken = newTokens['access'];
      await secureStorageService.saveAccessToken(newAccessToken);

      _logger.i("Retrying the original upload request with new token");

      final uri = Uri.parse(
        '${ApiEndpoints.baseURL}/api/appointments/$appointmentId/upload-attachments/',
      );
      var request = http.MultipartRequest('POST', uri);

      request.headers['Authorization'] = 'Bearer $newAccessToken';
      request.headers['Accept'] = 'application/json';

      for (String path in filePaths) {
        request.files.add(
          await http.MultipartFile.fromPath('attachments', path),
        );
      }

      var streamedResponse = await request.send();
      final retryResponse = await http.Response.fromStream(streamedResponse);

      if (retryResponse.statusCode == 200 || retryResponse.statusCode == 201) {
        _logger.i("Successfully uploaded attachments after token refresh.");
        return UploadAttachmentsResponseModel.fromJson(
          jsonDecode(retryResponse.body),
        );
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
