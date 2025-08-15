import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oxytocin/core/constants/api_endpoints.dart';
import 'package:oxytocin/features/home/data/model/doctor_model.dart';
import 'package:oxytocin/features/home/data/model/nearby_doctor_model.dart';

class DoctorsService {
  final String baseUrl;

  DoctorsService({required this.baseUrl});
  Future<List<DoctorModel>> getHighestRatedDoctors() async {
    try {
      final url = '$baseUrl${ApiEndpoints.highestRatedDoctors}';
      print('Fetching doctors from: $url');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          // Add authorization header if needed
          // 'Authorization': 'Bearer $token',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        final doctors = jsonData.map((json) {
          return DoctorModel.fromJson(json);
        }).toList();

        return doctors;
      } else {
        throw Exception('Failed to load doctors: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching doctors: $e');
    }
  }

  Future<DoctorModel> getDoctorById(int doctorId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl${ApiEndpoints.doctorById}/$doctorId'),
        headers: {
          'Content-Type': 'application/json',
          // Add authorization header if needed
          // 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return DoctorModel.fromJson(jsonData);
      } else {
        throw Exception('Failed to load doctor: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching doctor: $e');
    }
  }

  Future<List<NearbyDoctorModel>> getNearbyDoctors({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final url =
          '$baseUrl${ApiEndpoints.nearestDoctors}?latitude=$latitude&longitude=$longitude';

      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        final nearbyDoctors = jsonData.map((e) {
          return NearbyDoctorModel.fromJson(e);
        }).toList();

        return nearbyDoctors;
      } else {
        throw Exception(
          'Failed to load nearby doctors: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching nearby doctors: $e');
    }
  }
}
