import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/features/doctor_profile.dart/data/models/paginated_evaluations_response.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/widget/rate_stars.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.evaluation});
  final EvaluationModel evaluation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RateStars(
            rate: evaluation.rate.toDouble(),
            withText: false,
            starSize: 0.04,
          ),
          const SizedBox(height: 8),

          Text(
            '"${evaluation.comment}"',
            style: AppStyles.almaraiRegular(
              context,
            ).copyWith(color: AppColors.textPrimary, fontSize: 16),
          ),
          Text(
            "- ${evaluation.patientFullName}",
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
