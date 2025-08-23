import 'package:flutter/material.dart';
import 'package:oxytocin/features/book_appointment/data/models/booked_appointment_model.dart';
import 'package:oxytocin/features/book_appointment/presentation/widgets/appointment_successfully_booked_body.dart';

class AppointmentSuccessfullyBooked extends StatelessWidget {
  const AppointmentSuccessfullyBooked({
    super.key,
    required this.bookedAppointmentModel,
  });
  final BookedAppointmentModel bookedAppointmentModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppointmentSuccessfullyBookedBody(
        bookedAppointmentModel: bookedAppointmentModel,
      ),
    );
  }
}
