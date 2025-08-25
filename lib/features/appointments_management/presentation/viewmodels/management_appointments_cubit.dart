import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/features/appointments_management/data/models/appointment_model.dart';
import 'package:oxytocin/features/appointments_management/data/models/evaluation_request_model.dart';
import 'package:oxytocin/features/appointments_management/data/services/appointments_fetch_service.dart';
import 'package:oxytocin/features/appointments_management/data/services/evaluation_service.dart';
import 'management_appointments_state.dart';

class ManagementAppointmentsCubit extends Cubit<ManagementAppointmentsState> {
  final AppointmentsFetchService _appointmentsFetchService;
  final EvaluationService _evaluationService;
  final Logger _logger = Logger();

  ManagementAppointmentsCubit({
    required AppointmentsFetchService appointmentsFetchService,
    required EvaluationService evaluationService,
  }) : _appointmentsFetchService = appointmentsFetchService,
       _evaluationService = evaluationService,
       super(ManagementAppointmentsInitial());

  Future<void> fetchAppointments({required String status}) async {
    emit(AppointmentsLoading());
    try {
      final response = await _appointmentsFetchService.getAppointments(
        status: status,
        page: 1,
      );

      emit(
        AppointmentsLoaded(
          appointments: response.results,
          hasReachedMax: response.next == null,
          currentPage: 1,
          status: status,
        ),
      );
    } on Failure catch (e) {
      emit(AppointmentsFailure(errorMessage: e.toString(), failure: e));
    }
  }

  Future<void> fetchMoreAppointments() async {
    if (state is AppointmentsLoaded) {
      final currentState = state as AppointmentsLoaded;
      if (currentState.hasReachedMax) return;

      try {
        final nextPage = currentState.currentPage + 1;
        final response = await _appointmentsFetchService.getAppointments(
          status: currentState.status,
          page: nextPage,
        );

        emit(
          currentState.copyWith(
            appointments: currentState.appointments + response.results,
            hasReachedMax: response.next == null,
            currentPage: nextPage,
          ),
        );
      } on Failure catch (e) {
        _logger.e("Failed to fetch more appointments: ${e.toString()}");
      }
    }
  }

  Future<void> submitEvaluation({
    required int appointmentId,
    required int rate,
    String? comment,
  }) async {
    final currentState = state;
    emit(EvaluationLoading());

    final requestModel = EvaluationRequestModel(
      appointmentId: appointmentId,
      rate: rate,
      comment: comment,
    );

    try {
      final createdEvaluation = await _evaluationService.submitEvaluation(
        evaluationData: requestModel,
      );

      emit(EvaluationSuccess(createdEvaluation));

      if (currentState is AppointmentsLoaded) {
        final updatedAppointments = currentState.appointments.map((
          appointment,
        ) {
          if (appointment.id == appointmentId) {
            return appointment.copyWith(
              evaluation: EvaluationModel(
                id: createdEvaluation.id,
                rate: rate,
                comment: comment,
                createdAt: createdEvaluation.createdAt,
                updatedAt: createdEvaluation.updatedAt,
              ),
            );
          }
          return appointment;
        }).toList();

        emit(currentState.copyWith(appointments: updatedAppointments));
      }
    } catch (e) {
      _logger.d(e);
      emit(
        const EvaluationFailure(
          "An unexpected error occurred. Please try again.",
        ),
      );
      if (currentState is AppointmentsLoaded) {
        emit(currentState);
      }
    }
  }
}
