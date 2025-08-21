import 'package:equatable/equatable.dart';
import 'package:oxytocin/features/doctor_profile.dart/data/models/appointment_date_model.dart';
import 'package:oxytocin/features/doctor_profile.dart/data/models/clinic_image.dart';
import 'package:oxytocin/features/doctor_profile.dart/data/models/doctor_profile_model.dart';
import 'package:oxytocin/features/doctor_profile.dart/data/models/paginated_evaluations_response.dart';

abstract class DoctorProfileState extends Equatable {
  const DoctorProfileState();

  @override
  List<Object> get props => [];
}

class DoctorProfileInitial extends DoctorProfileState {}

class DoctorProfileLoading extends DoctorProfileState {}

class DoctorProfileSuccess extends DoctorProfileState {
  final DoctorProfileModel doctorProfile;

  const DoctorProfileSuccess(this.doctorProfile);

  @override
  List<Object> get props => [doctorProfile];
}

class DoctorProfileFailure extends DoctorProfileState {
  final String errorMessage;

  const DoctorProfileFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class ClinicImagesLoading extends DoctorProfileState {}

class ClinicImagesSuccess extends DoctorProfileState {
  final List<ClinicImage> clinicImages;

  const ClinicImagesSuccess(this.clinicImages);

  @override
  List<Object> get props => [clinicImages];
}

class ClinicImagesFailure extends DoctorProfileState {
  final String errorMessage;

  const ClinicImagesFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class AppointmentDatesLoading extends DoctorProfileState {}

class AppointmentDatesSuccess extends DoctorProfileState {
  final List<AppointmentDate> appointmentDates;

  const AppointmentDatesSuccess(this.appointmentDates);

  @override
  List<Object> get props => [appointmentDates];
}

class AppointmentDatesFailure extends DoctorProfileState {
  final String errorMessage;

  const AppointmentDatesFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class DoctorProfileAllDataSuccess extends DoctorProfileState {
  final DoctorProfileModel doctorProfile;
  final List<ClinicImage> clinicImages;
  final PaginatedEvaluationsResponse evaluations;
  final List<AppointmentDate> appointmentDates;

  const DoctorProfileAllDataSuccess(
    this.doctorProfile,
    this.clinicImages,
    this.evaluations,
    this.appointmentDates,
  );

  @override
  List<Object> get props => [
    doctorProfile,
    clinicImages,
    evaluations,
    appointmentDates,
  ];
}
