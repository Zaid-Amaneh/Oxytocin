import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/Utils/size_config.dart';
import 'package:oxytocin/l10n/app_localizations.dart';

class CongratsView extends StatelessWidget {
  const CongratsView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth * 0.06,
            vertical: SizeConfig.screenHigh * 0.04,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: SizeConfig.screenHigh * 0.08),
                Text(
                  // "تهانينا! لقد أتممت إنشاء حسابك بنجاح",
                  context.tr.congratsTitle,
                  textAlign: TextAlign.center,
                  style: AppStyles.almaraiBold(context).copyWith(
                    fontSize: getResponsiveFontSize(context, fontSize: 24),
                    color: AppColors.kPrimaryColor1,
                  ),
                ),
                SizedBox(height: SizeConfig.screenHigh * 0.04),
                Image.asset(
                  AppImages.congrats,
                  width: SizeConfig.screenWidth * 0.7,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: SizeConfig.screenHigh * 0.04),
                Text(
                  'خطوتك الأولى نحو عناية صحية متكاملة تبدأ الآن',
                  textAlign: TextAlign.center,
                  style: AppStyles.almaraiBold(context).copyWith(
                    fontSize: getResponsiveFontSize(context, fontSize: 20),
                    color: AppColors.kPrimaryColor1,
                  ),
                ),
                SizedBox(height: SizeConfig.screenHigh * 0.10),
                Text(
                  'نقوم بإعداد كل شيء لك الآن...',
                  style: AppStyles.almaraiRegular(context).copyWith(
                    fontSize: getResponsiveFontSize(context, fontSize: 16),
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: SizeConfig.screenHigh * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
