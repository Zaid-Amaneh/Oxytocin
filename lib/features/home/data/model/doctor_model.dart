import 'package:oxytocin/core/Utils/services/url_container.dart';

class DoctorModel {
  final int id;
  final String firstName;
  final String lastName;
  final String imageUrl;
  final String specialtyNameEn;
  final String specialtyNameAr;
  final String university;
  final double rate;
  final int rates;
  final String createdAt;
  final String updatedAt;
  final String? address;
  final int? clinicDistance;
  final String? appointment;
  final String? gender;

  DoctorModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.imageUrl,
    required this.specialtyNameEn,
    required this.specialtyNameAr,
    required this.university,
    required this.rate,
    required this.rates,
    required this.createdAt,
    required this.updatedAt,
    this.address,
    this.clinicDistance,
    this.appointment,
    this.gender,
  });
  String get fullName => '$firstName $lastName';
  String get specialtyName => specialtyNameAr; // Default to Arabic
  String get formattedDistance {
    if (clinicDistance == null) return '';
    if (clinicDistance! < 1000) {
      return '${clinicDistance}m';
    } else {
      return '${(clinicDistance! / 1000).toStringAsFixed(1)}km';
    }
  }

  bool get hasAvailableAppointment {
    if (appointment == null) return false;

    try {
      // إذا كان appointment يحتوي على تاريخ، نتحقق من أنه خلال 30 يوم
      final appointmentDate = DateTime.parse(appointment!);
      final now = DateTime.now();
      final difference = appointmentDate.difference(now).inDays;

      // إذا كان الموعد متاح خلال أقل من 30 يوم
      return difference >= 0 && difference <= 30;
    } catch (e) {
      // إذا كان appointment ليس تاريخ صحيح، نعتبره متاح
      return true;
    }
  }

  String get formattedImageUrl {
    if (imageUrl.isEmpty) {
      return '';
    }
    if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
      print('URL is already complete: $imageUrl');
      return imageUrl;
    }
    final formattedUrl = '${UrlContainer.domainUrl}$imageUrl';
    return formattedUrl;
  }

  String get defaultImageAsset {
    if (gender == 'female') {
      return 'assets/images/docWomen.png';
    } else {
      return 'assets/images/doc.png';
    }
  }

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'];
    final mainSpecialty = json['main_specialty'];
    final specialty = mainSpecialty['specialty'];

    final imageUrl = user['image'] ?? '';
    return DoctorModel(
      id: user['id'],
      firstName: user['first_name'],
      lastName: user['last_name'],
      imageUrl: imageUrl,
      specialtyNameEn: specialty['name_en'],
      specialtyNameAr: specialty['name_ar'],
      university: mainSpecialty['university'],
      rate: json['rate'].toDouble(),
      rates: json['rates'],
      createdAt: mainSpecialty['created_at'],
      updatedAt: mainSpecialty['updated_at'],
      address: json['address'],
      clinicDistance: json['clinic_distance'],
      appointment: json['appointment'],
      gender: user['gender'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'user': {
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
        'image': imageUrl,
      },
      'main_specialty': {
        'specialty': {'name_en': specialtyNameEn, 'name_ar': specialtyNameAr},
        'university': university,
        'created_at': createdAt,
        'updated_at': updatedAt,
      },
      'rate': rate,
      'rates': rates,
      if (address != null) 'address': address,
      if (clinicDistance != null) 'clinic_distance': clinicDistance,
      if (appointment != null) 'appointment': appointment,
      if (gender != null) 'gender': gender,
    };
  }
}
