import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/features/appointments_management/data/services/appointments_fetch_service.dart';
import 'appointments_state.dart';

class AppointmentsCubit extends Cubit<AppointmentsState> {
  final AppointmentsFetchService appointmentsFetchService;

  AppointmentsCubit({required this.appointmentsFetchService})
    : super(AppointmentsInitial());

  Future<void> fetchAppointments({required String status}) async {
    emit(AppointmentsLoading());
    try {
      final response = await appointmentsFetchService.getAppointments(
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
        final response = await appointmentsFetchService.getAppointments(
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
        Logger().e("Failed to fetch more appointments: ${e.toString()}");
      }
    }
  }
}
