import 'package:flutter/material.dart';
import 'package:oxytocin/core/theme/app_colors.dart';

class AppGradients {
  static LinearGradient getBackgroundGradient(BuildContext context) {  
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark
        ? const LinearGradient(
            colors: [AppColors.kPrimaryColor3, AppColors.kPrimaryColor2],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
        : const LinearGradient(
            colors: [AppColors.kPrimaryColor1, AppColors.kPrimaryColor2],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          );
  }
}
