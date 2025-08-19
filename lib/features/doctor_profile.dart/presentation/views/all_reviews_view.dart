import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/widgets/custom_app_bar.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/widget/all_reviews_view_body.dart';

class AllReviewsView extends StatelessWidget {
  const AllReviewsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titel: context.tr.realPastPatients),
      body: const AllReviewsViewBody(),
    );
  }
}
