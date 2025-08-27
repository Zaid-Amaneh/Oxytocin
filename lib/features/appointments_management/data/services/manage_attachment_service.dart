import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:oxytocin/core/Utils/services/secure_storage_service.dart';
import 'package:oxytocin/core/constants/api_endpoints.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/features/appointments_management/data/models/attachment_model.dart';
import 'package:oxytocin/features/book_appointment/data/models/upload_attachments_response_model.dart';

class ManageAttachmentService {
  final http.Client client;
  final SecureStorageService secureStorageService = SecureStorageService();
  final Logger _logger = Logger();

  ManageAttachmentService(this.client);

  Future<List<AttachmentModel>> getAttachments({
    required int appointmentId,
  }) async {
    final uri = Uri.parse(ApiEndpoints.getAttachments(appointmentId));

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
        "Initial Get Attachments response: ${response.statusCode}, Body: ${response.body}",
      );

      if (response.statusCode == 200) {
        _logger.i("Attachments fetched successfully.");
        final data = utf8.decode(response.bodyBytes);
        return attachmentModelFromJson(data);
      } else if (response.statusCode == 401) {
        _logger.w("Access token expired. Attempting to refresh...");
        return await _refreshTokenAndRetryGet(appointmentId: appointmentId);
      } else {
        _logger.e(
          "Server error while fetching attachments: ${response.statusCode} - ${response.body}",
        );
        throw const ServerFailure();
      }
    } catch (e) {
      if (e is Failure) rethrow;
      _logger.e("Network failure while fetching attachments: ${e.toString()}");
      throw const NetworkFailure();
    }
  }

  Future<void> deleteAttachment({
    required int appointmentId,
    required int attachmentId,
  }) async {
    final uri = Uri.parse(
      ApiEndpoints.deleteAttachment(appointmentId, attachmentId),
    );
    String? accessToken = await secureStorageService.getAccessToken();
    if (accessToken == null) {
      _logger.e("No access token found for delete operation.");
      throw const AuthenticationFailure();
    }

    final headers = {
      'Authorization': 'Bearer $accessToken',
      'Accept': 'application/json',
    };

    try {
      final response = await client.delete(uri, headers: headers);
      _logger.t("Initial Delete Attachment response: ${response.statusCode}");

      if (response.statusCode == 204) {
        _logger.i("Attachment deleted successfully.");
        return;
      } else if (response.statusCode == 401) {
        _logger.w("Access token expired. Attempting to refresh...");
        await _refreshTokenAndRetryDelete(
          appointmentId: appointmentId,
          attachmentId: attachmentId,
        );
      } else {
        _logger.e(
          "Server error while deleting attachment: ${response.statusCode}",
        );
        throw const ServerFailure();
      }
    } catch (e) {
      if (e is Failure) rethrow;
      _logger.e("Network failure while deleting attachment: ${e.toString()}");
      throw const NetworkFailure();
    }
  }

  Future<void> _refreshTokenAndRetryDelete({
    required int appointmentId,
    required int attachmentId,
  }) async {
    final newAccessToken = await _refreshAccessToken();
    final uri = Uri.parse(
      ApiEndpoints.deleteAttachment(appointmentId, attachmentId),
    );
    final retryHeaders = {
      'Authorization': 'Bearer $newAccessToken',
      'Accept': 'application/json',
    };

    final retryResponse = await client.delete(uri, headers: retryHeaders);

    if (retryResponse.statusCode == 204) {
      _logger.i("Successfully deleted attachment after token refresh.");
      return;
    } else {
      throw const ServerFailure();
    }
  }

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

  Future<List<AttachmentModel>> _refreshTokenAndRetryGet({
    required int appointmentId,
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

      _logger.i("Retrying the original get attachments request with new token");

      final originalUri = Uri.parse(ApiEndpoints.getAttachments(appointmentId));
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
        _logger.i("Successfully fetched attachments after token refresh.");
        final data = utf8.decode(retryResponse.bodyBytes);
        return attachmentModelFromJson(data);
      } else {
        _logger.e(
          "Failed to fetch attachments even after token refresh: ${retryResponse.statusCode}",
        );
        throw const ServerFailure();
      }
    } else {
      _logger.e("Refresh token is invalid or expired. Deleting tokens.");
      await secureStorageService.deleteAll();
      throw const AuthenticationFailure();
    }
  }

  Future<String> _refreshAccessToken() async {
    final refreshToken = await secureStorageService.getRefreshToken();
    if (refreshToken == null) {
      _logger.e("No refresh token found. Deleting all tokens.");
      await secureStorageService.deleteAll();
      throw const AuthenticationFailure();
    }

    final refreshUri = Uri.parse(ApiEndpoints.refreshToken);
    _logger.i("Attempting to refresh token at: $refreshUri");

    final response = await client.post(
      refreshUri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refresh': refreshToken}),
    );

    if (response.statusCode == 200) {
      _logger.i("Token refreshed successfully.");
      final newTokens = jsonDecode(response.body);

      final newAccessToken = newTokens['access'];
      await secureStorageService.saveAccessToken(newAccessToken);

      if (newTokens.containsKey('refresh')) {
        final newRefreshToken = newTokens['refresh'];
        await secureStorageService.saveRefreshToken(newRefreshToken);
        _logger.i("New refresh token was also provided and saved.");
      }

      return newAccessToken;
    } else {
      _logger.e(
        "Refresh token is invalid or expired. Status: ${response.statusCode}. Deleting tokens.",
      );
      await secureStorageService.deleteAll();
      throw const AuthenticationFailure();
    }
  }
}
