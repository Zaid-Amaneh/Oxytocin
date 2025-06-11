import 'package:flutter/material.dart';

class AdditionalContainer extends StatelessWidget {
  const AdditionalContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    return Positioned(
      top: height * 0.3,
      child: Container(
        width: width,
        height: height * 0.15,
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            ),
          ),
        ),
      ),
    );
  }
}
