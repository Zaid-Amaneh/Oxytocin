import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/routing/navigation_service.dart';
import 'package:oxytocin/core/routing/route_names.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/widgets/custom_button.dart';
import 'package:oxytocin/core/widgets/otp_field.dart';
import 'package:oxytocin/core/widgets/sliver_spacer.dart';
import 'package:oxytocin/extensions/failure_localization.dart';
import 'package:oxytocin/features/auth/data/models/verify_otp_request.dart';
import 'package:oxytocin/features/auth/presentation/viewmodels/blocs/verifyForgotPasswordOtp/verify_forgot_password_otp_bloc.dart';
import 'package:oxytocin/features/auth/presentation/widget/change_wrong_number.dart';
import 'package:oxytocin/features/auth/presentation/widget/forgot_password_view_header.dart';
import 'package:oxytocin/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class ForgotPasswordVerificationViewBody extends StatelessWidget {
  const ForgotPasswordVerificationViewBody({super.key, this.phoneNumber});
  final dynamic phoneNumber;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final height = size.height;
    var formKey = GlobalKey<FormState>();
    final TextEditingController otpController = TextEditingController();
    return BlocConsumer<
      VerifyForgotPasswordOtpBloc,
      VerifyForgotPasswordOtpState
    >(
      listener: (context, state) {
        if (state is VerifyForgotPasswordOtpLoading) {
          Helper.showCircularProgressIndicator(context);
        } else if (state is VerifyForgotPasswordOtpSuccess) {
          context.pop();
          Helper.customToastification(
            title: context.tr.otpVerifiedSuccessfullyTitle,
            description: context.tr.otpVerifiedSuccessfully,
            context: context,
            type: ToastificationType.success,
            seconds: 5,
          );
          NavigationService nav = NavigationService();
          nav.pushToNamed(RouteNames.resetPassword);
        } else if (state is VerifyForgotPasswordOtpFailure) {
          context.pop();
          final message = AppLocalizations.of(context)!.invalidOtpCodeTitle;
          Helper.customToastification(
            context: context,
            type: ToastificationType.error,
            title: message,
            description: context.tr.invalidOtpCode,
            seconds: 5,
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: ForgotPasswordViewHeader(
                  icon: AppImages.imagesSendOTPIcon,
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
              // SliverToBoxAdapter(
              //   child: ChangeNotifierProvider(
              //     create: (_) => ResendOtpViewModel()..startTimer(),
              //     child: ResendOtp(request: ResendOtpRequest(phone: 'phone')),
              //   ),
              // ),
              SliverSpacer(height: height * 0.24),
              SliverToBoxAdapter(
                child: CustomButton(
                  borderRadius: 25,
                  onTap: () {
                    VerifyOtpRequest request = VerifyOtpRequest(
                      phone: phoneNumber,
                      code: otpController.text,
                    );
                    if (formKey.currentState!.validate()) {
                      context.read<VerifyForgotPasswordOtpBloc>().add(
                        SubmitForgotPasswordOtp(request),
                      );
                    } else {}
                  },
                  borderColor: AppColors.kPrimaryColor1,
                  data: context.tr.sendOtpButton,
                  style: AppStyles.almaraiBold(context),
                  visible: true,
                  padding: const EdgeInsetsGeometry.all(18),
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
