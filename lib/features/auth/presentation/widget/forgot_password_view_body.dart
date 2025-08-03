import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/routing/navigation_service.dart';
import 'package:oxytocin/core/routing/route_names.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/viewmodels/phone_view_model.dart';
import 'package:oxytocin/core/widgets/custom_button.dart';
import 'package:oxytocin/core/widgets/phone_number_field.dart';
import 'package:oxytocin/core/widgets/sliver_spacer.dart';
import 'package:oxytocin/extensions/failure_localization.dart';
import 'package:oxytocin/features/auth/presentation/viewmodels/blocs/forgotPassword/forgot_password_bloc.dart';
import 'package:oxytocin/features/auth/presentation/widget/forgot_password_view_header.dart';
import 'package:oxytocin/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class ForgotPasswordViewBody extends StatelessWidget {
  const ForgotPasswordViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    final PhoneViewModel phoneViewModel = PhoneViewModel();
    final size = MediaQuery.sizeOf(context);
    final height = size.height;
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordLoading) {
          Helper.showCircularProgressIndicator(context);
        } else if (state is ForgotPasswordSuccess) {
          context.pop();
          Helper.customToastification(
            title: context.tr.resendOtpSuccessTitle,
            description: context.tr.resendOtpSuccess,
            context: context,
            type: ToastificationType.success,
            seconds: 5,
          );
          NavigationService nav = NavigationService();
          nav.pushToNamedWithParams(
            RouteNames.forgotPasswordverification,
            queryParams: {'phoneNumber': phoneViewModel.phoneController.text},
          );
        } else if (state is ForgotPasswordFailure) {
          context.pop();
          final message = AppLocalizations.of(context)!.errorUnknown;
          Helper.customToastification(  
            context: context,
            type: ToastificationType.error,
            title: context.tr.operationFailedTitle,
            description: message,
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
                  icon: Assets.imagesForgotPasswordIcon,
                  title: context.tr.forgotPasswordPrompt,
                ),
              ),
              SliverSpacer(height: height * 0.1),
              SliverToBoxAdapter(
                child: ChangeNotifierProvider(
                  create: (_) => phoneViewModel,
                  child: const PhoneNumberField(),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 5, 18, 0),
                  child: Text(
                    context.tr.enterPhoneHint,
                    style: AppStyles.almaraiBold(
                      context,
                    ).copyWith(color: AppColors.textSecondary, fontSize: 14),
                  ),
                ),
              ),
              SliverSpacer(height: height * 0.2),
              SliverToBoxAdapter(
                child: CustomButton(
                  borderRadius: 25,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      context.read<ForgotPasswordBloc>().add(
                        SendPhoneNumberEvent(
                          phoneViewModel.phoneController.text,
                        ),
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
            ],
          ),
        );
      },
    );
  }
}
