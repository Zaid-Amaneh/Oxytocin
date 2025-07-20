import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/routing/navigation_service.dart';
import 'package:oxytocin/core/routing/route_names.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/viewmodels/password_view_model.dart';
import 'package:oxytocin/core/widgets/confirm_password_field.dart';
import 'package:oxytocin/core/widgets/custom_button.dart';
import 'package:oxytocin/core/widgets/password_field.dart';
import 'package:oxytocin/core/widgets/sliver_spacer.dart';
import 'package:oxytocin/extensions/failure_localization.dart';
import 'package:oxytocin/features/auth/data/models/change_password_request.dart';
import 'package:oxytocin/features/auth/presentation/viewmodels/blocs/changePassword/change_password_bloc.dart';
import 'package:oxytocin/features/auth/presentation/widget/forgot_password_view_header.dart';
import 'package:oxytocin/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

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
    return BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordLoading) {
          Helper.showCircularProgressIndicator(context);
        } else if (state is ChangePasswordSuccess) {
          context.pop();
          Helper.customToastification(
            title: context.tr.operation_successful_title,
            description: context.tr.changePasswordSuccess,
            context: context,
            type: ToastificationType.success,
            seconds: 5,
          );
          NavigationService nav = NavigationService();
          nav.goToNamed(RouteNames.signIn);
        } else if (state is ChangePasswordFailure) {
          context.pop();
          final message = S.of(context).getTranslatedError(state.error);
          Helper.customToastification(
            context: context,
            type: ToastificationType.error,
            title: message,
            description: context.tr.changePasswordFailure,
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
                child: CustomButton(
                  borderRadius: 25,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      ChangePasswordRequest request = ChangePasswordRequest(
                        newPassword: password.passwordController.text,
                      );
                      context.read<ChangePasswordBloc>().add(
                        SubmitChangePassword(request),
                      );
                    } else {}
                  },
                  borderColor: AppColors.kPrimaryColor1,
                  data: context.tr.changePasswordTitle,
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
