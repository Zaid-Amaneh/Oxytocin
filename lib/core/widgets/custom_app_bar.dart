import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/widgets/custom_back_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.titel,
    this.backgroundColor = AppColors.kPrimaryColor1,
    this.textColor = Colors.black,
  });
  final String titel;
  final Color backgroundColor;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      leading: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.kPrimaryColor1.withValues(alpha: 0.15),
              blurRadius: 8,
              offset: const Offset(0, 3),
              spreadRadius: 1,
            ),
            const BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 4,
              offset: Offset(0, 1),
              spreadRadius: 0,
            ),
          ],
        ),
        child: const CustomeBackButton(),
      ),
      title: Text(
        titel,
        style: AppStyles.almaraiBold(context).copyWith(fontSize: 16),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
