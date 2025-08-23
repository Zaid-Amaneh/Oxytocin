import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/constants/app_constants.dart';
import 'package:oxytocin/core/theme/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.fieldName,
    this.controller,
  });
  final String fieldName;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppConstants.textFieldPadding,
      child: DecoratedBox(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: AppColors.textfieldBorder),
            borderRadius: BorderRadius.circular(
              AppConstants.borderRadiusCircular,
            ),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            counterText: '',
            suffixIcon: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset(
                AppImages.infoIcon,
                colorFilter: const ColorFilter.mode(
                  AppColors.kPrimaryColor1,
                  BlendMode.srcIn,
                ),
              ),
            ),
            hintText: fieldName,
            hintStyle: AppStyles.almaraiBold(
              context,
            ).copyWith(color: AppColors.textPrimary, fontSize: 14),
            errorStyle: AppStyles.almaraiRegular(
              context,
            ).copyWith(color: AppColors.error),
          ),
        ),
      ),
    );
  }
}
