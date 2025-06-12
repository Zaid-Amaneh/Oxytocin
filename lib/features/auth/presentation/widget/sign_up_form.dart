import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/viewmodels/name_view_model.dart';
import 'package:oxytocin/core/viewmodels/password_view_model.dart';
import 'package:oxytocin/core/viewmodels/phone_view_model.dart';
import 'package:oxytocin/core/widgets/confirm_password_field.dart';
import 'package:oxytocin/core/widgets/custom_button.dart';
import 'package:oxytocin/core/widgets/name_field.dart';
import 'package:oxytocin/core/widgets/password_field.dart';
import 'package:oxytocin/core/widgets/phone_number_field.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    var numberForm = GlobalKey<FormState>();
    final firstNameVM = NameViewModel();
    final lastNameVM = NameViewModel();
    final phoneNumberVM = PhoneViewModel();
    final passwordVM = PasswordViewModel();

    return Form(
      key: numberForm,
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        width: width,
        height: height,
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Color(0xFFC9C9C9)),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
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
            SliverToBoxAdapter(child: SizedBox(height: height * 0.2)),
            SliverToBoxAdapter(
              child: ChangeNotifierProvider<NameViewModel>(
                create: (_) => firstNameVM,
                child: NameField(fieldName: context.tr.Username),
              ),
            ),
            SliverToBoxAdapter(
              child: ChangeNotifierProvider<NameViewModel>(
                create: (_) => lastNameVM,
                child: NameField(fieldName: context.tr.Lastname),
              ),
            ),
            SliverToBoxAdapter(
              child: ChangeNotifierProvider<PasswordViewModel>(
                create: (_) => passwordVM,
                child: PasswordField(
                  nameController: firstNameVM.nameController,
                  lastNameController: lastNameVM.nameController,
                  phoneController: phoneNumberVM.phoneController,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: ChangeNotifierProvider<PasswordViewModel>(
                create: (_) => PasswordViewModel(),
                child: ConfirmPasswordField(
                  passwordController: passwordVM.passwordController,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: ChangeNotifierProvider<PhoneViewModel>(
                create: (_) => phoneNumberVM,
                child: const PhoneNumberField(),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: height * 0.02)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomButton(
                  borderRadius: 25,
                  onTap: () {
                    if (numberForm.currentState!.validate()) {
                    } else {}
                  },
                  borderColor: AppColors.kPrimaryColor1,
                  data: context.tr.SignUp,
                  style: AppStyles.almaraiBold(context),
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
