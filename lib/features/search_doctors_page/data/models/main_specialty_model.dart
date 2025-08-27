import 'package:oxytocin/features/search_doctors_page/data/models/specialty_model.dart';

class MainSpecialtyModel {
  final SpecialtyModel specialty;
  final String university;

  MainSpecialtyModel({required this.specialty, required this.university});

  factory MainSpecialtyModel.fromJson(Map<String, dynamic> json) {
    return MainSpecialtyModel(
      specialty: SpecialtyModel.fromJson(json['specialty']),
      university: json['university'],
    );
  }
}
