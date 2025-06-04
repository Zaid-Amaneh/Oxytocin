import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/services/local_storage_service.dart';
import 'package:oxytocin/core/theme/app_gradients.dart';
import 'package:oxytocin/features/auth/presentation/views/sign_in_view.dart';
import 'package:oxytocin/features/intro/presentation/views/intro_view.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    navigateToSecondScreen();
    super.initState();
  }

  Timer navigateToSecondScreen() {
    return Timer(const Duration(seconds: 5), () async {
      LocalStorageService localStorageService = LocalStorageService();
      bool newUser = await localStorageService.isNewUser();
      if (newUser) {
        Get.to(const IntroView(), transition: Transition.fade);
      } else {
        Get.to(const SignInView(), transition: Transition.fade);
        //
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            gradient: AppGradients.getBackgroundGradient(context),
          ),
        ),
        Positioned(
          top: height * 0.2,
          left: width * 0.2,
          right: width * 0.2,
          child: SvgPicture.asset(Assets.imagesLogoEmptySVG),
        ),
        Positioned(
          top: height * 0.65,
          left: 0,
          right: 0,
          child: AnimatedTextKit(
            animatedTexts: [
              ScaleAnimatedText(
                context.tr.Oxytocin,
                textStyle: AppStyles.gESSUniqueBold(context),
                scalingFactor: 1.5,
                duration: const Duration(milliseconds: 2200),
                textAlign: TextAlign.center,
              ),
            ],
            repeatForever: true,
          ),
        ),
      ],
    );
  }
}
