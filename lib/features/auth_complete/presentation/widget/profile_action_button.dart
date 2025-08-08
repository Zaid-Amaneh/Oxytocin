import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/theme/app_colors.dart';

class ProfileActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool filled;
  final double borderRadius;
  final double fontSize;
  final Color? color;
  final Color? textColor;
  final double? height;

  const ProfileActionButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.filled = true,
    this.borderRadius = 35,
    this.fontSize = 18,
    this.color,
    this.textColor,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = color ?? AppColors.kPrimaryColor1;
    final fgColor = textColor ?? (filled ? Colors.white : bgColor);
    final buttonHeight = height ?? 56;

    return SizedBox(
      height: buttonHeight,
      child: filled
          ? ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: bgColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                elevation: 4,
                // ignore: deprecated_member_use
                shadowColor: Colors.black.withOpacity(0.25),
                textStyle: AppStyles.almaraiBold(
                  context,
                ).copyWith(fontSize: fontSize, fontWeight: FontWeight.w900),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: fgColor,
                  fontWeight: FontWeight.w900,
                  fontSize: fontSize,
                ),
              ),
            )
          : OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: bgColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                textStyle: AppStyles.almaraiBold(
                  context,
                ).copyWith(fontSize: fontSize, fontWeight: FontWeight.w900),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: bgColor,
                  fontWeight: FontWeight.w900,
                  fontSize: fontSize,
                ),
              ),
            ),
    );
  }
}
