import 'package:flutter/material.dart';
import 'package:oxytocin/core/widgets/custom_app_bar.dart';
import 'package:oxytocin/features/medical_records/presentation/widgets/doctor_list_view_body.dart';

class DoctorListView extends StatelessWidget {
  const DoctorListView({super.key, required this.id, required this.specName});
  final int id;
  final String specName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titel: specName),
      body: DoctorListViewBody(id: id),
    );
  }
}
