import 'package:equatable/equatable.dart';
import 'package:oxytocin/features/medical_records/data/models/specialty_model.dart';

abstract class SpecialtiesState extends Equatable {
  const SpecialtiesState();

  @override
  List<Object> get props => [];
}

class SpecialtiesInitial extends SpecialtiesState {}

class SpecialtiesLoading extends SpecialtiesState {}

class SpecialtiesSuccess extends SpecialtiesState {
  final List<SpecialtyModel> specialties;

  const SpecialtiesSuccess(this.specialties);

  @override
  List<Object> get props => [specialties];
}

class SpecialtiesFailure extends SpecialtiesState {
  final String errorMessage;

  const SpecialtiesFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
