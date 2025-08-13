import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/widgets/custom_button.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({
    super.key,
    required this.inup,
    this.signInTap,
    this.signUpTap,
  });
  final bool inup;
  final void Function()? signInTap, signUpTap;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    return Positioned(
      top: height * 0.34,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: width * 0.9,
          height: height * 0.09,
          decoration: const ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: Color(0xFFC9C9C9)),
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4.10,
                offset: Offset(0, 4),
                spreadRadius: 3,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                buttonPadding: const EdgeInsets.all(0),
                borderRadius: 29,
                onTap: inup ? signUpTap : null,
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 13),
                data: context.tr.signUp,
                borderColor: AppColors.kPrimaryColor1,
                visible: !inup,
                style: inup
                    ? AppStyles.tajawalBold(context).copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      )
                    : AppStyles.tajawalBold(context),
              ),
              CustomButton(
                buttonPadding: const EdgeInsets.all(0),
                borderRadius: 29,
                onTap: inup ? null : signInTap,
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 13),
                data: context.tr.signIn,
                visible: inup,
                borderColor: AppColors.kPrimaryColor1,
                style: inup
                    ? AppStyles.tajawalBold(context)
                    : AppStyles.tajawalBold(context).copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*
Container(
          width: width * 0.9,
          height: height * 0.09,
          decoration: const ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: Color(0xFFC9C9C9)),
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4.10,
                offset: Offset(0, 4),
                spreadRadius: 3,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                buttonPadding: const EdgeInsets.all(0),
                borderRadius: 29,
                onTap: inup ? signUpTap : null,
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 13),
                data: context.tr.signUp,    
                borderColor: AppColors.kPrimaryColor1,
                visible: !inup,
                style: inup
                    ? AppStyles.tajawalBold(context).copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      )
                    : AppStyles.tajawalBold(context),
              ),
              CustomButton(
                buttonPadding: const EdgeInsets.all(0),
                borderRadius: 29,
                onTap: inup ? null : signInTap,
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 13),
                data: context.tr.signIn,
                visible: inup,
                borderColor: AppColors.kPrimaryColor1,
                style: inup
                    ? AppStyles.tajawalBold(context)
                    : AppStyles.tajawalBold(context).copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
              ),
            ],
          ),
        )
*/