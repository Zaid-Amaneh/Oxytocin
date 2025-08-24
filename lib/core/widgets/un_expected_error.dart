import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';

class UnExpectedError extends StatelessWidget {
  const UnExpectedError({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(36, 36, 36, 8),
          child: Image.asset(AppImages.unexpectedError),
        ),
        Text(
          context.tr.server_error,
          textAlign: TextAlign.center,
          style: AppStyles.almaraiBold(
            context,
          ).copyWith(color: AppColors.kPrimaryColor1, fontSize: 14),
        ),
      ],
    );
  }
}
