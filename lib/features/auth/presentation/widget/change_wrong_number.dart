import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/routing/navigation_service.dart';
import 'package:oxytocin/core/theme/app_colors.dart';

class ChangeWrongNumber extends StatelessWidget {
  const ChangeWrongNumber({super.key, this.onTap});
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 5,
      children: [
        Text(
          context.tr.enteredWrongNumber,
          textAlign: TextAlign.center,
          style: AppStyles.almaraiBold(
            context,
          ).copyWith(fontSize: 14, color: AppColors.textPrimary),
        ),
        GestureDetector(
          onTap: onTap ?? () => NavigationService().goBack(),
          child: Text(
            context.tr.tapToChange,
            textAlign: TextAlign.center,
            style: AppStyles.almaraiBold(context).copyWith(
              color: AppColors.kPrimaryColor1,
              fontSize: 14,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
