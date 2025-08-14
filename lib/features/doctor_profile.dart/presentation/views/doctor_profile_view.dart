import 'package:flutter/material.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/widget/doctor_profile_app_bar.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/widget/doctor_profile_view_body.dart';

class DoctorProfileView extends StatelessWidget {
  const DoctorProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DoctorProfileViewBody(),
      appBar: DoctorAppBar(doctorName: 'Zaid Amaneh'),
    );
  }
}
