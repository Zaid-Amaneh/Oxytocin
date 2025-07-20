import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/viewmodels/resend_otp_view_model.dart';
import 'package:oxytocin/features/auth/data/models/resend_otp_request.dart';
import 'package:oxytocin/features/auth/presentation/viewmodels/blocs/verification/otp_bloc.dart';
import 'package:provider/provider.dart';

class ResendOtp extends StatelessWidget {
  final ResendOtpRequest request;
  const ResendOtp({super.key, required this.request});
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ResendOtpViewModel>();

    if (vm.canResend) {
      return Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18, top: 5),
        child: Row(
          spacing: 10,
          children: [
            Text(
              context.tr.didNotReceiveCode,
              style: AppStyles.almaraiBold(
                context,
              ).copyWith(color: AppColors.textSecondary, fontSize: 14),
            ),
            GestureDetector(
              onTap: () {
                vm.resendOtp();
                context.read<OtpBloc>().add(OtpResendRequested(request));
              },
              child: Text(
                context.tr.resend,
                style: AppStyles.almaraiBold(context).copyWith(
                  color: AppColors.kPrimaryColor1,
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      final timeStr = context.tr.resendCountdown(vm.secondsLeft);
      return Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, top: 5),
        child: Text(
          timeStr,
          style: AppStyles.almaraiBold(
            context,
          ).copyWith(color: AppColors.textSecondary, fontSize: 14),
        ),
      );
    }
  }
}
