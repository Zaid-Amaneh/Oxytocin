import 'package:equatable/equatable.dart';
import 'package:oxytocin/features/medical_records/data/models/patient_archives_doctor_response.dart';

abstract class PatientArchivesState extends Equatable {
  const PatientArchivesState();

  @override
  List<Object> get props => [];
}

class PatientArchivesInitial extends PatientArchivesState {}

class PatientArchivesLoading extends PatientArchivesState {}

class PatientArchivesLoaded extends PatientArchivesState {
  final PatientArchivesDoctorResponse archivesResponse;

  const PatientArchivesLoaded(this.archivesResponse);

  @override
  List<Object> get props => [archivesResponse];
}

class PatientArchivesError extends PatientArchivesState {
  final String message;

  const PatientArchivesError(this.message);

  @override
  List<Object> get props => [message];
}
