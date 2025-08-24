import 'package:oxytocin/features/doctor_profile.dart/data/models/doctor_profile_model.dart';
import 'package:oxytocin/features/search_doctors_page/data/models/main_specialty_model.dart';

class AppointmentModel {
  final int id;
  final String visitDate;
  final String visitTime;
  final String status;
  final String notes;
  final String createdAt;
  final String updatedAt;
  final String? cancelledAt;
  final dynamic cancelledBy;
  final ClinicModel clinic;
  final EvaluationModel? evaluation;

  AppointmentModel({
    required this.id,
    required this.visitDate,
    required this.visitTime,
    required this.status,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.cancelledAt,
    this.cancelledBy,
    required this.clinic,
    this.evaluation,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'],
      visitDate: json['visit_date'],
      visitTime: json['visit_time'],
      status: json['status'],
      notes: json['notes'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      cancelledAt: json['cancelled_at'],
      cancelledBy: json['cancelled_by'],
      clinic: ClinicModel.fromJson(json['clinic']),
      evaluation: json['evaluation'] != null
          ? EvaluationModel.fromJson(json['evaluation'])
          : null,
    );
  }
}

class ClinicModel {
  final DoctorModel doctor;
  final String address;
  final double longitude;
  final double latitude;

  ClinicModel({
    required this.doctor,
    required this.address,
    required this.longitude,
    required this.latitude,
  });

  factory ClinicModel.fromJson(Map<String, dynamic> json) {
    return ClinicModel(
      doctor: DoctorModel.fromJson(json['doctor']),
      address: json['address'],
      longitude: json['longitude'],
      latitude: json['latitude'],
    );
  }
}

class DoctorModel {
  final UserModel user;
  final MainSpecialtyModel mainSpecialty;
  final double rate;
  final int rates;
  final String address;

  DoctorModel({
    required this.user,
    required this.mainSpecialty,
    required this.rate,
    required this.rates,
    required this.address,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      user: UserModel.fromJson(json['user']),
      mainSpecialty: MainSpecialtyModel.fromJson(json['main_specialty']),
      rate: json['rate'].toDouble(),
      rates: json['rates'],
      address: json['address'],
    );
  }
}

class EvaluationModel {
  final int id;
  final int rate;
  final String comment;
  final String createdAt;
  final String updatedAt;

  EvaluationModel({
    required this.id,
    required this.rate,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EvaluationModel.fromJson(Map<String, dynamic> json) {
    return EvaluationModel(
      id: json['id'],
      rate: json['rate'],
      comment: json['comment'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
