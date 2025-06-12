import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';

class FirstLayer extends StatelessWidget {
  const FirstLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Column(
        children: [
          SvgPicture.asset(Assets.imagesLayer1, fit: BoxFit.fill),
          SvgPicture.asset(Assets.imagesLayer1, fit: BoxFit.fill),
        ],
      ),
    );
  }
}
