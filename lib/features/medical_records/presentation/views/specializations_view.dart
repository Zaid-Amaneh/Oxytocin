import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/widgets/custom_app_bar.dart';
import 'package:oxytocin/features/medical_records/presentation/widgets/specializations_view_body.dart';

class SpecializationsView extends StatelessWidget {
  const SpecializationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titel: context.tr.myMedicalRecordsTitle),
      body: const SpecializationsViewBody(),
    );
  }
}
