import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/features/intro/data/models/intro_header_item.dart';

class IntroHeader extends StatelessWidget {
  const IntroHeader({super.key, required this.introHeaderItem});
  final IntroHeaderItem introHeaderItem;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(height: height * 0.1),
        Padding(
          padding: EdgeInsets.fromLTRB(
            width * 0.05,
            height * 0.02,
            width * 0.05,
            height * 0.02,
          ),
          child: Image.asset(introHeaderItem.gif),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
            width * 0.02,
            height * 0.03,
            width * 0.02,
            height * 0.03,
          ),
          child: Text(
            introHeaderItem.titel,
            textAlign: TextAlign.center,
            style: AppStyles.cairoExtraBold(context),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: width * 0.1, right: width * 0.1),
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                introHeaderItem.subtitle,
                textStyle: AppStyles.almaraiExtraBold(context),
                textAlign: TextAlign.center,
              ),
            ],
            totalRepeatCount: 1,
          ),
        ),
      ],
    );
  }
}
