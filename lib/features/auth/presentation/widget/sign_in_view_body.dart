import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/widgets/password_field.dart';
import 'package:oxytocin/core/widgets/phone_number_field.dart';
import 'package:oxytocin/features/auth/presentation/widget/custom_switch.dart';

class SignInViewBody extends StatelessWidget {
  const SignInViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Positioned(
          bottom: height * 0.35,
          child: SvgPicture.asset(Assets.imagesLayer2),
        ),
        Positioned(
          bottom: height * 0.35,
          left: width * 0.002,
          right: width * 0.002,
          child: SvgPicture.asset(Assets.imagesLayer1),
        ),
        Positioned(
          top: height * 0.3,
          child: Container(
            decoration: const ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: Color(0xFFC9C9C9)),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              shadows: [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4.10,
                  offset: Offset(0, 4),
                  spreadRadius: 6,
                ),
              ],
            ),
            width: width,
            height: height,
            child: const Column(
              children: [
                SizedBox(height: 50),
                CustomSwitch(inup: true),
                SizedBox(height: 50),
                PhoneNumberField(),
                PasswordField(),
              ],
            ),
          ),
        ),

        Positioned(
          bottom: height * 0.35,
          left: width * 0.05,
          right: width * 0.05,
          child: SvgPicture.asset(Assets.imagesAssistantsignin),
        ),
      ],
    );
  }
}
