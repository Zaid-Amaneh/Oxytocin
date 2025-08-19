import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:oxytocin/core/constants/api_endpoints.dart';
import 'package:oxytocin/features/doctor_profile.dart/data/models/clinic_image.dart';
import 'package:oxytocin/features/doctor_profile.dart/data/models/paginated_evaluations_response.dart';
import '../models/doctor_profile_model.dart';

class DoctorProfileService {
  Future<DoctorProfileModel> fetchDoctorProfile(int doctorId) async {
    final url = Uri.parse('${ApiEndpoints.doctorProfile}$doctorId/');
    final response = await http.get(url);
    Logger().f(response.body);
    Logger().f(response.statusCode);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return DoctorProfileModel.fromJson(data);
    } else {
      throw Exception(
        'Failed to load doctor profile. Status code: ${response.statusCode}',
      );
    }
  }

  Future<List<ClinicImage>> fetchClinicImages(int clinicId) async {
    final url = Uri.parse(
      '${ApiEndpoints.baseURL}/api/doctors/clinics/$clinicId/images',
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

  Future<Map<String, dynamic>> fetchAllDoctorData(int clinicId) async {
    try {
      final results = await Future.wait([
        fetchDoctorProfile(clinicId),
        fetchClinicImages(clinicId),
        fetchClinicEvaluations(clinicId: clinicId),
      ]);

      return {
        'doctorProfile': results[0] as DoctorProfileModel,
        'clinicImages': results[1] as List<ClinicImage>,
        'evaluations': results[2] as PaginatedEvaluationsResponse,
      };
    } catch (e) {
      rethrow;
    }
  }
}
