import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/features/medical_records/presentation/widgets/view_body_header.dart';
import 'package:oxytocin/features/medical_records/presentation/widgets/speciality_list_builder.dart';

class SpecializationsViewBody extends StatelessWidget {
  const SpecializationsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: ViewBodyHeader(
            titel: context.tr.selectSpecialtyToViewRecords,
            des: context.tr.myMedicalRecordsDescription,
          ),
        ),
        const SpecialityListBuilder(),
      ],
    );
  }
}
