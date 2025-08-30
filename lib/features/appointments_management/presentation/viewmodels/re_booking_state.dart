import 'package:equatable/equatable.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/features/book_appointment/data/models/booked_appointment_model.dart';

abstract class ReBookingState extends Equatable {
  const ReBookingState();

  @override
  List<Object> get props => [];
}

class BookingInitial extends ReBookingState {}

class BookingLoading extends ReBookingState {}

class BookingSuccess extends ReBookingState {
  final BookedAppointmentModel bookedAppointment;
  const BookingSuccess({required this.bookedAppointment});

  @override
  List<Object> get props => [bookedAppointment];
}

class BookingFailure extends ReBookingState {
  final String errorMessage;
  final Failure error;
  const BookingFailure({required this.errorMessage, required this.error});

  @override
  List<Object> get props => [errorMessage];
}
