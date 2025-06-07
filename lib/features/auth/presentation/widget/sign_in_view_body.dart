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
    return SingleChildScrollView(
      child: Stack(
        children: [
          SizedBox(width: width, height: height),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              color: const Color.fromARGB(255, 0, 30, 55),
              child: Column(
                children: [
                  SvgPicture.asset(Assets.imagesLayer2, fit: BoxFit.fill),
                  SvgPicture.asset(Assets.imagesLayer2, fit: BoxFit.fill),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: width * 0.002,
            right: width * 0.002,
            child: SvgPicture.asset(Assets.imagesLayer1, fit: BoxFit.fill),
          ),
          Positioned(
            top: height * 0.3,
            child: Container(
              width: width,
              height: height,
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
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: SizedBox(height: height * 0.05)),
                  const SliverToBoxAdapter(child: CustomSwitch(inup: true)),
                  SliverToBoxAdapter(child: SizedBox(height: height * 0.05)),
                  const SliverToBoxAdapter(child: PhoneNumberField()),
                  const SliverToBoxAdapter(child: PasswordField()),
                ],
              ),
            ),
          ),
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
