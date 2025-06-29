import 'package:flutter/material.dart';
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
import 'package:oxytocin/features/auth/presentation/widget/forgot_password_view_header.dart';
import 'package:provider/provider.dart';

class ForgotPasswordViewBody extends StatelessWidget {
  const ForgotPasswordViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    final PhoneViewModel phoneViewModel = PhoneViewModel();
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
                  NavigationService navigationService = NavigationService();
                  navigationService.pushToNamed(
                    RouteNames.forgotPasswordverification,
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
  }
}
