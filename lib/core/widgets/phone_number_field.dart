import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/constants/app_constants.dart';
import 'package:oxytocin/core/theme/app_colors.dart';

class PhoneNumberField extends StatefulWidget {
  const PhoneNumberField({super.key});

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  final TextEditingController textController = TextEditingController();
  final RegExp syrianPhoneRegExp = RegExp(r'^09\d{8}$');
  final RegExp digitValidator = RegExp("[0-9]");
  bool isANumber = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DecoratedBox(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
            borderRadius: BorderRadius.circular(
              AppConstants.borderRadiusCircular,
            ),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: TextFormField(
          controller: textController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.allow(digitValidator)],
          onChanged: (value) {
            setValidator(syrianPhoneRegExp.hasMatch(value));
          },
          decoration: InputDecoration(
            suffixIcon: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset(Assets.imagesPhoneIcon),
            ),
            errorText: isANumber ? null : context.tr.PleaseEnterValidNumber,
            hintText: context.tr.PhoneNumber,
            hintStyle: AppStyles.almaraiBold(context).copyWith(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
            errorStyle: AppStyles.almaraiRegular(
              context,
            ).copyWith(color: AppColors.error),
          ),
        ),
      ),
    );
  }

  void setValidator(bool valid) {
    setState(() {
      isANumber = valid;
    });
  }
}
