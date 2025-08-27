import 'package:equatable/equatable.dart';
import 'package:oxytocin/features/search_doctors_page/data/models/specialty_model.dart';

class SubSpecialtyModel extends Equatable {
  final SpecialtyModel specialty;
  final String university;

  const SubSpecialtyModel({required this.specialty, required this.university});

  factory SubSpecialtyModel.fromJson(Map<String, dynamic> json) {
    return SubSpecialtyModel(
      specialty: SpecialtyModel.fromJson(json['specialty']),
      university: json['university'],
    );
  }

  @override
  List<Object?> get props => [specialty, university];
}
