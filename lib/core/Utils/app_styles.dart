import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/size_config.dart';

abstract class AppStyles {
  static TextStyle gESSUniqueBold(context) {
    return TextStyle(
      color: const Color.fromARGB(255, 255, 255, 255),
      fontSize: getResponsiveFontSize(context, fontSize: 47),
      fontFamily: 'GESSUniqueBold',
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle cairoExtraBold(context) {
    return TextStyle(
      color: const Color.fromARGB(255, 255, 255, 255),
      fontSize: getResponsiveFontSize(context, fontSize: 32),
      fontFamily: 'CairoExtraBold',
      fontWeight: FontWeight.w800,
    );
  }

  static TextStyle almaraiExtraBold(context) {
    return TextStyle(
      color: const Color.fromARGB(255, 255, 255, 255),
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontFamily: 'AlmaraiExtraBold',
      fontWeight: FontWeight.w800,
    );
  }
}

//#
// sacleFactor
// responsive font size
// (min , max) fontsize
double getResponsiveFontSize(BuildContext context, {required double fontSize}) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize = fontSize * scaleFactor;

  double lowerLimit = fontSize * 1.0;
  double upperLimit = fontSize * 1.2;

  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}

double getScaleFactor(BuildContext context) {
  // var dispatcher = PlatformDispatcher.instance;
  // var physicalWidth = dispatcher.views.first.physicalSize.width;
  // var devicePixelRatio = dispatcher.views.first.devicePixelRatio;
  // double width = physicalWidth / devicePixelRatio;
  double width = MediaQuery.sizeOf(context).width;
  if (width < SizeConfig.tablet) {
    return width / 550;
  } else if (width < SizeConfig.desktop) {
    return width / 1000;
  } else {
    return width / 1950;
  }
}
