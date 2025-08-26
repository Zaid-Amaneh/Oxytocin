import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/widgets/custom_app_bar.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/re_book_appointment_view_body.dart';
import 'package:oxytocin/features/doctor_profile.dart/data/models/visit_time_model.dart';

class ReBookAppointmentView extends StatelessWidget {
  const ReBookAppointmentView({
    super.key,
    required this.dateText,
    required this.dayName,
    required this.id,
    required this.availableTimes,
  });
  final String dateText, dayName, id;
  final List<VisitTime> availableTimes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ReBookAppointmentViewBody(
        dateText: dateText,
        dayName: dayName,
        availableTimes: availableTimes,
        id: id,
      ),
      appBar: CustomAppBar(titel: context.tr.chooseTime),
    );
  }
}
