import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/widgets/custom_button.dart';
import 'package:oxytocin/core/widgets/password_field.dart';
import 'package:oxytocin/core/widgets/phone_number_field.dart';
import 'package:oxytocin/features/auth/presentation/widget/custom_switch.dart';
import 'package:oxytocin/features/auth/presentation/widget/forgot_password.dart';
import 'package:oxytocin/features/auth/presentation/widget/remember_me.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    var numberForm = GlobalKey<FormState>();
    return Form(
      key: numberForm,
      child: Container(
        width: width,
        height: height,
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Color(0xFFC9C9C9)),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            ),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4.10,
              offset: Offset(0, 4),
              spreadRadius: 6,
            ),
          ],
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: height * 0.04)),
            const SliverToBoxAdapter(child: CustomSwitch(inup: true)),
            SliverToBoxAdapter(child: SizedBox(height: height * 0.04)),
            const SliverToBoxAdapter(child: PhoneNumberField()),
            const SliverToBoxAdapter(child: PasswordField()),
            const SliverToBoxAdapter(child: ForgotPassword()),
            SliverToBoxAdapter(child: SizedBox(height: height * 0.06)),
            const SliverToBoxAdapter(child: RememberMe()),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomButton(
                  borderRadius: 25,
                  onTap: () {
                    if (numberForm.currentState!.validate()) {
                      log('2');
                    } else {
                      log('0');
                    }
                  },
                  borderColor: AppColors.kPrimaryColor1,
                  data: context.tr.SignIn,
                  style: AppStyles.almaraiBold(context).copyWith(),
                  visible: true,
                  padding: const EdgeInsetsGeometry.all(18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
