class CompleteRegisterRequestModel {
  final UserDataModel user;
  final String location;
  final String address; // إضافة حقل address
  final double longitude;
  final double latitude;
  final String job;
  final String bloodType;
  final String medicalHistory;
  final String surgicalHistory;
  final String allergies;
  final String medicines;
  final bool isSmoker;
  final bool isDrinker;
  final bool isMarried;

  CompleteRegisterRequestModel({
    required this.user,
    this.location = '',
    this.address = '', // إضافة address
    this.longitude = 0.0,
    this.latitude = 0.0,
    required this.job,
    this.bloodType = '',
    this.medicalHistory = '',
    this.surgicalHistory = '',
    this.allergies = '',
    this.medicines = '',
    this.isSmoker = false,
    this.isDrinker = false,
    this.isMarried = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'location': location,
      'address': address, // إرسال address للباك إند
      'longitude': longitude,
      'latitude': latitude,
      'job': job,
      'blood_type': bloodType,
      'medical_history': medicalHistory,
      'surgical_history': surgicalHistory,
      'allergies': allergies,
      'medicines': medicines,
      'is_smoker': isSmoker,
      'is_drinker': isDrinker,
      'is_married': isMarried,
    };
  }
}

class UserDataModel {
  final String gender;
  final String birthDate;

  UserDataModel({required this.gender, required this.birthDate});

  Map<String, dynamic> toJson() {
    final genderValue = (gender == 'ذكر') ? 'male' : 'female';
    return {'gender': genderValue, 'birth_date': birthDate};
  }
}
