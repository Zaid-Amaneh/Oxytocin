import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/theme/app_colors.dart';

class CustomAppointmentCardButton extends StatelessWidget {
  const CustomAppointmentCardButton({
    super.key,
    required this.icon,
    required this.text,
    required this.t,
    this.onTap,
  });
  final Widget icon;
  final String text;
  final bool t;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    // final height = size.height;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width * (t ? 0.2 : 0.3),
        height: width * 0.12,
        decoration: ShapeDecoration(
          color: AppColors.kPrimaryColor1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadows: [
            const BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              text,
              textAlign: TextAlign.right,
              style: AppStyles.almaraiBold(
                context,
              ).copyWith(fontSize: 12, color: AppColors.background),
            ),
            icon,
          ],
        ),
      ),
    );
  }
}
