import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/features/appointments_management/presentation/viewmodels/management_appointments_cubit.dart';

void showRatingSheet(
  BuildContext context,
  int id,
  ManagementAppointmentsCubit cubit,
) {
  double selectedRating = 0;
  final TextEditingController commentController = TextEditingController();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                Text(
                  context.tr.sessionFeedbackTitle,
                  style: AppStyles.tajawalBold(
                    context,
                  ).copyWith(color: AppColors.kPrimaryColor1),
                ),
                const SizedBox(height: 15),
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemSize: 40,
                  itemBuilder: (context, _) => Padding(
                    padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                    child: SvgPicture.asset(AppImages.starSolid),
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      selectedRating = rating;
                    });
                  },
                ),
                const SizedBox(height: 10),
                const DottedLine(
                  dashLength: 6,
                  dashColor: Colors.grey,
                  lineThickness: 1,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: commentController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: context.tr.sessionFeedbackSubtitle,
                    hintStyle: AppStyles.almaraiRegular(
                      context,
                    ).copyWith(color: AppColors.textPrimary, fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: selectedRating == 0
                        ? null
                        : () {
                            Logger().f(commentController.text);
                            Logger().f(selectedRating.toInt());
                            cubit.submitEvaluation(
                              appointmentId: id,
                              rate: selectedRating.toInt(),
                              comment: commentController.text,
                            );
                            if (context.mounted) {
                              context.pop();
                            }
                          },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        context.tr.send,
                        style: AppStyles.almaraiBold(
                          context,
                        ).copyWith(color: AppColors.textPrimary, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            );
          },
        ),
      );
    },
  );
}
