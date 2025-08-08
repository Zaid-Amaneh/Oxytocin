import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/theme/app_colors.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: const NetworkImage(
                    "https://img.freepik.com/premium-photo/female-doctor-smiling-white-background_1038537-86.jpg",
                  ),
                  backgroundColor: Colors.grey[200],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "د. ريم مصطفى",
                    style: AppStyles.almaraiBold(
                      context,
                    ).copyWith(fontSize: 14, color: AppColors.textPrimary),
                  ),
                  Text(
                    "طب الأطفال",
                    style: AppStyles.almaraiBold(
                      context,
                    ).copyWith(fontSize: 12, color: AppColors.textPrimary),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "جامعة دمشق",
              style: AppStyles.almaraiBold(
                context,
              ).copyWith(fontSize: 12, color: AppColors.textSecondary),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '4.5/5',
                          style: AppStyles.almaraiBold(context).copyWith(
                            fontSize: 12,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4, right: 4),
                          child: SvgPicture.asset(
                            AppImages.starSolid,
                            height: 14,
                            width: 14,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '215 تقييماً',
                      style: AppStyles.almaraiBold(
                        context,
                      ).copyWith(fontSize: 12, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const ShapeDecoration(
                    shape: OvalBorder(),
                    color: Color(0xFFDAE7FF),
                  ),
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(3.1416),
                    child: const Icon(
                      Icons.arrow_outward,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
