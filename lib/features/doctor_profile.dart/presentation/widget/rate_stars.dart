import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/theme/app_colors.dart';

class RateStars extends StatelessWidget {
  const RateStars({
    super.key,
    required this.rate,
    required this.withText,
    required this.starSize,
  });
  final double rate;
  final bool withText;
  final double starSize;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    // final height = size.height;
    final starsSize = width * starSize;
    final fullStars = rate.floor();
    final hasHalfStar = (rate - fullStars) >= 0.5;
    final emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);
    return Row(
      children: [
        ...List.generate(fullStars, (index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.005),
            child: SvgPicture.asset(
              AppImages.starSolid,
              height: starsSize,
              width: starsSize,
            ),
          );
        }),

        if (hasHalfStar)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.005),
            child: Stack(
              children: [
                SvgPicture.asset(
                  AppImages.starOutline,
                  height: starsSize,
                  width: starsSize,
                  colorFilter: ColorFilter.mode(
                    Colors.grey.shade300,
                    BlendMode.srcIn,
                  ),
                ),
                ClipRect(
                  child: Align(
                    alignment: Alignment.centerRight,
                    widthFactor: 0.5,
                    child: SvgPicture.asset(
                      AppImages.starSolid,
                      height: starsSize,
                      width: starsSize,
                      colorFilter: const ColorFilter.mode(
                        Colors.yellow,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        ...List.generate(emptyStars, (index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.005),
            child: SvgPicture.asset(
              AppImages.starOutline,
              height: starsSize,
              width: starsSize,
              colorFilter: ColorFilter.mode(
                Colors.grey.shade300,
                BlendMode.srcIn,
              ),
            ),
          );
        }),

        SizedBox(width: width * 0.01),
        withText
            ? Text(
                rate.toStringAsFixed(1),
                style: AppStyles.almaraiBold(context).copyWith(
                  color: AppColors.textSecondary,
                  fontSize: width * 0.034,
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
