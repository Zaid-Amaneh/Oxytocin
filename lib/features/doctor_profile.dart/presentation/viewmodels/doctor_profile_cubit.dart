import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/features/doctor_profile.dart/data/services/doctor_profile_service.dart';
import 'doctor_profile_state.dart';

class DoctorProfileCubit extends Cubit<DoctorProfileState> {
  final DoctorProfileService _doctorProfileService;

  DoctorProfileCubit(this._doctorProfileService)
    : super(DoctorProfileInitial());

  Future<void> fetchDoctorProfile(int doctorId) async {
    emit(DoctorProfileLoading());
    try {
      final doctorProfile = await _doctorProfileService.fetchDoctorProfile(
        doctorId: doctorId,
      );

      emit(DoctorProfileSuccess(doctorProfile));
    } catch (e) {
      emit(DoctorProfileFailure(e.toString()));
    }
  }

  Future<void> fetchClinicImages(int clinicId) async {
    emit(ClinicImagesLoading());
    try {
      final clinicImages = await _doctorProfileService.fetchClinicImages(
        clinicId,
      );
      emit(ClinicImagesSuccess(clinicImages));
    } catch (e) {
      emit(ClinicImagesFailure(e.toString()));
    }
  }

  Future<void> fetchAllDoctorData({required int clinicId}) async {
    emit(DoctorProfileLoading());
    try {
      final results = await _doctorProfileService.fetchAllDoctorData(clinicId);

      final doctorProfile = results['doctorProfile'];
      final clinicImages = results['clinicImages'];
      final evaluations = results['evaluations'];

      emit(
        DoctorProfileAllDataSuccess(doctorProfile, clinicImages, evaluations),
      );
    } catch (e) {
      emit(DoctorProfileFailure(e.toString()));
    }
  }

  void toggleFavoriteStatus() {
    if (state is DoctorProfileAllDataSuccess) {
      final currentState = state as DoctorProfileAllDataSuccess;
      final oldProfile = currentState.doctorProfile;
      final newProfile = oldProfile.copyWith(
        isFavorite: !oldProfile.isFavorite,
      );
      emit(
        DoctorProfileAllDataSuccess(
          newProfile,
          currentState.clinicImages,
          currentState.evaluations,
        ),
      );
    }
  }

  void reset() {
    emit(DoctorProfileInitial());
  }
}
