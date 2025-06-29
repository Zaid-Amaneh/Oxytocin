import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/constants/app_constants.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/viewmodels/phone_view_model.dart';
import 'package:provider/provider.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';

class PhoneNumberField extends StatelessWidget {
  const PhoneNumberField({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PhoneViewModel>();
    return Padding(
      padding: AppConstants.textFieldPadding,
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
          maxLength: 10,
          controller: vm.phoneController,
          keyboardType: TextInputType.number,
          inputFormatters: vm.inputFormatters,
          onChanged: (value) => vm.validatePhone(value, context),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return context.tr.Thisfieldisrequired;
            }
            vm.validatePhone(value, context);
            return vm.errorText;
          },
          decoration: InputDecoration(
            counterText: '',
            suffixIcon: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset(Assets.imagesPhoneIcon),
            ),
            errorText: vm.errorText,
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
}
