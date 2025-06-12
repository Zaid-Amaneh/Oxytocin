import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/routing/navigation_service.dart';
import 'package:oxytocin/core/routing/route_names.dart';
import 'package:oxytocin/core/theme/app_colors.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigationService navigationService = NavigationService();
        navigationService.pushToNamed(RouteNames.forgotPassword);
      },
      child: Text(
        context.tr.Forgotyourpassword,
        style: AppStyles.tajawalBold(
          context,
        ).copyWith(color: AppColors.kPrimaryColor3, fontSize: 15),
        textAlign: TextAlign.center,
      ),
    );
  }
}
