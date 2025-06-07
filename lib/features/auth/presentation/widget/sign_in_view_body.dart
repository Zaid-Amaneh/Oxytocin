import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/features/auth/presentation/widget/background_layers.dart';
import 'package:oxytocin/features/auth/presentation/widget/sign_in_form.dart';

class SignInViewBody extends StatelessWidget {
  const SignInViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    return SingleChildScrollView(
      child: Stack(
        children: [
          SizedBox(width: width, height: height),
          // Layer2
          const BackgroundLayers(),
          // Layer1
          Positioned(
            top: 0,
            left: width * 0.002,
            right: width * 0.002,
            child: SvgPicture.asset(Assets.imagesLayer1, fit: BoxFit.fill),
          ),
          // Sign In Form Card
          Positioned(top: height * 0.3, child: const SignInForm()),
          // Assistant Illustration
          Positioned(
            height: height * 0.47,
            left: width * 0.05,
            right: width * 0.05,
            child: SvgPicture.asset(Assets.imagesAssistantsignin),
          ),
        ],
      ),
    );
  }
}
