import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/features/appointments_management/data/services/re_book_appointment_service.dart';
import 'package:oxytocin/features/book_appointment/data/models/book_appointment_request_model.dart';
import 're_booking_state.dart';

class ReBookingCubit extends Cubit<ReBookingState> {
  final ReBookAppointmentService _reBookappointmentService;

  ReBookingCubit(this._reBookappointmentService) : super(BookingInitial());

  Future<void> confirmBooking({
    required int clinicId,
    required String visitDate,
    required String visitTime,
    String? notes,
  }) async {
    emit(BookingLoading());
    try {
      final requestModel = BookAppointmentRequestModel(
        visitDate: visitDate,
        visitTime: visitTime,
        notes: notes,
      );
      final bookedAppointment = await _reBookappointmentService
          .reBookAppointment(clinicId: clinicId, bookingData: requestModel);
      emit(BookingSuccess(bookedAppointment: bookedAppointment));
    } on Failure catch (e) {
      emit(BookingFailure(errorMessage: e.toString(), error: e));
    } catch (e) {
      emit(
        BookingFailure(
          errorMessage: e.toString(),
          error: const UnknownFailure(),
        ),
      );
    }
  }
}
