import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/web.dart';
import 'package:oxytocin/core/constants/api_endpoints.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/features/search_doctors_page/data/models/doctor_search_request.dart';
import 'package:oxytocin/features/search_doctors_page/data/models/search_doctors_response.dart';

class DoctorSearchService {
  final http.Client client;

  DoctorSearchService(this.client);

  Future<SearchDoctorsResponse> searchDoctors(
    DoctorSearchRequest request,
  ) async {
    Logger().i(request.gender);
    Logger().i(request.longitude);
    Logger().i(request.latitude);
    final uri = Uri.parse(
      ApiEndpoints.doctorSearch,
    ).replace(queryParameters: request.toQueryParams());

    try {
      final response = await client.get(
        uri,
        headers: {'Accept': 'application/json'},
      );

      Logger().t(response.body);
      if (response.statusCode == 200) {
        return SearchDoctorsResponse.fromJson(jsonDecode(response.body));
      } else {
        throw const ServerFailure();
      }
    } catch (e) {
      if (e is Failure) rethrow;
      throw const NetworkFailure();
    }
  }
}
