import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/features/auth/presentation/widget/background_layers.dart';
import 'package:oxytocin/features/auth/presentation/widget/custom_switch.dart';
import 'package:oxytocin/features/auth/presentation/widget/sign_in_form.dart';
import 'package:oxytocin/features/auth/presentation/widget/sign_up_form.dart';

class AuthViewBody extends StatefulWidget {
  const AuthViewBody({super.key});

  @override
  State<AuthViewBody> createState() => _AuthViewBodyState();
}

bool form = true;

class _AuthViewBodyState extends State<AuthViewBody> {
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
          Positioned(
            top: height * 0.3,
            bottom: 0,
            child: AnimatedCrossFade(
              firstChild: const SignInForm(),
              secondChild: const SignUpForm(),
              duration: const Duration(milliseconds: 300),
              crossFadeState: form
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
            ),
          ),
          Positioned(
            top: height * 0.3,
            child: Container(
              width: width,
              height: height * 0.15,
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: height * 0.34,
            child: CustomSwitch(
              inup: form,
              signInTap: () {
                setState(() {
                  form = true;
                });
              },
              signUpTap: () {
                setState(() {
                  form = false;
                });
              },
            ),
          ),
          // Assistant Illustration
          Positioned(
            height: height * 0.47,
            left: width * 0.08,
            right: width * 0.08,
            child: AnimatedCrossFade(
              firstChild: SvgPicture.asset(Assets.imagesAssistantsignin),
              secondChild: SvgPicture.asset(Assets.imagesAssistantsignup),
              duration: const Duration(seconds: 5),
              crossFadeState: form
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstCurve: Curves.linear,
              secondCurve: Curves.linear,
              sizeCurve: Curves.linear,
            ),
          ),
        ],
      ),
    );
  }
}
