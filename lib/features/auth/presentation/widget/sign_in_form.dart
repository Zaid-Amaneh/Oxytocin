import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/web.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/viewmodels/password_view_model.dart';
import 'package:oxytocin/core/viewmodels/phone_view_model.dart';
import 'package:oxytocin/core/widgets/custom_button.dart';
import 'package:oxytocin/core/widgets/password_field.dart';
import 'package:oxytocin/core/widgets/phone_number_field.dart';
import 'package:oxytocin/core/widgets/sliver_spacer.dart';
import 'package:oxytocin/extensions/failure_localization.dart';
import 'package:oxytocin/features/auth/data/models/sign_in_request.dart';
import 'package:oxytocin/features/auth/presentation/viewmodels/blocs/signIn/sign_in_bloc.dart';
import 'package:oxytocin/features/auth/presentation/widget/forgot_password.dart';
import 'package:oxytocin/features/auth/presentation/widget/remember_me.dart';
import 'package:oxytocin/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final phoneNumberVM = PhoneViewModel();
  final passwordVM = PasswordViewModel();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInLoading) {
          Helper.showCircularProgressIndicator(context);
        } else if (state is SignInSuccess) {
          context.pop();
          Helper.customToastification(
            title: context.tr.operation_successful_title,
            description: context.tr.sign_in_success_message,
            context: context,
            type: ToastificationType.success,
            seconds: 5,
          );
        } else if (state is SignInFailure) {
          context.pop();
          Logger logger = Logger();
          logger.f(state.error);
          final message = S.of(context).getTranslatedError(state.error);
          Helper.customToastification(
            context: context,
            type: ToastificationType.error,
            title: context.tr.error_invalid_credentials_title,
            description: message,
            seconds: 5,
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
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
                SliverSpacer(height: height * 0.2),
                SliverToBoxAdapter(
                  child: ChangeNotifierProvider<PhoneViewModel>(
                    create: (_) => phoneNumberVM,
                    child: const PhoneNumberField(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: ChangeNotifierProvider<PasswordViewModel>(
                    create: (_) => passwordVM,
                    child: const PasswordField(),
                  ),
                ),
                const SliverToBoxAdapter(child: ForgotPassword()),
                SliverSpacer(height: height * 0.06),
                const SliverToBoxAdapter(child: RememberMe()),
                SliverToBoxAdapter(
                  child: CustomButton(
                    borderRadius: 25,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        final request = SignInRequest(
                          phone: phoneNumberVM.phoneController.text,
                          password: passwordVM.passwordController.text,
                        );
                        Logger().d(request.password);
                        Logger().d(request.phone);
                        context.read<SignInBloc>().add(
                          SignInSubmitted(request),
                        );
                      }
                    },
                    borderColor: AppColors.kPrimaryColor1,
                    data: context.tr.SignIn,
                    style: AppStyles.almaraiBold(context),
                    visible: true,
                    padding: const EdgeInsetsGeometry.all(18),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
