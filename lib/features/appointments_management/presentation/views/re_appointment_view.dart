import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/re_appointment_app_bar.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/re_appointment_body.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/viewmodels/doctor_profile_cubit.dart';

class ReAppointmentView extends StatelessWidget {
  const ReAppointmentView({
    super.key,
    required this.id,
    required this.appointmentId,
  });
  final int id;
  final int appointmentId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ReAppointmentBody(
        id: id.toString(),
        appointmentId: appointmentId.toString(),
      ),
      appBar: ReAppointmentAppBar(
        onMonthSelected: (DateTime selectedMonth) {
          final startDate = DateTime(
            selectedMonth.year,
            selectedMonth.month,
            1,
          );
          final endDate = DateTime(
            selectedMonth.year,
            selectedMonth.month + 1,
            0,
          );
          final String formattedStartDate =
              "${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}";

          final String formattedEndDate =
              "${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}";
          context.read<DoctorProfileCubit>().fetchAppointmentDates(
            clinicId: id,
            startDate: formattedStartDate,
            endDate: formattedEndDate,
          );
        },
      ),
    );
  }
}
