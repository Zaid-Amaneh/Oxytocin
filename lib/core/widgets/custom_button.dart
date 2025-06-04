import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onTap,
    required this.data,
    required this.visible,
    this.gradient,
    this.borderColor,
    this.style,
    required this.padding,
  });
  final void Function()? onTap;
  final String data;
  final bool visible;
  final Gradient? gradient;
  final Color? borderColor;
  final TextStyle? style;
  final EdgeInsetsGeometry padding;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: ShapeDecoration(
          gradient: gradient,
          color: visible ? borderColor : Colors.transparent,
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
          padding: padding,
          child: Text(data, style: style),
        ),
      ),
    );
  }
}
