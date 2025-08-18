import 'package:oxytocin/features/search_doctors_page/data/models/specialty_model.dart';

class MainSpecialtyModel {
  final SpecialtyModel specialty;
  final String university;
  final String createdAt;
  final String updatedAt;

  MainSpecialtyModel({
    required this.specialty,
    required this.university,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MainSpecialtyModel.fromJson(Map<String, dynamic> json) {
    return MainSpecialtyModel(
      specialty: SpecialtyModel.fromJson(json['specialty']),
      university: json['university'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
