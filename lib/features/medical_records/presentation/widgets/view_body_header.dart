import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/theme/app_colors.dart';

class ViewBodyHeader extends StatelessWidget {
  const ViewBodyHeader({super.key, required this.titel, required this.des});
  final String titel, des;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Text(
            titel,
            style: AppStyles.almaraiBold(
              context,
            ).copyWith(color: AppColors.kPrimaryColor1, fontSize: 20),
          ),
          Text(
            des,
            style: AppStyles.almaraiBold(
              context,
            ).copyWith(color: AppColors.textSecondary, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
