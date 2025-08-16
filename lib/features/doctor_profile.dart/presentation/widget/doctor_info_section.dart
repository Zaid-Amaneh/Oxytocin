import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';

class DoctorInfoSection extends StatelessWidget {
  const DoctorInfoSection({
    super.key,
    required this.placeOfStudy,
    required this.about,
  });
  final String placeOfStudy;
  final String about;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr.aboutDoctor,
            style: AppStyles.almaraiBold(
              context,
            ).copyWith(color: AppColors.textPrimary, fontSize: 18),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr.placeStudy,
                style: AppStyles.almaraiBold(
                  context,
                ).copyWith(color: AppColors.textPrimary, fontSize: 18),
              ),
              Text(
                placeOfStudy,
                style: AppStyles.almaraiRegular(
                  context,
                ).copyWith(color: AppColors.textSecondary, fontSize: 16),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr.about,
                style: AppStyles.almaraiBold(
                  context,
                ).copyWith(color: AppColors.textPrimary, fontSize: 18),
              ),
              Text(
                about,
                style: AppStyles.almaraiRegular(
                  context,
                ).copyWith(color: AppColors.textSecondary, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
