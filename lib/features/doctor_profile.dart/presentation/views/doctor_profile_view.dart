import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/features/doctor_profile.dart/data/services/doctor_profile_service.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/viewmodels/doctor_profile_cubit.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/widget/doctor_profile_app_bar.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/widget/doctor_profile_view_body.dart';

class DoctorProfileView extends StatelessWidget {
  const DoctorProfileView({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DoctorProfileCubit(DoctorProfileService())
            ..fetchAllDoctorData(clinicId: id),
      child: Scaffold(
        body: DoctorProfileViewBody(doctorId: id),
        appBar: const DoctorAppBar(),
      ),
    );
  }
}
