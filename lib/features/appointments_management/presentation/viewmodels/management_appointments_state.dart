import 'package:equatable/equatable.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/features/appointments_management/data/models/appointment_model.dart';
import 'package:oxytocin/features/appointments_management/data/models/created_evaluation_model.dart';

abstract class ManagementAppointmentsState extends Equatable {
  const ManagementAppointmentsState();

  @override
  List<Object> get props => [];
}

class ManagementAppointmentsInitial extends ManagementAppointmentsState {}

class AppointmentsLoading extends ManagementAppointmentsState {}

class AppointmentsLoaded extends ManagementAppointmentsState {
  final List<AppointmentModel> appointments;
  final bool hasReachedMax;
  final int currentPage;
  final String status;

  const AppointmentsLoaded({
    required this.appointments,
    required this.hasReachedMax,
    required this.currentPage,
    required this.status,
  });

  AppointmentsLoaded copyWith({
    List<AppointmentModel>? appointments,
    bool? hasReachedMax,
    int? currentPage,
    String? status,
  }) {
    return AppointmentsLoaded(
      appointments: appointments ?? this.appointments,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [appointments, hasReachedMax, currentPage, status];
}

class AppointmentsFailure extends ManagementAppointmentsState {
  final String errorMessage;
  final Failure failure;
  const AppointmentsFailure({
    required this.errorMessage,
    required this.failure,
  });

  @override
  List<Object> get props => [errorMessage, failure];
}

class EvaluationLoading extends ManagementAppointmentsState {}

class EvaluationSuccess extends ManagementAppointmentsState {
  final CreatedEvaluationModel evaluation;

  const EvaluationSuccess(this.evaluation);

  @override
  List<Object> get props => [evaluation];
}

class EvaluationFailure extends ManagementAppointmentsState {
  final String errorMessage;

  const EvaluationFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
