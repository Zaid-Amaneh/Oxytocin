import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/theme/app_colors.dart';

void showRatingSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      double selectedRating = 0;
      final TextEditingController commentController = TextEditingController();

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
                  'كيف كانت جلستك؟ قيّم تجربتك معنا!',
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
                    hintText:
                        'شاركنا رأيك ليساعد غيرك.. ما الذي أعجبك أو لم يعجبك؟',
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
                            Navigator.pop(context);
                          },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "إرسال",
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
