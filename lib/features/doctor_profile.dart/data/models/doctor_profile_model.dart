import 'package:equatable/equatable.dart';
import 'package:oxytocin/features/doctor_profile.dart/data/models/clinic_model.dart';
import 'package:oxytocin/features/doctor_profile.dart/data/models/sub_specialty_model.dart';
import 'package:oxytocin/features/search_doctors_page/data/models/main_specialty_model.dart';

class DoctorProfileModel extends Equatable {
  final UserModel user;
  final String about;
  final String education;
  final int experience;
  final double rate;
  final MainSpecialtyModel mainSpecialty;
  final List<SubSpecialtyModel> subspecialties;
  final ClinicModel clinic;

  const DoctorProfileModel({
    required this.user,
    required this.about,
    required this.education,
    required this.experience,
    required this.rate,
    required this.mainSpecialty,
    required this.subspecialties,
    required this.clinic,
  });

  factory DoctorProfileModel.fromJson(Map<String, dynamic> json) {
    return DoctorProfileModel(
      user: UserModel.fromJson(json['user']),
      about: json['about'],
      education: json['education'],
      experience: json['experience'],
      rate: (json['rate'] as num).toDouble(),
      mainSpecialty: MainSpecialtyModel.fromJson(json['main_specialty']),
      subspecialties: List<SubSpecialtyModel>.from(
        json['subspecialties'].map((x) => SubSpecialtyModel.fromJson(x)),
      ),
      clinic: ClinicModel.fromJson(json['clinic']),
    );
  }

  @override
  List<Object?> get props => [
    user,
    about,
    education,
    experience,
    rate,
    mainSpecialty,
    subspecialties,
    clinic,
  ];
}

class UserModel extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String? image;
  final String gender;
  final int? age;

  const UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.image,
    required this.gender,
    this.age,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      image: json['image'],
      gender: json['gender'],
      age: json['age'],
    );
  }

  String get fullName => '$firstName $lastName';

  @override
  List<Object?> get props => [id, firstName, lastName, image, gender, age];
}
