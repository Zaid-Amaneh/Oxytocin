import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';

void showEditAppointmentBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.tr.edit,
              style: AppStyles.cairoExtraBold(
                context,
              ).copyWith(color: AppColors.textPrimary, fontSize: 20),
            ),
            const SizedBox(height: 12),
            const Divider(color: Colors.grey),
            ListTile(
              leading: SvgPicture.asset(
                height: 24,
                width: 24,
                AppImages.editIcon,
                colorFilter: const ColorFilter.mode(
                  AppColors.textSecondary,
                  BlendMode.srcIn,
                ),
              ),
              title: Text(
                context.tr.reschedule,
                style: AppStyles.cairoExtraBold(
                  context,
                ).copyWith(color: AppColors.textSecondary, fontSize: 16),
              ),
              onTap: () {},
            ),
            const Divider(color: Colors.grey),
            ListTile(
              leading: SvgPicture.asset(
                height: 22,
                width: 22,

                AppImages.canceledIcon,
              ),
              title: Text(
                context.tr.cancelReservation,
                style: AppStyles.cairoExtraBold(
                  context,
                ).copyWith(color: const Color(0xffEF3039), fontSize: 16),
              ),
              onTap: () {
                // Handle cancellation
              },
            ),
            const Divider(color: Colors.grey),
          ],
        ),
      );
    },
  );
}
