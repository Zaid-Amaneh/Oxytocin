import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oxytocin/core/theme/app_colors.dart';

class PageHeaderIcon extends StatelessWidget {
  const PageHeaderIcon({super.key, required this.icon});
  final String icon;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    return Padding(
      padding: EdgeInsets.only(
        left: width * 0.38,
        right: width * 0.38,
        top: height * 0.1,
        bottom: height * 0.02,
      ),
      child: Container(
        height: width * 0.24,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: AppColors.containerBorder),
            borderRadius: BorderRadius.circular(25),
          ),
          shadows: [
            const BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SvgPicture.asset(icon),
          ),
        ),
      ),
    );
  }
}
