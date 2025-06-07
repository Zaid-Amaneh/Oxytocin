// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomSmoothPageindicator extends StatelessWidget {
  const CustomSmoothPageindicator({
    super.key,
    required this.pageController,
    required this.count,
  });
  final PageController pageController;
  final int count;
  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: pageController,
      count: count,
      effect: const CustomizableEffect(
        dotDecoration: DotDecoration(
          rotationAngle: -180,
          borderRadius: BorderRadius.all(Radius.circular(24)),
          dotBorder: DotBorder(
            type: DotBorderType.solid,
            width: 1.5,
            color: Colors.white,
          ),
          color: Colors.transparent,
          width: 16,
          height: 16,
        ),
        activeDotDecoration: DotDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24)),
          color: Colors.white,
          width: 18,
          height: 35,
        ),
      ),
    );
  }
}
