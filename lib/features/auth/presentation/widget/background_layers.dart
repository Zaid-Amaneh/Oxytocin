import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/theme/app_colors.dart';

class BackgroundLayers extends StatelessWidget {
  const BackgroundLayers({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      child: Container(
        color: AppColors.kPrimaryColor1,
        child: Column(
          children: [
            SvgPicture.asset(Assets.imagesLayer2, fit: BoxFit.fill),
            SvgPicture.asset(Assets.imagesLayer2, fit: BoxFit.fill),
          ],
        ),
      ),
    );
  }
}
