import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:oxytocin/core/constants/api_endpoints.dart';
import 'package:oxytocin/features/doctor_profile.dart/data/models/clinic_image.dart';
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

  Future<Map<String, dynamic>> fetchDoctorProfileWithImages(
    int doctorId,
  ) async {
    try {
      final results = await Future.wait([
        fetchDoctorProfile(doctorId),
        fetchClinicImages(doctorId),
      ]);

      return {
        'doctorProfile': results[0] as DoctorProfileModel,
        'clinicImages': results[1] as List<ClinicImage>,
      };
    } catch (e) {
      rethrow;
    }
  }
}
