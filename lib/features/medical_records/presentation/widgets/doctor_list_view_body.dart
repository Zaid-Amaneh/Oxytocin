import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/features/medical_records/presentation/widgets/doctor_list_builder.dart';
import 'package:oxytocin/features/medical_records/presentation/widgets/view_body_header.dart';

class DoctorListViewBody extends StatelessWidget {
  const DoctorListViewBody({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: ViewBodyHeader(
            titel: context.tr.selectDoctorToViewRecords,
            des: context.tr.visitedDoctorsDescription,
          ),
        ),

        const DoctorListBuilder(),
      ],
    );
  }
}
