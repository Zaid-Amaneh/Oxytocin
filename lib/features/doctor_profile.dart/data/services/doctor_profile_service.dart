import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:oxytocin/core/Utils/services/secure_storage_service.dart';
import 'package:oxytocin/core/constants/api_endpoints.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/features/doctor_profile.dart/data/models/appointment_date_model.dart';
import 'package:oxytocin/features/doctor_profile.dart/data/models/clinic_image.dart';
import 'package:oxytocin/features/doctor_profile.dart/data/models/paginated_evaluations_response.dart';
import '../models/doctor_profile_model.dart';

class DoctorProfileService {
  final SecureStorageService secureStorageService = SecureStorageService();
  final Logger _logger = Logger();
  Future<DoctorProfileModel> fetchDoctorProfile({required int doctorId}) async {
    final uri = Uri.parse('${ApiEndpoints.doctorProfile}$doctorId/');
    String? accessToken = await secureStorageService.getAccessToken();
    final headers = {
      'Accept': 'application/json',
      if (accessToken != null) 'Authorization': 'Bearer $accessToken',
    };
    try {
      final response = await http.get(uri, headers: headers);
      _logger.t(
        "Initial Doctor Profile response: ${response.statusCode}, Body: ${response.body}",
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return DoctorProfileModel.fromJson(data);
      } else if (response.statusCode == 401 && accessToken != null) {
        _logger.i("Access token expired. Attempting to refresh...");
        return await _refreshTokenAndRetryFetch(doctorId: doctorId);
      } else {
        throw const ServerFailure();
      }
    } catch (e) {
      if (e is Failure) rethrow;
      _logger.e(
        "Network failure while fetching doctor profile: ${e.toString()}",
      );
      throw const NetworkFailure();
    }
  }

  Future<DoctorProfileModel> _refreshTokenAndRetryFetch({
    required int doctorId,
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
      final newRefreshToken = newTokens['refresh'];

      await secureStorageService.saveAccessToken(newAccessToken);
      await secureStorageService.saveRefreshToken(newRefreshToken);

      _logger.i(
        "Retrying the original fetch doctor profile request with new token",
      );

      final originalUri = Uri.parse('${ApiEndpoints.doctorProfile}$doctorId/');
      final retryHeaders = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $newAccessToken',
      };

      final retryResponse = await http.get(originalUri, headers: retryHeaders);

      if (retryResponse.statusCode == 200) {
        _logger.i("Successfully fetched doctor profile after token refresh.");
        final data = jsonDecode(retryResponse.body);
        return DoctorProfileModel.fromJson(data);
      } else {
        throw const ServerFailure();
      }
    } else {
      _logger.e("Refresh token is invalid or expired. Deleting tokens.");
      await secureStorageService.deleteAll();
      throw const AuthenticationFailure();
    }
  }

  Future<List<ClinicImage>> fetchClinicImages(int clinicId) async {
    final url = Uri.parse(
      '${ApiEndpoints.baseURL}/api/doctors/clinics/$clinicId/images/',
    );
    final response = await http.get(url);
    Logger().f('Clinic Images Response: ${response.body}');
    Logger().f('Clinic Images Status Code: ${response.statusCode}');

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => ClinicImage.fromJson(json)).toList();
    } else {
      throw Exception(
        'Failed to load clinic images. Status code: ${response.statusCode}',
      );
    }
  }

  Future<PaginatedEvaluationsResponse> fetchClinicEvaluations({
    required int clinicId,
    int page = 1,
  }) async {
    final url = Uri.parse(
      '${ApiEndpoints.evaluations}?clinic_id=$clinicId&page=$page&page_size=10',
    );
    final response = await http.get(url);
    Logger().f('Evaluations Response: ${response.body}');
    Logger().f('Evaluations Status Code: ${response.statusCode}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return PaginatedEvaluationsResponse.fromJson(data);
    } else {
      throw Exception(
        'Failed to load evaluations. Status code: ${response.statusCode}',
      );
    }
  }

  Future<List<AppointmentDate>> fetchAppointmentDates({
    required int clinicId,
    required String startDate,
    required String endDate,
  }) async {
    final uri = Uri.parse(
      '${ApiEndpoints.appointmentDate}$clinicId/dates-with-visit-times/',
    ).replace(queryParameters: {"start-date": startDate, "end-date": endDate});
    final headers = {'Accept': 'application/json'};

    try {
      final response = await http.get(uri, headers: headers);
      _logger.t(
        "Appointments response: ${response.statusCode}, Body: ${response.body}",
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => AppointmentDate.fromJson(json)).toList();
      } else {
        throw const ServerFailure();
      }
    } catch (e) {
      if (e is Failure) rethrow;
      _logger.e("Network failure while fetching appointments: ${e.toString()}");
      throw const NetworkFailure();
    }
  }

  Future<Map<String, dynamic>> fetchAllDoctorData({
    required int clinicId,
    required String startDate,
    required String endDate,
  }) async {
    try {
      final results = await Future.wait([
        fetchDoctorProfile(doctorId: clinicId),
        fetchClinicImages(clinicId),
        fetchClinicEvaluations(clinicId: clinicId),
        fetchAppointmentDates(
          clinicId: clinicId,
          startDate: startDate,
          endDate: endDate,
        ),
      ]);

      return {
        'doctorProfile': results[0] as DoctorProfileModel,
        'clinicImages': results[1] as List<ClinicImage>,
        'evaluations': results[2] as PaginatedEvaluationsResponse,
        'appointmentDates': results[3] as List<AppointmentDate>,
      };
    } catch (e) {
      rethrow;
    }
  }
}
