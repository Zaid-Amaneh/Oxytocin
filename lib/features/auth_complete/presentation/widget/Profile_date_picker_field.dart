import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/constants/app_constants.dart';

class ProfileDatePickerField extends StatelessWidget {
  final String label;
  final DateTime? selectedDate;
  final VoidCallback onTap;
  final String? errorText;

  const ProfileDatePickerField({
    super.key,
    required this.label,
    required this.selectedDate,
    required this.onTap,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DecoratedBox(
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 1,
                  color: AppColors.textfieldBorder,
                ),
                borderRadius: BorderRadius.circular(
                  AppConstants.borderRadiusCircular,
                ),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: ListTile(
              onTap: onTap,
              leading: const Icon(
                Icons.cake_rounded,
                color: Color.fromARGB(255, 205, 205, 206),
              ),
              title: Text(
                selectedDate == null
                    ? label
                    : '${selectedDate!.year}/${selectedDate!.month.toString().padLeft(2, '0')}/${selectedDate!.day.toString().padLeft(2, '0')}',
                style: AppStyles.almaraiBold(context).copyWith(
                  color: selectedDate == null
                      ? AppColors.textPrimary
                      : AppColors.kPrimaryColor1,
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                ),
              ),
              trailing: const Icon(
                Icons.calendar_month_rounded,
                color: AppColors.kPrimaryColor1,
              ),
            ),
          ),
          if (errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 4, right: 8),
              child: Text(
                errorText!,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}
