import 'package:flutter/material.dart';
import 'package:oxytocin/core/widgets/custom_app_bar.dart';
import 'package:oxytocin/features/medical_records/presentation/widgets/medical_records_view_body.dart';

class MedicalRecordsView extends StatelessWidget {
  const MedicalRecordsView({super.key, required this.doctorName});
  final String doctorName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titel: doctorName),
      body: const MedicalRecordsViewBody(),
    );
  }
}
