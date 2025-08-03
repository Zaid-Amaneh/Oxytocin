import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/web.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/routing/route_names.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/viewmodels/resend_otp_view_model.dart';
import 'package:oxytocin/core/widgets/custom_button.dart';
import 'package:oxytocin/core/widgets/otp_field.dart';
import 'package:oxytocin/core/widgets/resend_otp.dart';
import 'package:oxytocin/core/widgets/sliver_spacer.dart';
import 'package:oxytocin/extensions/failure_localization.dart';
import 'package:oxytocin/features/auth/data/models/resend_otp_request.dart';
import 'package:oxytocin/features/auth/data/models/verify_otp_request.dart';
import 'package:oxytocin/features/auth/presentation/viewmodels/blocs/verification/otp_bloc.dart';
import 'package:oxytocin/features/auth/presentation/widget/change_wrong_number.dart';
import 'package:oxytocin/l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class VerificationPhoneNumberViewBody extends StatelessWidget {
  final dynamic phoneNumber;

  const VerificationPhoneNumberViewBody({super.key, this.phoneNumber});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final height = size.height;
    var formKey = GlobalKey<FormState>();
    final TextEditingController otpController = TextEditingController();

    return BlocConsumer<OtpBloc, OtpState>(
      listener: (context, state) {
        if (state is OtpLoading) {
          Helper.showCircularProgressIndicator(context);
        } else if (state is OtpFailure) {
          context.pop();
          Logger logger = Logger();
          logger.f(state.error);
          final message = AppLocalizations.of(context)!.invalidOtpCodeTitle;
          Helper.customToastification(
            context: context,
            type: ToastificationType.error,
            title: message,
            description: context.tr.invalidOtpCodeTitle,
            seconds: 5,
          );
        } else if (state is OtpSuccess) {
          context.pop();
          Helper.customToastification(
            title: context.tr.otpVerifiedSuccessfullyTitle,
            description: context.tr.otpVerifiedSuccessfully,
            context: context,
            type: ToastificationType.success,
            seconds: 5,
          );
        } else if (state is OtpResendSuccess) {
          context.pop();
          Helper.customToastification(
            title: context.tr.resendOtpSuccessTitle,
            description: context.tr.resendOtpSuccess,
            context: context,
            type: ToastificationType.success,
            seconds: 5,
          );
        } else {
          context.pop();
          Helper.customToastification(
            title: context.tr.resendOtpFailedTitle,
            description: context.tr.resendOtpFailed,
            context: context,
            type: ToastificationType.error,
            seconds: 5,
          );
        }
      },
      builder: (context, state) {
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
                  child: ResendOtp(
                    request: ResendOtpRequest(phone: phoneNumber),
                  ),
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
                        VerifyOtpRequest request = VerifyOtpRequest(
                          phone: phoneNumber!,
                          code: otpController.text,
                        );
                        context.read<OtpBloc>().add(OtpSubmitted(request));
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
      },
    );
  }
}
