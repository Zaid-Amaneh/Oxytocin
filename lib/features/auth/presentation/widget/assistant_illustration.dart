import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';

class AssistantIllustration extends StatelessWidget {
  const AssistantIllustration({super.key, required this.form});
  final bool form;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    List<Widget> imageList = <Widget>[
      SvgPicture.asset(AppImages.imagesAssistantLeftHand),
      SvgPicture.asset(AppImages.imagesAssistantRightHand),
    ];
    return Positioned(
      height: height * 0.47,
      left: width * 0.08,
      right: width * 0.08,
      child: form
          ? Helper.isArabic()
                ? imageList[1]
                : imageList[0]
          : Helper.isArabic()
          ? imageList[0]
          : imageList[1],
    );
  }
}
