import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/features/manage_medical_records/presentation/widgets/manage_medical_records_list.dart';
import 'package:oxytocin/features/medical_records/presentation/widgets/view_body_header.dart';

class ManageMedicalRecordsBody extends StatelessWidget {
  const ManageMedicalRecordsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: ViewBodyHeader(
            titel: context.tr.medicalRecordsPermissions,
            des: context.tr.medicalRecordsPermissionsDesc,
          ),
        ),
        const ManageMedicalRecordsList(),
      ],
    );
  }
}
