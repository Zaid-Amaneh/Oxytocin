import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toastification/toastification.dart';

class Helper {
  static bool isArabic(BuildContext context) {
    String currentLangCode = Localizations.localeOf(context).languageCode;
    return currentLangCode == 'ar';
  }

  static ToastificationItem customToastification({
    required BuildContext context,
    required ToastificationType type,
    required String title,
    required String description,
    required int seconds,
  }) {
    return toastification.show(
      context: context,
      type: type,
      style: ToastificationStyle.fillColored,
      title: Text(
        title,
        style: AppStyles.almaraiBold(context).copyWith(fontSize: 15),
      ),
      description: Text(
        description,
        style: AppStyles.almaraiBold(context).copyWith(fontSize: 12),
      ),
      alignment: Alignment.topCenter,
      showProgressBar: true,
      dragToClose: true,
      boxShadow: highModeShadow,
      borderRadius: BorderRadius.circular(12.0),
      autoCloseDuration: Duration(seconds: seconds),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  static showCircularProgressIndicator(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        double width = MediaQuery.of(context).size.width;
        return Center(
          child: Lottie.asset(
            width: 0.35 * width,
            'assets/lottie/LoadindIndicator.json',
          ),
        );
      },
    );
  }

  static Widget buildShimmerBox({
    required double width,
    required double height,
    int count = 2,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 16,
          children: List.generate(
            count,
            (index) => Container(
              width: width,
              height: height,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension LocalizationExt on BuildContext {
  AppLocalizations get tr => AppLocalizations.of(this)!;
}
