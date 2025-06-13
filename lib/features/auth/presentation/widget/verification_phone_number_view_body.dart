import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/viewmodels/resend_otp_view_model.dart';
import 'package:oxytocin/core/widgets/custom_button.dart';
import 'package:oxytocin/core/widgets/otp_field.dart';
import 'package:oxytocin/core/widgets/resend_otp.dart';
import 'package:oxytocin/core/widgets/sliver_spacer.dart';
import 'package:oxytocin/features/auth/presentation/widget/change_wrong_number.dart';
import 'package:provider/provider.dart';

class VerificationPhoneNumberViewBody extends StatelessWidget {
  const VerificationPhoneNumberViewBody({super.key});

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
          SliverSpacer(height: height * 0.05),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Image.asset(
                Assets.imagesVerification,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          SliverSpacer(height: height * 0.01),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                context.tr.otpSentMessage,
                textAlign: TextAlign.center,
                style: AppStyles.almaraiBold(
                  context,
                ).copyWith(fontSize: 20, color: AppColors.kPrimaryColor1),
              ),
            ),
          ),
          SliverSpacer(height: height * 0.05),
          SliverToBoxAdapter(child: OtpField(controller: otpController)),
          SliverToBoxAdapter(
            child: ChangeNotifierProvider(
              create: (_) => ResendOtpViewModel()..startTimer(),
              child: const ResendOtp(),
            ),
          ),
          SliverSpacer(height: height * 0.15),
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
