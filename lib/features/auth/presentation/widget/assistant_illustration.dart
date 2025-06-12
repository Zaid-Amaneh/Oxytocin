import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';

class AssistantIllustration extends StatelessWidget {
  const AssistantIllustration({super.key, required this.form});
  final bool form;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    return Positioned(
      height: height * 0.47,
      left: width * 0.08,
      right: width * 0.08,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 2500),
        transitionBuilder: (child, animation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(3.0, -1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        child: form
            ? SvgPicture.asset(
                Helper.isArabic()
                    ? Assets.imagesAssistantRightHand
                    : Assets.imagesAssistantLeftHand,
              )
            : SvgPicture.asset(
                Helper.isArabic()
                    ? Assets.imagesAssistantLeftHand
                    : Assets.imagesAssistantRightHand,
              ),
      ),
      // AnimatedSizeAndFade(
      //   fadeDuration: const Duration(milliseconds: 10000),
      //   fadeInCurve: Easing.legacy,
      //   fadeOutCurve: Easing.legacy,
      //   // firstChild: SvgPicture.asset(Assets.imagesAssistantsignin),
      //   // secondChild:
      //   // duration: const Duration(milliseconds: 2500),
      //   sizeCurve: Curves.bounceIn,
      //   // firstChild: SvgPicture.asset(Assets.imagesAssistantsignin),
      //   // secondChild:
      //   // duration: const Duration(milliseconds: 2500),
      //   child: form
      //       ? SvgPicture.asset(Assets.imagesAssistantsignin)
      //       : SvgPicture.asset(Assets.imagesAssistantsignup),
      // ),
      // child: AnimatedSizeAndFade(
      //   firstChild: SvgPicture.asset(Assets.imagesAssistantsignin),
      //   secondChild: SvgPicture.asset(Assets.imagesAssistantsignup),
      //   duration: const Duration(milliseconds: 2500),
      //   crossFadeState: form
      //       ? CrossFadeState.showFirst
      //       : CrossFadeState.showSecond,
      //   firstCurve: Curves.fastOutSlowIn,
      //   secondCurve: Curves.slowMiddle,
      //   sizeCurve: Curves.fastEaseInToSlowEaseOut,
      // ),
    );
  }
}
