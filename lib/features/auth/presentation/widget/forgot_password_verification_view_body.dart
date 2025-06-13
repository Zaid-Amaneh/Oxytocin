import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/routing/navigation_service.dart';
import 'package:oxytocin/core/routing/route_names.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/viewmodels/resend_otp_view_model.dart';
import 'package:oxytocin/core/widgets/custom_button.dart';
import 'package:oxytocin/core/widgets/otp_field.dart';
import 'package:oxytocin/core/widgets/resend_otp.dart';
import 'package:oxytocin/core/widgets/sliver_spacer.dart';
import 'package:oxytocin/features/auth/presentation/widget/change_wrong_number.dart';
import 'package:oxytocin/features/auth/presentation/widget/forgot_password_view_header.dart';
import 'package:provider/provider.dart';

class ForgotPasswordVerificationViewBody extends StatelessWidget {
  const ForgotPasswordVerificationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final height = size.height;
    var formKey = GlobalKey<FormState>();
    final TextEditingController otpController = TextEditingController();
    return Form(
      key: formKey,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ForgotPasswordViewHeader(
              icon: Assets.imagesSendOTPIcon,
              title: context.tr.otpSentSuccess,
            ),
          ),
          SliverSpacer(height: height * 0.1),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 5, 18, 0),
              child: Text(
                context.tr.otpSentMessageForgot,
                style: AppStyles.almaraiBold(
                  context,
                ).copyWith(color: AppColors.textSecondary, fontSize: 14),
              ),
            ),
          ),
          SliverSpacer(height: height * 0.02),
          SliverToBoxAdapter(child: OtpField(controller: otpController)),
          SliverToBoxAdapter(
            child: ChangeNotifierProvider(
              create: (_) => ResendOtpViewModel()..startTimer(),
              child: const ResendOtp(),
            ),
          ),
          SliverSpacer(height: height * 0.24),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomButton(
                borderRadius: 25,
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    NavigationService navigationService = NavigationService();
                    navigationService.pushToNamed(RouteNames.resetPassword);
                  } else {}
                },
                borderColor: AppColors.kPrimaryColor1,
                data: context.tr.sendOtpButton,
                style: AppStyles.almaraiBold(context),
                visible: true,
                padding: const EdgeInsetsGeometry.all(18),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: ChangeWrongNumber()),
        ],
      ),
    );
  }
}
