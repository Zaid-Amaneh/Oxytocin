import 'package:flutter/material.dart';
import 'package:oxytocin/constants/app_constants.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onTap,
    required this.data,
    required this.visible,
    required this.color,
  });
  final void Function()? onTap;
  final String data;
  final bool visible;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: ShapeDecoration(
          color: visible ? kPrimaryColor4 : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(29),
          ),
          shadows: visible
              ? [
                  const BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ]
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
          child: Text(
            data,
            style: AppStyles.almaraiExtraBold(context).copyWith(color: color),
          ),
        ),
      ),
    );
  }
}
