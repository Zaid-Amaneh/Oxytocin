import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/constants/app_constants.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/viewmodels/password_view_model.dart';
import 'package:oxytocin/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ConfirmPasswordField extends StatelessWidget {
  const ConfirmPasswordField({super.key, required this.passwordController});
  final TextEditingController passwordController;
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PasswordViewModel>();
    return Padding(
      padding: AppConstants.textFieldPadding,
      child: DecoratedBox(
        decoration: ShapeDecoration(
          color: AppColors.background,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: AppColors.textfieldBorder),
            borderRadius: BorderRadius.circular(25),
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
          controller: vm.confirmPasswordController,
          focusNode: vm.focusNode,
          obscureText: vm.obscureText,
          onChanged: (value) =>
              vm.validateConfirmPassword(passwordController.text, context),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return context.tr.thisfieldisrequired;
            } else {
              vm.validateConfirmPassword(passwordController.text, context);
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.confirmpassword,
            errorText: vm.confirmErrorText,
            hintStyle: AppStyles.almaraiBold(context).copyWith(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
            errorStyle: AppStyles.almaraiRegular(
              context,
            ).copyWith(color: AppColors.error),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(16.0),
              child: vm.isFocused
                  ? GestureDetector(
                      onTap: vm.toggleObscure,
                      child: vm.obscureText
                          ? SvgPicture.asset(Assets.imagesHidePassword)
                          : SvgPicture.asset(Assets.imagesShowPassword),
                    )
                  : SvgPicture.asset(Assets.imagesPasswordIcon),
            ),
          ),
        ),
      ),
    );
  }
}
