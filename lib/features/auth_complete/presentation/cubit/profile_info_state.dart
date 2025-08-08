import 'package:equatable/equatable.dart';

class ProfileInfoState extends Equatable {
  final String? gender;
  final DateTime? birthDate;
  final String? job;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;
  final String? bloodType;
  final String? medicalHistory;
  final String? surgicalHistory;
  final String? allergies;
  final String? medicines;
  final bool isSmoker;
  final bool isDrinker;
  final bool isMarried;
  final String? location;
  final String? longitude;
  final String? latitude;
  final bool profileExists; // حالة جديدة للتعامل مع الملف الشخصي الموجود

  const ProfileInfoState({
    this.gender,
    this.birthDate,
    this.job,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
    this.bloodType,
    this.medicalHistory,
    this.surgicalHistory,
    this.allergies,
    this.medicines,
    this.isSmoker = false,
    this.isDrinker = false,
    this.isMarried = false,
    this.location,
    this.longitude,
    this.latitude,
    this.profileExists = false, 
  });

  ProfileInfoState copyWith({
    String? gender,
    DateTime? birthDate,
    String? job,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
    bool? clearErrorMessage,
    String? bloodType,
    String? medicalHistory,
    String? surgicalHistory,
    String? allergies,
    String? medicines,
    bool? isSmoker,
    bool? isDrinker,
    bool? isMarried,
    String? location,
    String? longitude,
    String? latitude,
    bool? profileExists, // إضافة الحالة الجديدة
  }) {
    return ProfileInfoState(
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      job: job ?? this.job,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: clearErrorMessage == true
          ? null
          : (errorMessage ?? this.errorMessage),
      bloodType: bloodType ?? this.bloodType,
      medicalHistory: medicalHistory ?? this.medicalHistory,
      surgicalHistory: surgicalHistory ?? this.surgicalHistory,
      allergies: allergies ?? this.allergies,
      medicines: medicines ?? this.medicines,
      isSmoker: isSmoker ?? this.isSmoker,
      isDrinker: isDrinker ?? this.isDrinker,
      isMarried: isMarried ?? this.isMarried,
      location: location ?? this.location,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      profileExists:
          profileExists ?? this.profileExists, // إضافة الحالة الجديدة
    );
  }

  @override
  List<Object?> get props => [
    gender,
    birthDate,
    job,
    isSubmitting,
    isSuccess,
    errorMessage,
    bloodType,
    medicalHistory,
    surgicalHistory,
    allergies,
    medicines,
    isSmoker,
    isDrinker,
    isMarried,
    location,
    longitude,
    latitude,
    profileExists, // إضافة الحالة الجديدة
  ];
}
