import 'package:oxytocin/features/search_doctors_page/data/models/main_specialty_model.dart';

class PatientArchive {
  final int id;
  final Doctor doctor;
  final Appointment appointment;
  final String mainComplaint;
  final String caseHistory;
  final Map<String, String>? vitalSigns;
  final String? recommendations;
  final double cost;
  final double paid;
  final DateTime createdAt;
  final DateTime updatedAt;

  PatientArchive({
    required this.id,
    required this.doctor,
    required this.appointment,
    required this.mainComplaint,
    required this.caseHistory,
    this.vitalSigns,
    this.recommendations,
    required this.cost,
    required this.paid,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PatientArchive.fromJson(Map<String, dynamic> json) {
    return PatientArchive(
      id: json['id'],
      doctor: Doctor.fromJson(json['doctor']),
      appointment: Appointment.fromJson(json['appointment']),
      mainComplaint: json['main_complaint'],
      caseHistory: json['case_history'],
      vitalSigns: json['vital_signs'] == null
          ? null
          : Map<String, String>.from(json['vital_signs']),
      recommendations: json['recommendations'],
      cost: (json['cost'] as num).toDouble(),
      paid: (json['paid'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class Doctor {
  final User user;
  final MainSpecialtyModel mainSpecialty;
  final double rate;
  final int rates;
  final String address;

  Doctor({
    required this.user,
    required this.mainSpecialty,
    required this.rate,
    required this.rates,
    required this.address,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      user: User.fromJson(json['user']),
      mainSpecialty: MainSpecialtyModel.fromJson(json['main_specialty']),
      rate: (json['rate'] as num).toDouble(),
      rates: json['rates'],
      address: json['address'],
    );
  }
}

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String phone;
  final String? image;
  final String gender;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    this.image,
    required this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phone: json['phone'],
      image: json['image'],
      gender: json['gender'],
    );
  }
}

class Appointment {
  final int id;
  final String visitDate;
  final String visitTime;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Appointment({
    required this.id,
    required this.visitDate,
    required this.visitTime,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      visitDate: json['visit_date'],
      visitTime: json['visit_time'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
