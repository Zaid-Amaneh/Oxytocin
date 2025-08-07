import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/routing/route_names.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/Utils/size_config.dart';
import 'package:oxytocin/features/auth_complete/presentation/widget/profile_action_button.dart';
import 'package:oxytocin/core/constants/app_constants.dart';

class UploadProfilePhoto extends StatelessWidget {
  const UploadProfilePhoto({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: SizeConfig.screenHigh * 0.05),
              Text(
                'أضف لمستك الشخصية',
                style: AppStyles.almaraiBold(context).copyWith(
                  color: AppColors.kPrimaryColor1,
                  fontSize: getResponsiveFontSize(context, fontSize: 20),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHigh * 0.01),
              Text(
                'يرجى رفع صورتك.',
                style: AppStyles.almaraiBold(context).copyWith(
                  color: AppColors.kPrimaryColor1,
                  fontSize: getResponsiveFontSize(context, fontSize: 16),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHigh * 0.08),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset(
                  AppImages.uploadPhoto,
                  fit: BoxFit.contain,
                  height: SizeConfig.screenWidth * 0.8,
                  width: SizeConfig.screenWidth * 0.8,
                ),
              ),
              SizedBox(height: SizeConfig.screenHigh * 0.015),

              Padding(
                padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.25),
                child: Text(
                  'يفضل أن تكون الصورة واضحة  \n وحديثة، وتظهر الوجه بوضوح.',
                  style: AppStyles.almaraiBold(context).copyWith(
                    color: AppColors.textSecondary,
                    fontSize: getResponsiveFontSize(context, fontSize: 13),
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              SizedBox(height: SizeConfig.screenHigh * 0.2),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.06,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ProfileActionButton(
                        text: 'التالي',
                        onPressed: () {
                          context.pushNamed(RouteNames.setLocation);
                        },
                        filled: true,
                        borderRadius: AppConstants.borderRadiusCircular,
                        fontSize: getResponsiveFontSize(context, fontSize: 16),
                      ),
                    ),
                    SizedBox(width: SizeConfig.screenWidth * 0.04),
                    Expanded(
                      child: ProfileActionButton(
                        text: 'عودة',
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        filled: false,
                        borderRadius: AppConstants.borderRadiusCircular,
                        fontSize: getResponsiveFontSize(context, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.screenHigh * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
