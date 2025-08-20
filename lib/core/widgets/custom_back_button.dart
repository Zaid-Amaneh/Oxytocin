import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/routing/navigation_service.dart';
import 'package:oxytocin/core/theme/app_colors.dart';

class CustomeBackButton extends StatelessWidget {
  const CustomeBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..scale(Helper.isArabic(context) ? -1.0 : 1.0, 1.0, 1),
        child: SvgPicture.asset(
          AppImages.backIcon,
          colorFilter: const ColorFilter.mode(
            AppColors.textPrimary,
            BlendMode.srcIn,
          ),
        ),
      ),
      onPressed: () => NavigationService().goBack(),
    );
  }
}
