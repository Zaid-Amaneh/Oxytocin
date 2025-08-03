import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/constants/app_constants.dart';
import 'package:oxytocin/core/theme/app_colors.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData? icon;
  final String? svgIcon;
  final String? Function(String?)? validator;
  final double? horizontalPadding;
  final double? verticalPadding;
  final void Function(String)? onChanged;
  const CustomInputField({
    super.key,
    required this.controller,
    required this.hint,
    this.icon,
    this.svgIcon,
    this.validator,
    this.horizontalPadding,
    this.verticalPadding,
    this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding ?? 24.0,
        vertical: verticalPadding ?? 8.0,
      ),
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
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: TextFormField(
            controller: controller,
            validator: validator,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppStyles.almaraiBold(context).copyWith(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w900,
              ),
              border: InputBorder.none,
              suffixIcon: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: svgIcon != null
                    ? SvgPicture.asset(
                        svgIcon!,
                        width: 25,
                        height: 25,
                        // ignore: deprecated_member_use
                        color: AppColors.kPrimaryColor1,
                      )
                    : (icon != null
                          ? Icon(icon, color: AppColors.kPrimaryColor1)
                          : null),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 18,
                horizontal: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
