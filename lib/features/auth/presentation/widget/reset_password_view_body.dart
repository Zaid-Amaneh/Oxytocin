import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/viewmodels/password_view_model.dart';
import 'package:oxytocin/core/widgets/confirm_password_field.dart';
import 'package:oxytocin/core/widgets/custom_button.dart';
import 'package:oxytocin/core/widgets/password_field.dart';
import 'package:oxytocin/core/widgets/sliver_spacer.dart';
import 'package:oxytocin/features/auth/presentation/widget/forgot_password_view_header.dart';
import 'package:provider/provider.dart';

class ResetPasswordViewBody extends StatelessWidget {
  const ResetPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final PasswordViewModel password = PasswordViewModel(),
        confirmPassword = PasswordViewModel();
    final size = MediaQuery.sizeOf(context);
    // final width = size.width;
    final height = size.height;
    var formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ForgotPasswordViewHeader(
              icon: Assets.imagesResetPasswordIcon,
              title: context.tr.newPasswordSlogan,
            ),
          ),
          SliverSpacer(height: height * 0.1),
          SliverToBoxAdapter(
            child: ChangeNotifierProvider(
              create: (_) => password,
              child: const PasswordField(),
            ),
          ),
          SliverToBoxAdapter(
            child: ChangeNotifierProvider(
              create: (_) => confirmPassword,
              child: ConfirmPasswordField(
                passwordController: password.passwordController,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: Text(
                context.tr.changePasswordSubtitle,
                style: AppStyles.almaraiBold(
                  context,
                ).copyWith(color: AppColors.textSecondary, fontSize: 16),
              ),
            ),
          ),
          SliverSpacer(height: height * 0.1),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomButton(
                borderRadius: 25,
                onTap: () {
                  if (formKey.currentState!.validate()) {
                  } else {}
                },
                borderColor: AppColors.kPrimaryColor1,
                data: context.tr.changePasswordTitle,
                style: AppStyles.almaraiBold(context),
                visible: true,
                padding: const EdgeInsetsGeometry.all(18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
