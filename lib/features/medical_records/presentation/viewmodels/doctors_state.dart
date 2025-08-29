import 'package:equatable/equatable.dart';
import 'package:oxytocin/features/medical_records/data/models/doctors_by_specialty_response.dart';

abstract class DoctorsState extends Equatable {
  const DoctorsState();

  @override
  List<Object> get props => [];
}

class DoctorsInitial extends DoctorsState {}

class DoctorsLoading extends DoctorsState {}

class DoctorsLoaded extends DoctorsState {
  final DoctorsBySpecialtyResponse doctorsResponse;

  const DoctorsLoaded(this.doctorsResponse);

  @override
  List<Object> get props => [doctorsResponse];
}

class DoctorsError extends DoctorsState {
  final String message;

  const DoctorsError(this.message);

  @override
  List<Object> get props => [message];
}
