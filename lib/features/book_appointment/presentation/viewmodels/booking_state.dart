import 'package:equatable/equatable.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/features/book_appointment/data/models/booked_appointment_model.dart';

abstract class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object> get props => [];
}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingSuccess extends BookingState {
  final BookedAppointmentModel bookedAppointment;
  const BookingSuccess({required this.bookedAppointment});

  @override
  List<Object> get props => [bookedAppointment];
}

class BookingFailure extends BookingState {
  final String errorMessage;
  final Failure error;
  const BookingFailure({required this.errorMessage, required this.error});

  @override
  List<Object> get props => [errorMessage];
}
