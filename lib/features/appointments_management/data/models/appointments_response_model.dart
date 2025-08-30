import 'package:oxytocin/features/appointments_management/data/models/appointment_model.dart';

class AppointmentsResponseModel {
  final int count;
  final String? next;
  final String? previous;
  final List<AppointmentModel> results;

  AppointmentsResponseModel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory AppointmentsResponseModel.fromJson(Map<String, dynamic> json) {
    return AppointmentsResponseModel(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List)
          .map((item) => AppointmentModel.fromJson(item))
          .toList(),
    );
  }
}
