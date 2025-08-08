import 'package:flutter/material.dart';
import 'package:oxytocin/features/all_doctors_page/presentation/widget/all_doctors_list.dart';
import 'package:oxytocin/features/all_doctors_page/presentation/widget/all_doctors_view_body_header.dart';

class AllDoctorsViewBody extends StatelessWidget {
  const AllDoctorsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: AllDoctorsViewBodyHeader()),
        AllDoctorsList(),
      ],
    );
  }
}
