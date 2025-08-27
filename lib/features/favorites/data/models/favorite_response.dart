import 'doctor_model.dart';

class FavoriteResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<FavoriteDoctor> results;

  FavoriteResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory FavoriteResponse.fromJson(Map<String, dynamic> json) {
    return FavoriteResponse(
      count: json['count'] ?? 0,
      next: json['next'],
      previous: json['previous'],
      results:
          (json['results'] as List<dynamic>?)
              ?.map((item) => FavoriteDoctor.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class FavoriteDoctor {
  final int id;
  final Doctor doctor;
  final String createdAt;

  FavoriteDoctor({
    required this.id,
    required this.doctor,
    required this.createdAt,
  });

  factory FavoriteDoctor.fromJson(Map<String, dynamic> json) {
    return FavoriteDoctor(
      id: json['id'],
      doctor: Doctor.fromJson(json['doctor']),
      createdAt: json['created_at'] ?? '',
    );
  }
}
