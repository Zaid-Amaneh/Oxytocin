import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
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
              height: height * 0.7,
              child: const Text('hjgn'),
            ),
          ),
          SvgPicture.asset(
            Assets.imagesAssistantsignin,
            width: 150,
            height: 150,
          ),
        ],
      ),
    );
  }
}
