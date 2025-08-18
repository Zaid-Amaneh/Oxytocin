import 'package:oxytocin/features/search_doctors_page/data/models/doctor_model.dart';

class SearchDoctorsResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<DoctorModel> results;

  SearchDoctorsResponse({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory SearchDoctorsResponse.fromJson(Map<String, dynamic> json) {
    return SearchDoctorsResponse(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List)
          .map((e) => DoctorModel.fromJson(e))
          .toList(),
    );
  }
}
