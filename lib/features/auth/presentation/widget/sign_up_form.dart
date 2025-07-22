import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/routing/navigation_service.dart';
import 'package:oxytocin/core/routing/route_names.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/viewmodels/name_view_model.dart';
import 'package:oxytocin/core/viewmodels/password_view_model.dart';
import 'package:oxytocin/core/viewmodels/phone_view_model.dart';
import 'package:oxytocin/core/widgets/confirm_password_field.dart';
import 'package:oxytocin/core/widgets/custom_button.dart';
import 'package:oxytocin/core/widgets/name_field.dart';
import 'package:oxytocin/core/widgets/password_field.dart';
import 'package:oxytocin/core/widgets/phone_number_field.dart';
import 'package:oxytocin/core/widgets/sliver_spacer.dart';
import 'package:oxytocin/extensions/failure_localization.dart';
import 'package:oxytocin/features/auth/data/models/sign_up_request.dart';
import 'package:oxytocin/features/auth/presentation/viewmodels/blocs/signUp/sign_up_bloc.dart';
import 'package:oxytocin/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

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
    var formKey = GlobalKey<FormState>();
    final firstNameVM = NameViewModel();
    final lastNameVM = NameViewModel();
    final phoneNumberVM = PhoneViewModel();
    final passwordVM = PasswordViewModel();

    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpLoading) {
          Helper.showCircularProgressIndicator(context);
        } else if (state is SignUpSuccess) {
          context.pop();
          Helper.customToastification(
            title: context.tr.operation_successful_title,
            description: context.tr.account_created_success,
            context: context,
            type: ToastificationType.success,
            seconds: 5,
          );
          NavigationService navigationService = NavigationService();
          navigationService.pushToNamedWithParams(
            RouteNames.verificationPhoneNumber,
            queryParams: {'phoneNumber': phoneNumberVM.phoneController.text},
          );
        } else if (state is SignUpFailure) {
          context.pop();
          Logger logger = Logger();
          logger.f(state.error);
          final message = S.of(context).getTranslatedError(state.error);
          Helper.customToastification(
            context: context,
            type: ToastificationType.error,
            title: context.tr.sign_up_failure_title,
            description: message,
            seconds: 5,
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
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
                SliverSpacer(height: height * 0.2),

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
                SliverSpacer(height: height * 0.02),
                SliverToBoxAdapter(
                  child: CustomButton(
                    borderRadius: 25,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        final request = SignUpRequest(
                          firstName: firstNameVM.nameController.text,
                          lastName: lastNameVM.nameController.text,
                          phone: phoneNumberVM.phoneController.text,
                          password: passwordVM.passwordController.text,
                          confirmPassword: passwordVM.passwordController.text,
                        );
                        context.read<SignUpBloc>().add(
                          SignUpSubmitted(request),
                        );
                        print('==========================');
                        print(request);
                        print(firstNameVM.nameController.text);
                        print(lastNameVM.nameController.text);
                        print(phoneNumberVM.phoneController.text);
                        print(passwordVM.passwordController.text);
                        print(passwordVM.passwordController.text);
                      }
                    },
                    borderColor: AppColors.kPrimaryColor1,
                    data: context.tr.SignUp,
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
