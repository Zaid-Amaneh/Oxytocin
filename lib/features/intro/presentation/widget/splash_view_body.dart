import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:oxytocin/constants/app_constants.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/generated/l10n.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(gradient: kLinearGradient1),
      child: Column(
        children: [
          const Spacer(flex: 3),
          Image.asset(Assets.imagesLogoEmpty),
          const Spacer(),
          AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText(
                S.of(context).Oxytocin,
                textStyle: AppStyles.gESSUniqueBold(context),
                speed: const Duration(milliseconds: 300),
                curve: Curves.linear,
              ),
            ],
            totalRepeatCount: 5,
            displayFullTextOnTap: true,
          ),
          const Spacer(flex: 6),
        ],
      ),
    );
  }
}
//////