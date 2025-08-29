import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:oxytocin/core/constants/api_endpoints.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/features/medical_records/data/models/specialty_model.dart';

class SpecialtiesService {
  final http.Client client;
  final Logger _logger = Logger();

  SpecialtiesService(this.client);

  Future<List<SpecialtyModel>> getSpecialties() async {
    final uri = Uri.parse(ApiEndpoints.specialties);

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      final response = await client.get(uri, headers: headers);
      _logger.t(
        "Get Specialties response: ${response.statusCode}, Body: ${response.body}",
      );

      if (response.statusCode == 200) {
        _logger.i("Successfully fetched specialties.");
        return specialtyModelFromJson(response.body);
      } else {
        _logger.e(
          "Server error while fetching specialties: ${response.statusCode} - ${response.body}",
        );
        throw const ServerFailure();
      }
    } catch (e) {
      if (e is Failure) rethrow;
      _logger.e("Network or parsing failure while fetching specialties: $e");
      throw const NetworkFailure();
    }
  }
}
