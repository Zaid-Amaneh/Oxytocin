import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/routing/navigation_service.dart';
import 'package:oxytocin/core/routing/route_names.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/features/appointments_management/data/models/appointment_model.dart';
import 'package:oxytocin/features/appointments_management/presentation/viewmodels/management_appointments_cubit.dart';

void showEditAppointmentBottomSheet(
  BuildContext context,
  ManagementAppointmentsCubit cubit,
  int id,
  AppointmentModel appointmentModel,
) {
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
              onTap: () {
                NavigationService().pushToNamedWithParams(
                  RouteNames.reAppointment,
                  extra: {
                    'id': appointmentModel.clinic.doctor.user.id,
                    'appointmentId': id,
                  },
                );
              },
            ),
            const Divider(color: Colors.grey),
            ListTile(
              leading: SvgPicture.asset(
                height: 22,
                width: 22,
                colorFilter: const ColorFilter.mode(
                  AppColors.textSecondary,
                  BlendMode.srcIn,
                ),
                AppImages.fileIcon,
              ),
              title: Text(
                context.tr.editUploadedFiles,
                style: AppStyles.cairoExtraBold(
                  context,
                ).copyWith(color: AppColors.textSecondary, fontSize: 16),
              ),
              onTap: () {
                // cubit.cancelAppointment(appointmentId: id);
                // if (context.mounted) {
                //   context.pop();
                // }
              },
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
                cubit.cancelAppointment(appointmentId: id);
                if (context.mounted) {
                  context.pop();
                }
              },
            ),
            const Divider(color: Colors.grey),
          ],
        ),
      );
    },
  );
}
