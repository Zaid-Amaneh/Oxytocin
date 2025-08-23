import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/extensions/failure_localization.dart';
import 'package:oxytocin/features/book_appointment/data/models/book_appointment_request_model.dart';
import 'package:oxytocin/features/book_appointment/data/services/appointment_service.dart';
import 'package:oxytocin/l10n/app_localizations.dart';
import 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final AppointmentService _appointmentService;

  BookingCubit(this._appointmentService) : super(BookingInitial());

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
      final bookedAppointment = await _appointmentService.bookAppointment(
        clinicId: clinicId,
        bookingData: requestModel,
      );
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
