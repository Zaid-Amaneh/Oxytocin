import 'package:flutter/material.dart';

class SizeConfig {
  static const double desktop = 1200;
  static const double tablet = 800;
  static late double screenHigh, screenWidth;
  static init(BuildContext context) {
    screenHigh = MediaQuery.sizeOf(context).height;
    screenWidth = MediaQuery.sizeOf(context).width;
  }
}
