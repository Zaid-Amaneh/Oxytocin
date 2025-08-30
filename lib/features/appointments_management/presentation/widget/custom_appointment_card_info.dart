import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/features/appointments_management/data/models/appointment_model.dart';

class CustomAppointmentCardInfo extends StatelessWidget {
  const CustomAppointmentCardInfo({super.key, required this.clinic});
  final ClinicModel clinic;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            width: width * 0.22,
            height: width * 0.24,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: NetworkImage(clinic.doctor.user.image ?? ""),
                fit: BoxFit.fitWidth,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                Text(
                  clinic.doctor.user.fullName,
                  style: AppStyles.almaraiBold(
                    context,
                  ).copyWith(fontSize: 16, color: AppColors.textPrimary),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  Helper.isArabic(context)
                      ? clinic.doctor.mainSpecialty.specialty.nameAr
                      : clinic.doctor.mainSpecialty.specialty.nameEn,
                  style: AppStyles.almaraiBold(
                    context,
                  ).copyWith(fontSize: 13, color: AppColors.textPrimary),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  clinic.address,
                  style: AppStyles.almaraiBold(
                    context,
                  ).copyWith(fontSize: 13, color: AppColors.textPrimary),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
