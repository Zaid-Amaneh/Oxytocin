import 'patient_archive_model.dart';

class PatientArchivesDoctorResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<PatientArchive> results;

  PatientArchivesDoctorResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory PatientArchivesDoctorResponse.fromJson(Map<String, dynamic> json) {
    return PatientArchivesDoctorResponse(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: List<PatientArchive>.from(
        json['results'].map((x) => PatientArchive.fromJson(x)),
      ),
    );
  }
}
