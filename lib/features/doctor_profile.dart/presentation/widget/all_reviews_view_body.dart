import 'package:flutter/material.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/widget/review.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/widget/review_card.dart';

class AllReviewsViewBody extends StatelessWidget {
  const AllReviewsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Review> reviews = [
      Review(
        patientName: "محمد الأحمد",
        comment: "دكتور محترف جدًا ويشرح الحالة بتفصيل، العيادة نظيفة ومنظمة.",
        rating: 5.0,
      ),
      Review(
        patientName: "سامي الحسن",
        comment: "تجربة جيدة، أنصح به، فقط تمنيت أن تكون العيادة أكبر.",
        rating: 4.9,
      ),
      Review(
        patientName: "رنا خليل",
        comment:
            "كانت تجربتي رائعة، لم أضطر للانتظار طويلا والدكتور كان دقيقًا جدًا.",
        rating: 4.7,
      ),
      Review(
        patientName: "رنا خليل",
        comment:
            "كانت تجربتي رائعة، لم أضطر للانتظار طويلا والدكتور كان دقيقًا جدًا.",
        rating: 4.6,
      ),
      Review(
        patientName: "رنا خليل",
        comment:
            "كانت تجربتي رائعة، لم أضطر للانتظار طويلا والدكتور كان دقيقًا جدًا.",
        rating: 4.4,
      ),
    ];
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ReviewCard(review: reviews[index]),
            const Divider(color: AppColors.textSecondary, thickness: 0.4),
          ],
        );
      },
    );
  }
}
