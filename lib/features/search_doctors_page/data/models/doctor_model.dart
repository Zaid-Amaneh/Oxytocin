import 'package:oxytocin/features/search_doctors_page/data/models/main_specialty_model.dart';
import 'package:oxytocin/features/search_doctors_page/data/models/user_model.dart';

class DoctorModel {
  final UserModel user;
  final MainSpecialtyModel mainSpecialty;
  final double rate;
  final int rates;

  DoctorModel({
    required this.user,
    required this.mainSpecialty,
    required this.rate,
    required this.rates,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      user: UserModel.fromJson(json['user']),
      mainSpecialty: MainSpecialtyModel.fromJson(json['main_specialty']),
      rate: (json['rate'] as num).toDouble(),
      rates: json['rates'],
    );
  }
}
