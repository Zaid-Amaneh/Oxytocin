import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/features/doctor_profile.dart/data/services/doctor_profile_service.dart';
import 'doctor_profile_state.dart';

class DoctorProfileCubit extends Cubit<DoctorProfileState> {
  final DoctorProfileService _doctorProfileService;

  DoctorProfileCubit(this._doctorProfileService)
    : super(DoctorProfileInitial());

  int? _lastClinicId;
  String? _lastStartDate;
  String? _lastEndDate;
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

  Future<void> fetchAllDoctorData({
    required int clinicId,
    required String startDate,
    required String endDate,
  }) async {
    _lastClinicId = clinicId;
    _lastStartDate = startDate;
    _lastEndDate = endDate;
    emit(DoctorProfileLoading());
    try {
      final results = await _doctorProfileService.fetchAllDoctorData(
        clinicId: clinicId,
        startDate: startDate,
        endDate: endDate,
      );

      final doctorProfile = results['doctorProfile'];
      final clinicImages = results['clinicImages'];
      final evaluations = results['evaluations'];
      final appointmentDates = results['appointmentDates'];

      emit(
        DoctorProfileAllDataSuccess(
          doctorProfile,
          clinicImages,
          evaluations,
          appointmentDates,
        ),
      );
    } catch (e) {
      emit(DoctorProfileFailure(e.toString()));
    }
  }

  Future<void> refreshAllDoctorData() async {
    if (_lastClinicId != null &&
        _lastStartDate != null &&
        _lastEndDate != null) {
      await fetchAllDoctorData(
        clinicId: _lastClinicId!,
        startDate: _lastStartDate!,
        endDate: _lastEndDate!,
      );
    }
  }

  Future<void> fetchAppointmentDates({
    required int clinicId,
    required String startDate,
    required String endDate,
  }) async {
    _lastClinicId = clinicId;
    _lastStartDate = startDate;
    _lastEndDate = endDate;
    emit(AppointmentDatesLoading());
    try {
      final appointmentDates = await _doctorProfileService
          .fetchAppointmentDates(
            clinicId: clinicId,
            startDate: startDate,
            endDate: endDate,
          );
      emit(AppointmentDatesSuccess(appointmentDates));
    } catch (e) {
      emit(AppointmentDatesFailure(e.toString()));
    }
  }

  Future<void> refreshAppointmentDates() async {
    if (_lastClinicId != null &&
        _lastStartDate != null &&
        _lastEndDate != null) {
      await fetchAppointmentDates(
        clinicId: _lastClinicId!,
        startDate: _lastStartDate!,
        endDate: _lastEndDate!,
      );
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
          currentState.appointmentDates,
        ),
      );
    }
  }

  void reset() {
    emit(DoctorProfileInitial());
  }
}
