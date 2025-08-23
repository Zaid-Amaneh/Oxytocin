import 'package:equatable/equatable.dart';
import 'package:oxytocin/features/search_doctors_page/data/models/main_specialty_model.dart';

class BookedAppointmentModel extends Equatable {
  final int id;
  final String visitDate;
  final String visitTime;
  final String status;
  final String? notes;
  final String createdAt;
  final String updatedAt;
  final dynamic cancelledAt;
  final dynamic cancelledBy;
  final ClinicInfo clinic;

  const BookedAppointmentModel({
    required this.id,
    required this.visitDate,
    required this.visitTime,
    required this.status,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.cancelledAt,
    this.cancelledBy,
    required this.clinic,
  });

  factory BookedAppointmentModel.fromJson(Map<String, dynamic> json) {
    return BookedAppointmentModel(
      id: json['id'],
      visitDate: json['visit_date'],
      visitTime: json['visit_time'],
      status: json['status'],
      notes: json['notes'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      cancelledAt: json['cancelled_at'],
      cancelledBy: json['cancelled_by'],
      clinic: ClinicInfo.fromJson(json['clinic']),
    );
  }

  @override
  List<Object?> get props => [id, visitDate, visitTime, status, createdAt];
}

class ClinicInfo extends Equatable {
  final DoctorInfo doctor;
  final String address;
  final double longitude;
  final double latitude;

  const ClinicInfo({
    required this.doctor,
    required this.address,
    required this.longitude,
    required this.latitude,
  });

  factory ClinicInfo.fromJson(Map<String, dynamic> json) {
    return ClinicInfo(
      doctor: DoctorInfo.fromJson(json['doctor']),
      address: json['address'],
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
    );
  }

  @override
  List<Object?> get props => [doctor, address, longitude, latitude];
}

class DoctorInfo extends Equatable {
  final UserInfo user;
  final MainSpecialtyModel mainSpecialty;
  final double rate;
  final int rates;
  final String address;

  const DoctorInfo({
    required this.user,
    required this.mainSpecialty,
    required this.rate,
    required this.rates,
    required this.address,
  });

  factory DoctorInfo.fromJson(Map<String, dynamic> json) {
    return DoctorInfo(
      user: UserInfo.fromJson(json['user']),
      mainSpecialty: MainSpecialtyModel.fromJson(json['main_specialty']),
      rate: (json['rate'] as num).toDouble(),
      rates: json['rates'],
      address: json['address'],
    );
  }

  @override
  List<Object?> get props => [user, mainSpecialty, rate, rates, address];
}

class UserInfo extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String? image;
  final String gender;

  const UserInfo({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.image,
    required this.gender,
  });

  String get fullName => '$firstName $lastName';

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      image: json['image'],
      gender: json['gender'],
    );
  }

  @override
  List<Object?> get props => [id, firstName, lastName, image, gender];
}

// class MainSpecialtyInfo extends Equatable {
//   final SpecialtyInfo specialty;
//   final String university;

//   const MainSpecialtyInfo({required this.specialty, required this.university});

//   factory MainSpecialtyInfo.fromJson(Map<String, dynamic> json) {
//     return MainSpecialtyInfo(
//       specialty: SpecialtyInfo.fromJson(json['specialty']),
//       university: json['university'],
//     );
//   }

//   @override
//   List<Object?> get props => [specialty, university];
// }

// class SpecialtyInfo extends Equatable {
//   final int id;
//   final String nameEn;
//   final String nameAr;

//   const SpecialtyInfo({
//     required this.id,
//     required this.nameEn,
//     required this.nameAr,
//   });

//   factory SpecialtyInfo.fromJson(Map<String, dynamic> json) {
//     return SpecialtyInfo(
//       id: json['id'],
//       nameEn: json['name_en'],
//       nameAr: json['name_ar'],
//     );
//   }

//   @override
//   List<Object?> get props => [id, nameEn, nameAr];
// }
