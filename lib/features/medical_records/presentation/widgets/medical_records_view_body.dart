import 'package:flutter/material.dart';
import 'package:oxytocin/features/medical_records/presentation/widgets/medical_records_view_body_header.dart';

class MedicalRecordsViewBody extends StatelessWidget {
  const MedicalRecordsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [SliverToBoxAdapter(child: MedicalRecordsViewBodyHeader())],
    );
  }
}
