import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:oxytocin/features/profile/data/datasources/profile_data_source.dart';
import 'package:oxytocin/features/profile/data/models/complete_register_model.dart';

import 'profile_info_state.dart';
import 'dart:io';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  final ProfileRemoteDataSource _dataSource = ProfileRemoteDataSource();

  ProfileInfoCubit() : super(const ProfileInfoState());

  void setGender(String gender) {
    emit(state.copyWith(gender: gender));
  }

  void setBirthDate(DateTime date) {
    emit(state.copyWith(birthDate: date));
  }

  void setJob(String job) {
    emit(state.copyWith(job: job));
  }

  void setBloodType(String value) {
    print('setBloodType: $value');
    emit(state.copyWith(bloodType: value));
  }

  void setLocation(String value) {
    emit(state.copyWith(location: value));
  }

  void setLongitude(String value) {
    emit(state.copyWith(longitude: value));
  }

  void setLatitude(String value) {
    emit(state.copyWith(latitude: value));
  }

  void setMedicalHistory(String value) {
    print('setMedicalHistory: $value');
    emit(state.copyWith(medicalHistory: value));
  }

  void setSurgicalHistory(String value) {
    print('setSurgicalHistory: $value');
    emit(state.copyWith(surgicalHistory: value));
  }

  void setAllergies(String value) {
    print('setAllergies: $value');
    emit(state.copyWith(allergies: value));
  }

  void setMedicines(String value) {
    print('setMedicines: $value');
    emit(state.copyWith(medicines: value));
  }

  void setIsSmoker(bool value) => emit(state.copyWith(isSmoker: value));
  void setIsDrinker(bool value) => emit(state.copyWith(isDrinker: value));
  void setIsMarried(bool value) => emit(state.copyWith(isMarried: value));

  Future<void> submitProfileInfo() async {
    print('--- بيانات المستخدم ---');
    print('الجنس: \\${state.gender}');
    print('تاريخ الميلاد: \\${state.birthDate}');
    print('الوظيفة: \\${state.job}');

    if (state.gender == null ||
        state.birthDate == null ||
        state.job == null ||
        state.job!.isEmpty) {
      emit(state.copyWith(errorMessage: "الرجاء تعبئة جميع الحقول."));
      return;
    }

    emit(state.copyWith(isSubmitting: true, clearErrorMessage: true));
    try {
      final userModel = UserDataModel(
        gender: state.gender!,
        birthDate: DateFormat('yyyy-MM-dd').format(state.birthDate!),
      );

      final requestModel = CompleteRegisterRequestModel(
        user: userModel,
        job: state.job!,
      );

      await _dataSource.completeRegister(requestModel);

      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, errorMessage: e.toString()));
    }
  }

  Future<void> uploadProfileImage(File imageFile) async {
    emit(state.copyWith(isSubmitting: true, clearErrorMessage: true));
    try {
      await _dataSource.uploadProfileImage(imageFile); // تكتبها في data source
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, errorMessage: e.toString()));
    }
  }

  Future<void> submitMedicalInfo() async {
    print('--- Submitting Medical Info 000000000000000---');

    print('gender: ${state.gender}');

    print('birthdate: ${state.birthDate}');

    print('job: ${state.job}');

    print('medicalHistory: ${state.medicalHistory}');
    print('surgicalHistory: ${state.surgicalHistory}');
    print('allergies: ${state.allergies}');
    print('medicines: ${state.medicines}');
    print('bloodType: ${state.bloodType}');
    print('isSmoker: ${state.isSmoker}');
    print('isDrinker: ${state.isDrinker}');
    print('isMarried: ${state.isMarried}');
    print('location: ${state.location}');
    print('longitude: ${state.longitude}');
    print('latitude: ${state.latitude}');

    if (state.bloodType == null || state.bloodType!.isEmpty) {
      emit(state.copyWith(errorMessage: "يرجى اختيار زمرة الدم"));
      return;
    }
    if (state.medicalHistory == null) {
      emit(
        state.copyWith(
          errorMessage: "يرجى إدخال الأمراض المزمنة أو اكتب لا يوجد",
        ),
      );
      return;
    }
    if (state.surgicalHistory == null) {
      emit(
        state.copyWith(
          errorMessage: "يرجى إدخال العمليات الجراحية أو اكتب لا يوجد",
        ),
      );
      return;
    }
    if (state.allergies == null) {
      emit(state.copyWith(errorMessage: "يرجى إدخال الحساسية أو اكتب لا يوجد"));
      return;
    }
    if (state.medicines == null) {
      emit(state.copyWith(errorMessage: "يرجى إدخال الأدوية أو اكتب لا يوجد"));
      return;
    }

    emit(state.copyWith(isSubmitting: true, clearErrorMessage: true));
    try {
      final userModel = UserDataModel(
        gender: state.gender!,
        birthDate: DateFormat('yyyy-MM-dd').format(state.birthDate!),
      );
      final requestModel = CompleteRegisterRequestModel(
        user: userModel,
        job: state.job!,
        location: state.location ?? 'mm',
        longitude: state.longitude ?? 'mm',
        latitude: state.latitude ?? 'm,m',
        bloodType: state.bloodType ?? '',
        medicalHistory: state.medicalHistory ?? '',
        surgicalHistory: state.surgicalHistory ?? '',
        allergies: state.allergies ?? '',
        medicines: state.medicines ?? '',
        isSmoker: state.isSmoker,
        isDrinker: state.isDrinker,
        isMarried: state.isMarried,
      );
      await _dataSource.completeRegister(requestModel);
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, errorMessage: e.toString()));
    }
  }
}
