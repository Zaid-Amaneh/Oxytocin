import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';

class FirstLayer extends StatelessWidget {
  const FirstLayer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    return Positioned(
      top: 0,
      left: width * 0.002,
      right: width * 0.002,
      child: Column(
        children: [
          SvgPicture.asset(Assets.imagesLayer1, fit: BoxFit.fill),
          SvgPicture.asset(Assets.imagesLayer1, fit: BoxFit.fill),
        ],
      ),
    );
  }
}
