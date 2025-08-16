import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/widget/rate_stars.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/widget/review.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.review});
  final Review review;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RateStars(rate: review.rating, withText: false, starSize: 0.04),
          const SizedBox(height: 8),

          Text(
            '"${review.comment}"',
            style: AppStyles.almaraiRegular(
              context,
            ).copyWith(color: AppColors.textPrimary, fontSize: 16),
          ),
          Text(
            "- ${review.patientName}",
            style: AppStyles.almaraiBold(
              context,
            ).copyWith(color: AppColors.textSecondary, fontSize: 12),
            textAlign: Helper.isArabic(context)
                ? TextAlign.right
                : TextAlign.left,
          ),
        ],
      ),
    );
  }
}
