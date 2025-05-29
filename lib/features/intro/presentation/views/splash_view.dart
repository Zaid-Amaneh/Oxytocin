import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_images.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Image.asset(Assets.imagesLogoEmpty));
  }
}
