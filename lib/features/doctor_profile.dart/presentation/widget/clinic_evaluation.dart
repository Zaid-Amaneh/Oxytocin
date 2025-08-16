import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/routing/navigation_service.dart';
import 'package:oxytocin/core/routing/route_names.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/widget/rate_stars.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/widget/review.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/widget/review_card.dart';

class ClinicEvaluation extends StatelessWidget {
  const ClinicEvaluation({super.key, required this.rate});
  final double rate;

  @override
  Widget build(BuildContext context) {
    final List<Review> reviews = [
      Review(
        patientName: "محمد الأحمد",
        comment: "دكتور محترف جدًا ويشرح الحالة بتفصيل، العيادة نظيفة ومنظمة.",
        rating: 4.0,
      ),
      Review(
        patientName: "سامي الحسن",
        comment: "تجربة جيدة، أنصح به، فقط تمنيت أن تكون العيادة أكبر.",
        rating: 4.0,
      ),
      Review(
        patientName: "رنا خليل",
        comment:
            "كانت تجربتي رائعة، لم أضطر للانتظار طويلا والدكتور كان دقيقًا جدًا.",
        rating: 4.0,
      ),
      Review(
        patientName: "رنا خليل",
        comment:
            "كانت تجربتي رائعة، لم أضطر للانتظار طويلا والدكتور كان دقيقًا جدًا.",
        rating: 4.0,
      ),
      Review(
        patientName: "رنا خليل",
        comment:
            "كانت تجربتي رائعة، لم أضطر للانتظار طويلا والدكتور كان دقيقًا جدًا.",
        rating: 4.0,
      ),
    ];
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
          ListView.builder(
            itemCount: reviews.length > 3 ? 3 : reviews.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ReviewCard(review: reviews[index]);
            },
          ),
          if (reviews.length > 3)
            Center(
              child: TextButton(
                onPressed: () {
                  NavigationService().pushToNamed(RouteNames.allReviewsView);
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
