class Doctor {
  final int id;
  final String firstName;
  final String lastName;
  final String image;
  final String gender;
  final String specialtyNameAr;
  final String specialtyNameEn;
  final String university;
  final double rate;
  final int rates;
  final String address;

  Doctor({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.gender,
    required this.specialtyNameAr,
    required this.specialtyNameEn,
    required this.university,
    required this.rate,
    required this.rates,
    required this.address,
  });

  String get fullName => '$firstName $lastName';
  String get specialtyName => specialtyNameAr;

  factory Doctor.fromJson(Map<String, dynamic> json) {
    final user = json['user'];
    final mainSpecialty = json['main_specialty'];
    final specialty = mainSpecialty['specialty'];

    return Doctor(
      id: user['id'],
      firstName: user['first_name'] ?? '',
      lastName: user['last_name'] ?? '',
      image: user['image'] ?? '',
      gender: user['gender'] ?? 'male',
      specialtyNameAr: specialty['name_ar'] ?? '',
      specialtyNameEn: specialty['name_en'] ?? '',
      university: mainSpecialty['university'] ?? '',
      rate: (json['rate'] ?? 0.0).toDouble(),
      rates: json['rates'] ?? 0,
      address: json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': {
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
        'image': image,
        'gender': gender,
      },
      'main_specialty': {
        'specialty': {'name_ar': specialtyNameAr, 'name_en': specialtyNameEn},
        'university': university,
      },
      'rate': rate,
      'rates': rates,
      'address': address,
    };
  }
}
