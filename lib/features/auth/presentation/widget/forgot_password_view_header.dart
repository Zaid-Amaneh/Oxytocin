import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/features/auth/presentation/widget/Page_header_icon.dart';

class ForgotPasswordViewHeader extends StatelessWidget {
  const ForgotPasswordViewHeader({
    super.key,
    required this.icon,
    required this.title,
  });
  final String icon, title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageHeaderIcon(icon: icon),
        const SizedBox(height: 16),
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppStyles.almaraiBold(
            context,
          ).copyWith(color: AppColors.kPrimaryColor1, fontSize: 28),
        ),
      ],
    );
  }
}
