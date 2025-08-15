import 'package:flutter/material.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/widgets/sliver_divider.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/widget/clinic_location.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/widget/clinic_photos_gallery.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/widget/doctor_profile_view_body_header.dart';

class DoctorProfileViewBody extends StatelessWidget {
  const DoctorProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> clinicImages = [
      'https://cdn.pixabay.com/photo/2016/09/27/17/14/heart-1698840_1280.jpg',
      'https://cdn.pixabay.com/photo/2014/11/27/20/12/doctor-548133_1280.jpg',
      'https://cdn.pixabay.com/photo/2017/08/06/07/12/dentist-2589771_1280.jpg',
      'https://cdn.pixabay.com/photo/2019/04/03/03/05/medical-equipment-4099428_1280.jpg',
    ];

    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: DoctorProfileViewBodyHeader(
            doctorName: 'أحمد العتيبي',
            imageUrl:
                'https://img.freepik.com/premium-photo/portrait-young-handsome-male-doctor-he-stands-office-white-coat-with_321831-13945.jpg',
            rating: 3.5,
            specialty: 'استشاري أمراض القلب',
            margin: EdgeInsets.all(0),
          ),
        ),
        const SliverDivider(color: AppColors.textSecondary),
        // SliverToBoxAdapter(
        //   child: ClinicLocationPage(
        //     clinicLatitude: 33.531647,
        //     clinicLongitude: 36.333698,
        //     clinicName: 'زيد أمانة',
        //     clinicLocation: 'شارع فارس الخوري',
        //   ),
        // ),
        SliverToBoxAdapter(child: ClinicPhotosGallery(imageUrls: clinicImages)),
        const SliverDivider(color: AppColors.textSecondary),
      ],
    );
  }
}
