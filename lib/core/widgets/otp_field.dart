import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpField extends StatefulWidget {
  const OtpField({super.key, this.controller});
  final TextEditingController? controller;

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  bool otpError = false;
  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      autovalidateMode: AutovalidateMode.disabled,
      onChanged: (value) {},
      controller: widget.controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          setState(() {
            otpError = true;
          });
          return '';
          // return context.tr.otpEmptyError;
        } else if (value.length < 5) {
          setState(() {
            otpError = true;
          });
          return '';
          // return context.tr.otpLengthError;
        }
        setState(() {
          otpError = false;
        });
        return null;
      },
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(18),
        borderWidth: 50,
        fieldHeight: 60,
        fieldWidth: 60,
        inactiveColor: otpError ? AppColors.error : AppColors.kPrimaryColor1,
        selectedColor: AppColors.kPrimaryColor2,
        // activeColor: const Color(0xFFD9D9D9),
        activeFillColor: Colors.white,
        inactiveFillColor: Colors.white,
        selectedFillColor: Colors.white,
        inActiveBoxShadow: [
          const BoxShadow(
            color: Colors.grey,
            blurRadius: 1,
            offset: Offset(0, 2),
            spreadRadius: 0.5,
          ),
        ],
      ),
      errorTextMargin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      errorTextSpace: 5,
      errorTextDirection: Helper.isArabic(context)
          ? TextDirection.rtl
          : TextDirection.ltr,
      enableActiveFill: true,
      hintCharacter: 'X',
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      appContext: context,
      length: 5,
      keyboardType: TextInputType.number,
    );
  }
}
