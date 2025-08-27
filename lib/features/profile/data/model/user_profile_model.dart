class UserProfileModel {
  final String? firstName;
  final String? lastName;
  final String? image;
  final String? phone;
  final String? gender;
  final DateTime? birthDate;
  final String? address;
  final String? job;
  final String? bloodType;
  final String? medicalHistory;
  final String? surgicalHistory;
  final String? allergies;
  final String? medicines;
  final bool? isSmoker;
  final bool? isDrinker;
  final bool? isMarried;
  final double? longitude;
  final double? latitude;

  UserProfileModel({
    this.firstName,
    this.lastName,
    this.image,
    this.phone,
    this.gender,
    this.birthDate,
    this.address,
    this.job,
    this.bloodType,
    this.medicalHistory,
    this.surgicalHistory,
    this.allergies,
    this.medicines,
    this.isSmoker,
    this.isDrinker,
    this.isMarried,
    this.longitude,
    this.latitude,
  });
  String get fullName => '${firstName ?? ''} ${lastName ?? ''}'.trim();
  int get age {
    if (birthDate == null) return 0;
    final now = DateTime.now();
    int age = now.year - birthDate!.year;
    if (now.month < birthDate!.month ||
        (now.month == birthDate!.month && now.day < birthDate!.day)) {
      age--;
    }
    return age;
  }

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      firstName: json['user']?['first_name'],
      lastName: json['user']?['last_name'],
      image: json['user']?['image'],
      phone: json['user']?['phone'],
      gender: json['user']?['gender'],
      birthDate: json['user']?['birth_date'] != null
          ? DateTime.tryParse(json['user']?['birth_date'])
          : null,
      address: json['address'],
      job: json['job'],
      bloodType: json['blood_type'],
      medicalHistory: json['medical_history'],
      surgicalHistory: json['surgical_history'],
      allergies: json['allergies'],
      medicines: json['medicines'],
      isSmoker: json['is_smoker'],
      isDrinker: json['is_drinker'],
      isMarried: json['is_married'],
      longitude: json['longitude']?.toDouble(),
      latitude: json['latitude']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': {
        'first_name': firstName,
        'last_name': lastName,
        'image': image,
        'phone': phone,
        'gender': gender,
        'birth_date': birthDate?.toIso8601String(),
      },
      'address': address,
      'location': address,
      'job': job,
      'blood_type': bloodType,
      'medical_history': medicalHistory,
      'surgical_history': surgicalHistory,
      'allergies': allergies,
      'medicines': medicines,
      'is_smoker': isSmoker,
      'is_drinker': isDrinker,
      'is_married': isMarried,
      'longitude': longitude,
      'latitude': latitude,
    };
  }
}
