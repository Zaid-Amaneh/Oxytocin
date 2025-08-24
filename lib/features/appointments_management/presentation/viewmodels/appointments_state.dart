import 'package:equatable/equatable.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/features/appointments_management/data/models/appointment_model.dart';

abstract class AppointmentsState extends Equatable {
  const AppointmentsState();

  @override
  List<Object> get props => [];
}

class AppointmentsInitial extends AppointmentsState {}

class AppointmentsLoading extends AppointmentsState {}

class AppointmentsLoaded extends AppointmentsState {
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

class AppointmentsFailure extends AppointmentsState {
  final String errorMessage;
  final Failure failure;
  const AppointmentsFailure({
    required this.errorMessage,
    required this.failure,
  });

  @override
  List<Object> get props => [errorMessage];
}
