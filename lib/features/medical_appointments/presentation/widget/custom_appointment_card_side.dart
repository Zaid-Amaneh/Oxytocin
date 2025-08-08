import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';

class CustomAppointmentCardSide extends StatelessWidget {
  const CustomAppointmentCardSide({
    super.key,
    required this.text,
    required this.gif,
    required this.color,
    required this.textcolor,
  });
  final String text, gif;
  final Color color, textcolor;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    // final height = size.height;
    return Container(
      width: width * 0.2,
      decoration: ShapeDecoration(
        color: color,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: AppStyles.almaraiBold(
                context,
              ).copyWith(fontSize: 11, color: textcolor),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Image.asset(gif),
        ],
      ),
    );
  }
}
