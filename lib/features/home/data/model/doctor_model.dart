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
  });
  String get fullName => '$firstName $lastName';
  String get specialtyName => specialtyNameAr; // Default to Arabic
  String get formattedImageUrl {
    if (imageUrl.isEmpty) {
      return '';
    }
    if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
      print('URL is already complete: $imageUrl');
      return imageUrl;
    }
    final formattedUrl = 'http://192.168.1.100:8000$imageUrl';
    return formattedUrl;
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
    };
  }
}
