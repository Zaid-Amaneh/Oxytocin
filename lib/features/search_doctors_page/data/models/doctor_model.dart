import 'package:oxytocin/features/search_doctors_page/data/models/specialty_model.dart';
import 'package:oxytocin/features/search_doctors_page/data/models/user_model.dart';

class DoctorModel {
  final UserModel user;
  final String about;
  final SpecialtyModel mainSpecialty;
  final double rate;

  DoctorModel({
    required this.user,
    required this.about,
    required this.mainSpecialty,
    required this.rate,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      user: UserModel.fromJson(json['user']),
      about: json['about'],
      mainSpecialty: SpecialtyModel.fromJson(json['main_specialty']),
      rate: (json['rate'] as num).toDouble(),
    );
  }
}
