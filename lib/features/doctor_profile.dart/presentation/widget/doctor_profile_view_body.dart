import 'package:flutter/material.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/widgets/sliver_divider.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/widget/clinic_location.dart';
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
            rating: 3.5,
            specialty: 'استشاري أمراض القلب',
            margin: EdgeInsets.all(0),
          ),
        ),
        SliverDivider(color: AppColors.textSecondary),
        // SliverToBoxAdapter(
        //   child: ClinicLocationPage(
        //     clinicLatitude: 33.531647,
        //     clinicLongitude: 36.333698,
        //     clinicName: 'زيد أمانة',
        //     clinicLocation: 'شارع فارس الخوري',
        //   ),
        // ),
        SliverDivider(color: AppColors.textSecondary),
      ],
    );
  }
}
