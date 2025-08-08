import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/theme/app_colors.dart';

class CustomAppointmentCardInfo extends StatelessWidget {
  const CustomAppointmentCardInfo({
    super.key,
    required this.doctorName,
    required this.specialization,
    required this.address,
    required this.image,
  });
  final String doctorName, specialization, address, image;
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
            height: width * 0.22,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.fitHeight,
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
                  doctorName,
                  style: AppStyles.almaraiBold(
                    context,
                  ).copyWith(fontSize: 16, color: AppColors.textPrimary),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  specialization,
                  style: AppStyles.almaraiBold(
                    context,
                  ).copyWith(fontSize: 13, color: AppColors.textPrimary),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  address,
                  style: AppStyles.almaraiBold(
                    context,
                  ).copyWith(fontSize: 13, color: AppColors.textPrimary),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
