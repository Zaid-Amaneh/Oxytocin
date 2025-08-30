import 'package:flutter/material.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/appointments_management_view_body.dart';

class AppointmentsManagementView extends StatelessWidget {
  const AppointmentsManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: AppointmentsManagementViewBody());
  }
}
