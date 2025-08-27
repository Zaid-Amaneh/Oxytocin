import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/routing/navigation_service.dart';
import 'package:oxytocin/core/routing/route_names.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/features/doctor_profile.dart/data/models/paginated_evaluations_response.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/widget/rate_stars.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/widget/review_card.dart';

class ClinicEvaluation extends StatelessWidget {
  const ClinicEvaluation({
    super.key,
    required this.rate,
    required this.evaluations,
    required this.id,
  });
  final int id;
  final double rate;
  final List<EvaluationModel> evaluations;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr.clinicEvaluation,
            style: AppStyles.almaraiBold(
              context,
            ).copyWith(color: AppColors.textPrimary, fontSize: 18),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                rate.toString(),
                style: AppStyles.almaraiExtraBold(
                  context,
                ).copyWith(color: AppColors.textPrimary, fontSize: 34),
              ),
              RateStars(rate: rate, withText: false, starSize: 0.06),
            ],
          ),
          Text(
            "${context.tr.realPastPatients}:",
            style: AppStyles.almaraiBold(
              context,
            ).copyWith(color: AppColors.textPrimary, fontSize: 18),
          ),
          evaluations.isEmpty
              ? Text(
                  context.tr.noCommentDoctor,
                  style: AppStyles.almaraiBold(
                    context,
                  ).copyWith(color: AppColors.textSecondary, fontSize: 14),
                  textAlign: TextAlign.center,
                )
              : ListView.builder(
                  itemCount: evaluations.length > 3 ? 3 : evaluations.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ReviewCard(evaluation: evaluations[index]);
                  },
                ),
          if (evaluations.length > 3)
            Center(
              child: TextButton(
                onPressed: () {
                  NavigationService().pushToNamedWithParams(
                    RouteNames.allReviewsView,
                    pathParams: {'clinicId': id.toString()},
                  );
                },
                child: Text(
                  context.tr.viewMore,
                  style: AppStyles.almaraiBold(context).copyWith(
                    color: AppColors.kPrimaryColor1,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
