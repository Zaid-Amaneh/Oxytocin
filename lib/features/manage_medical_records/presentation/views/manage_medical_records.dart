import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/widgets/custom_app_bar.dart';
import 'package:oxytocin/features/manage_medical_records/presentation/widgets/manage_medical_records_body.dart';

class ManageMedicalRecords extends StatelessWidget {
  const ManageMedicalRecords({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titel: context.tr.manageMedicalRecords),
      body: const ManageMedicalRecordsBody(),
    );
  }
}
