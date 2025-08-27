import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';

class ErrorDisplayWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;

  const ErrorDisplayWidget({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red[400], size: 120),
            const SizedBox(height: 20),
            Text(
              context.tr.error,
              style: AppStyles.almaraiBold(
                context,
              ).copyWith(color: AppColors.kPrimaryColor1),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              context.tr.errorOccurred,
              style: AppStyles.almaraiRegular(
                context,
              ).copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onRetry,
              child: Text(
                context.tr.retry,
                style: AppStyles.almaraiBold(
                  context,
                ).copyWith(color: AppColors.kPrimaryColor1, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
