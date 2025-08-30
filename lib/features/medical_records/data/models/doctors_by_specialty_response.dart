class DoctorsBySpecialtyResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<DoctorInfo> results;

  DoctorsBySpecialtyResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory DoctorsBySpecialtyResponse.fromJson(Map<String, dynamic> json) {
    return DoctorsBySpecialtyResponse(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: List<DoctorInfo>.from(
        json['results'].map((x) => DoctorInfo.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'results': List<dynamic>.from(results.map((x) => x.toJson())),
    };
  }
}

class DoctorInfo {
  final UserInfo user;
  final MainSpecialty mainSpecialty;
  final int appointmentsCount;

  DoctorInfo({
    required this.user,
    required this.mainSpecialty,
    required this.appointmentsCount,
  });

  factory DoctorInfo.fromJson(Map<String, dynamic> json) {
    return DoctorInfo(
      user: UserInfo.fromJson(json['user']),
      mainSpecialty: MainSpecialty.fromJson(json['main_specialty']),
      appointmentsCount: json['appointments_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'main_specialty': mainSpecialty.toJson(),
      'appointments_count': appointmentsCount,
    };
  }
}

class UserInfo {
  final int id;
  final String firstName;
  final String lastName;
  final String phone;
  final String? image;
  final String gender;

  UserInfo({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    this.image,
    required this.gender,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phone: json['phone'],
      image: json['image'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'image': image,
      'gender': gender,
    };
  }
}

class MainSpecialty {
  final SpecialtyInfo specialty;
  final String university;
  final String createdAt;
  final String updatedAt;

  MainSpecialty({
    required this.specialty,
    required this.university,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MainSpecialty.fromJson(Map<String, dynamic> json) {
    return MainSpecialty(
      specialty: SpecialtyInfo.fromJson(json['specialty']),
      university: json['university'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'specialty': specialty.toJson(),
      'university': university,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class SpecialtyInfo {
  final int id;
  final String nameEn;
  final String nameAr;
  final String? image;

  SpecialtyInfo({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    this.image,
  });

  factory SpecialtyInfo.fromJson(Map<String, dynamic> json) {
    return SpecialtyInfo(
      id: json['id'],
      nameEn: json['name_en'],
      nameAr: json['name_ar'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name_en': nameEn, 'name_ar': nameAr, 'image': image};
  }
}
