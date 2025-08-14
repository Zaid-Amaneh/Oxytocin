import 'package:flutter/material.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/widget/doctor_profile_view_body_header.dart';

class DoctorProfileViewBody extends StatelessWidget {
  const DoctorProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: DoctorProfileViewBodyHeader(
            doctorName: 'أحمد العتيبي',
            imageUrl:
                'https://img.freepik.com/premium-photo/portrait-young-handsome-male-doctor-he-stands-office-white-coat-with_321831-13945.jpg',
            rating: 4.4,
            specialty: 'استشاري أمراض القلب',
            margin: EdgeInsets.all(0),
          ),
        ),
      ],
    );
  }
}
