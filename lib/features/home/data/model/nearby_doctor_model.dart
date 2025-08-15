class NearbyDoctorModel {
  final DoctorInfo doctor;
  final String address;
  final double distance;

  NearbyDoctorModel({
    required this.doctor,
    required this.address,
    required this.distance,
  });

  factory NearbyDoctorModel.fromJson(Map<String, dynamic> json) {
    return NearbyDoctorModel(
      doctor: DoctorInfo.fromJson(json['doctor']),
      address: json['address'] ?? '',
      distance: (json['distance'] ?? 0).toDouble(),
    );
  }
}

class DoctorInfo {
  final int id;
  final String firstName;
  final String lastName;
  final String imageUrl;
  final String specialtyNameEn;
  final String specialtyNameAr;
  final String university;
  final double rate;
  final int rates;

  DoctorInfo({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.imageUrl,
    required this.specialtyNameEn,
    required this.specialtyNameAr,
    required this.university,
    required this.rate,
    required this.rates,
  });

  String get fullName => '$firstName $lastName';
  String get specialtyName => specialtyNameAr;

  factory DoctorInfo.fromJson(Map<String, dynamic> json) {
    final user = json['user'] ?? {};
    final mainSpecialty = json['main_specialty'] ?? {};
    final specialty = mainSpecialty['specialty'] ?? {};

    return DoctorInfo(
      id: user['id'] ?? 0,
      firstName: user['first_name'] ?? '',
      lastName: user['last_name'] ?? '',
      imageUrl: user['image'] ?? '',
      specialtyNameEn: specialty['name_en'] ?? '',
      specialtyNameAr: specialty['name_ar'] ?? '',
      university: mainSpecialty['university'] ?? '',
      rate: (json['rate'] ?? 0).toDouble(),
      rates: json['rates'] ?? 0,
    );
  }
}
