part of 'doctor_search_cubit.dart';

abstract class DoctorSearchState extends Equatable {
  const DoctorSearchState();

  @override
  List<Object> get props => [];
}

class DoctorSearchInitial extends DoctorSearchState {}

class DoctorSearchLoading extends DoctorSearchState {}

class DoctorSearchSuccess extends DoctorSearchState {
  final List<DoctorModel> doctors;
  final bool hasReachedMax;

  const DoctorSearchSuccess({
    required this.doctors,
    required this.hasReachedMax,
  });

  DoctorSearchSuccess copyWith({
    List<DoctorModel>? doctors,
    bool? hasReachedMax,
  }) {
    return DoctorSearchSuccess(
      doctors: doctors ?? this.doctors,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [doctors, hasReachedMax];
}

class DoctorSearchFailure extends DoctorSearchState {
  final Failure error;

  const DoctorSearchFailure(this.error);

  @override
  List<Object> get props => [error];
}
