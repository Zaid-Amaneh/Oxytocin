import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';

class MedicalRecordsViewBodyHeader extends StatelessWidget {
  const MedicalRecordsViewBodyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          context.tr.selectSpecialtyToViewRecords,
          style: AppStyles.almaraiBold(
            context,
          ).copyWith(color: AppColors.kPrimaryColor1, fontSize: 20),
        ),
        Text(
          context.tr.myMedicalRecordsDescription,
          style: AppStyles.almaraiBold(
            context,
          ).copyWith(color: AppColors.textSecondary, fontSize: 14),
        ),
      ],
    );
  }
}
