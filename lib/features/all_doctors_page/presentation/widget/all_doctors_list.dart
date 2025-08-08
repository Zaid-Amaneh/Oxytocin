import 'package:flutter/material.dart';
import 'package:oxytocin/features/all_doctors_page/presentation/widget/doctor_card.dart';

class AllDoctorsList extends StatelessWidget {
  const AllDoctorsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      itemCount: 20,

      itemBuilder: (context, index) {
        return const Padding(padding: EdgeInsets.all(6), child: DoctorCard());
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
    );
  }
}
