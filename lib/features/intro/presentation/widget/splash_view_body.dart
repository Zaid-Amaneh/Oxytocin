import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/Utils/services/local_storage_service.dart';
import 'package:oxytocin/core/routing/navigation_service.dart';
import 'package:oxytocin/core/routing/route_names.dart';
import 'package:oxytocin/core/theme/app_gradients.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  static const _logoTopOffset = 0.2;
  static const _textTopOffset = 0.65;
  static const _splashDuration = Duration(seconds: 5);

  @override
  void initState() {
    super.initState();
    _startSplashTimer();
  }

  void _startSplashTimer() {
    Timer(_splashDuration, _handleNavigation);
  }

  Future<void> _handleNavigation() async {
    NavigationService nav = NavigationService();
    final localStorageService = LocalStorageService();
    final isNewUser = await localStorageService.isNewUser();
    final keepUser = await localStorageService.isUserKeptSignedIn();
    if (keepUser) {
      // Go to Home
    } else if (isNewUser) {
      nav.goToNamed(RouteNames.intro);
    } else {
      nav.goToNamed(RouteNames.signIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        _buildBackground(size),
        _buildLogo(size),
        _buildAnimatedText(size),
      ],
    );
  }

  Widget _buildBackground(Size size) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        gradient: AppGradients.getBackgroundGradient(context),
      ),
    );
  }

  Widget _buildLogo(Size size) {
    return Positioned(
      top: size.height * _logoTopOffset,
      left: size.width * 0.2,
      right: size.width * 0.2,
      child: SvgPicture.asset(Assets.imagesLogoEmptySVG),
    );
  }

  Widget _buildAnimatedText(Size size) {
    return Positioned(
      top: size.height * _textTopOffset,
      left: 0,
      right: 0,
      child: AnimatedTextKit(
        animatedTexts: [
          ScaleAnimatedText(
            context.tr.oxytocin,
            textStyle: AppStyles.gESSUniqueBold(context),
            scalingFactor: 1.5,
            duration: const Duration(milliseconds: 2200),
            textAlign: TextAlign.center,
          ),
        ],
        repeatForever: true,
      ),
    );
  }
}
