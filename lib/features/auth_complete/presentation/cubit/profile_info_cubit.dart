import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:oxytocin/features/auth_complete/data/datasources/profile_data_source.dart';
import 'package:oxytocin/features/auth_complete/data/models/complete_register_model.dart';

import 'profile_info_state.dart';
import 'dart:io';
import 'dart:convert';
import 'package:oxytocin/core/Utils/services/url_container.dart'; // Added for UrlContainer

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  final ProfileRemoteDataSource _dataSource = ProfileRemoteDataSource();

  ProfileInfoCubit() : super(const ProfileInfoState());

  void setGender(String gender) {
    print('👤 حفظ الجنس: $gender');
    emit(state.copyWith(gender: gender));
  }

  void setBirthDate(DateTime date) {
    print('📅 حفظ تاريخ الميلاد: $date');
    emit(state.copyWith(birthDate: date));
  }

  void setJob(String job) {
    print('💼 حفظ المهنة: $job');
    emit(state.copyWith(job: job));
  }

  void setBloodType(String value) {
    print('setBloodType: $value');
    emit(state.copyWith(bloodType: value));
  }

  void setLocation(String value) {
    print('📍 حفظ الموقع: $value');
    emit(state.copyWith(location: value));
  }

  void setLongitude(String value) {
    print('📍 حفظ خط الطول: $value');
    emit(state.copyWith(longitude: value));
  }

  void setLatitude(String value) {
    print('📍 حفظ خط العرض: $value');
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
    print('=== بدء إرسال المعلومات الكاملة ===');

    if (state.gender == null ||
        state.birthDate == null ||
        state.job == null ||
        state.job!.isEmpty ||
        state.bloodType == null ||
        state.bloodType!.isEmpty ||
        state.medicalHistory == null ||
        state.surgicalHistory == null ||
        state.allergies == null ||
        state.medicines == null) {
      emit(state.copyWith(errorMessage: "يرجى تعبئة جميع الحقول المطلوبة"));
      return;
    }

    emit(state.copyWith(isSubmitting: true, clearErrorMessage: true));
    final currentState = state;

    try {
      final userModel = UserDataModel(
        gender: state.gender!,
        birthDate: DateFormat('yyyy-MM-dd').format(state.birthDate!),
      );
      final requestModel = CompleteRegisterRequestModel(
        user: userModel,
        address: state.location ?? "Unknown",
        longitude: double.tryParse(state.longitude ?? '') ?? 0.0,
        latitude: double.tryParse(state.latitude ?? '') ?? 0.0,
        job: state.job!,
        bloodType: state.bloodType ?? '',
        medicalHistory: state.medicalHistory ?? '',
        surgicalHistory: state.surgicalHistory ?? '',
        allergies: state.allergies ?? '',
        medicines: state.medicines ?? '',
        isSmoker: state.isSmoker,
        isDrinker: state.isDrinker,
        isMarried: state.isMarried,
      );

      print(' إرسال البيانات...');
      print(jsonEncode(requestModel.toJson()));

      await _dataSource.completeRegister(requestModel);

      print(' تم الإرسال بنجاح');
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    } catch (e) {
      print(' فشل في الإرسال: $e');
      if (e.toString().contains('ملف شخصي سابقا')) {
        print('✅ الملف الشخصي موجود مسبقاً - سيتم الانتقال للصفحة الرئيسية');
        emit(
          state.copyWith(
            isSubmitting: false,
            isSuccess: true,
            profileExists: true,
            clearErrorMessage: true,
          ),
        );
      } else {
        emit(
          currentState.copyWith(
            isSubmitting: false,
            errorMessage: e.toString(),
            isSuccess: false,
          ),
        );
      }
    }
  }

  Future<void> checkProfileExists() async {
    try {
      final exists = await _dataSource.checkProfileExists();
      emit(state.copyWith(profileExists: exists));

      if (exists) {
        print('✅ الملف الشخصي موجود - سيتم الانتقال للصفحة الرئيسية');
        emit(state.copyWith(isSuccess: true, profileExists: true));
      }
    } catch (e) {
      print('❌ خطأ في التحقق من الملف الشخصي: $e');
    }
  }
}
