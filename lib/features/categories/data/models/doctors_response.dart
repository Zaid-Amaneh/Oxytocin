class DoctorsResponse {
  final int count;
  final List<Doctor> results;

  DoctorsResponse({required this.count, required this.results});

  factory DoctorsResponse.fromJson(Map<String, dynamic> json) {
    return DoctorsResponse(
      count: json['count'] ?? 0,
      results: (json['results'] as List<dynamic>)
          .map((e) => Doctor.fromJson(e))
          .toList(),
    );
  }
}

class Doctor {
  final User user;
  final MainSpecialty mainSpecialty;
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
      mainSpecialty: MainSpecialty.fromJson(json['main_specialty']),
      rate: (json['rate'] ?? 0).toDouble(),
      rates: json['rates'] ?? 0,
      address: json['address'] ?? '',
    );
  }
}

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String image;
  final String gender;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      image: json['image'] ?? '',
      gender: json['gender'] ?? '',
    );
  }
}

class MainSpecialty {
  final Specialty specialty;
  final String university;

  MainSpecialty({required this.specialty, required this.university});

  factory MainSpecialty.fromJson(Map<String, dynamic> json) {
    return MainSpecialty(
      specialty: Specialty.fromJson(json['specialty']),
      university: json['university'] ?? '',
    );
  }
}

class Specialty {
  final int id;
  final String nameEn;
  final String nameAr;
  final String? image;

  Specialty({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    this.image,
  });

  factory Specialty.fromJson(Map<String, dynamic> json) {
    return Specialty(
      id: json['id'],
      nameEn: json['name_en'] ?? '',
      nameAr: json['name_ar'] ?? '',
      image: json['image'],
    );
  }
}
