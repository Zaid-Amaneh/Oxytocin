import 'package:equatable/equatable.dart';
import 'package:oxytocin/features/manage_medical_records/data/models/specialty_access_model.dart';

abstract class SpecialtyAccessState extends Equatable {
  const SpecialtyAccessState();

  @override
  List<Object?> get props => [];
}

class SpecialtyAccessInitial extends SpecialtyAccessState {}

class SpecialtyAccessLoading extends SpecialtyAccessState {}

class SpecialtyAccessLoaded extends SpecialtyAccessState {
  final List<SpecialtyAccess> specialties;

  const SpecialtyAccessLoaded(this.specialties);

  @override
  List<Object> get props => [specialties];
}

class SpecialtyAccessError extends SpecialtyAccessState {
  final String message;

  const SpecialtyAccessError(this.message);

  @override
  List<Object> get props => [message];
}

class SpecialtyAccessUpdating extends SpecialtyAccessLoaded {
  final int updatingId;

  const SpecialtyAccessUpdating(super.specialties, this.updatingId);

  @override
  List<Object> get props => [specialties, updatingId];
}
