import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/Utils/size_config.dart';
import 'package:oxytocin/core/routing/route_names.dart';

class CongratsView extends StatefulWidget {
  const CongratsView({super.key});

  @override
  State<CongratsView> createState() => _CongratsViewState();
}

class _CongratsViewState extends State<CongratsView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.goNamed(RouteNames.home);
      }
    });
  }

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
