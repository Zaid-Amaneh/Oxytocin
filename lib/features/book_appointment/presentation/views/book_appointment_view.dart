import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/widgets/custom_app_bar.dart';
import 'package:oxytocin/features/book_appointment/presentation/widgets/book_appointment_view_body.dart';
import 'package:oxytocin/features/doctor_profile.dart/data/models/visit_time_model.dart';

class BookAppointmentView extends StatelessWidget {
  const BookAppointmentView({
    super.key,
    required this.dateText,
    required this.dayName,
    required this.availableTimes,
    required this.id,
    required this.mainSpecialty,
    required this.address,
  });
  final String dateText, dayName, id, mainSpecialty, address;
  final List<VisitTime> availableTimes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BookAppointmentViewBody(
        dateText: dateText,
        dayName: dayName,
        availableTimes: availableTimes,
        id: id,
        address: address,
        mainSpecialty: mainSpecialty,
      ),
      appBar: CustomAppBar(titel: context.tr.chooseTime),
    );
  }
}
