import 'package:flutter/material.dart';
import 'package:oxytocin/features/medical_appointments/presentation/widget/medical_appointments_view_body.dart';

class MedicalAppointmentsView extends StatelessWidget {
  const MedicalAppointmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: MedicalAppointmentsViewBody());
  }
}
