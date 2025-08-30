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
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 20,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.kPrimaryColor1.withAlpha(25),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.edit_rounded,
                      color: AppColors.kPrimaryColor1,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    context.tr.edit,
                    style: AppStyles.cairoExtraBold(
                      context,
                    ).copyWith(color: AppColors.textPrimary, fontSize: 20),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildOptionTile(
                    context: context,
                    icon: AppImages.editIcon,
                    title: context.tr.reschedule,
                    subtitle: context.tr.changeAppointmentDateTime,
                    backgroundColor: const Color(0xFF3498DB),
                    onTap: () {
                      context.pop();
                      NavigationService().pushToNamedWithParams(
                        RouteNames.reAppointment,
                        extra: {
                          'id': appointmentModel.clinic.doctor.user.id,
                          'appointmentId': id,
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildOptionTile(
                    context: context,
                    icon: AppImages.fileIcon,
                    title: context.tr.editUploadedFiles,
                    subtitle: context.tr.addRemovemanageAttachments,
                    backgroundColor: const Color(0xFF27AE60),
                    onTap: () {
                      context.pop();
                      NavigationService().pushToNamedWithParams(
                        RouteNames.attachmentsManagerScreen,
                        extra: {'id': appointmentModel.id},
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildOptionTile(
                    context: context,
                    icon: AppImages.canceledIcon,
                    title: context.tr.cancelReservation,
                    subtitle: context.tr.cancelAppointmentPermanently,
                    backgroundColor: const Color(0xFFE74C3C),
                    isDestructive: true,
                    onTap: () {
                      _showCancelConfirmationDialog(context, cubit, id);
                    },
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildOptionTile({
  required BuildContext context,
  required String icon,
  required String title,
  required String subtitle,
  required Color backgroundColor,
  required VoidCallback onTap,
  bool isDestructive = false,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: isDestructive
            ? const Color(0x33E74C3C)
            : backgroundColor.withAlpha(51),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: backgroundColor.withAlpha(25),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: backgroundColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SvgPicture.asset(
                  icon,
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                    backgroundColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppStyles.cairoExtraBold(context).copyWith(
                        color: isDestructive
                            ? const Color(0xFFE74C3C)
                            : AppColors.textPrimary,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: AppStyles.almaraiRegular(
                        context,
                      ).copyWith(color: AppColors.textSecondary, fontSize: 13),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: backgroundColor.withAlpha(179),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

void _showCancelConfirmationDialog(
  BuildContext context,
  ManagementAppointmentsCubit cubit,
  int id,
) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0x1AE74C3C),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.warning_rounded,
              color: Color(0xFFE74C3C),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            context.tr.confirmCancel,
            style: AppStyles.almaraiBold(
              context,
            ).copyWith(color: AppColors.textPrimary, fontSize: 18),
          ),
        ],
      ),
      content: Text(
        context.tr.cancelConfirmationMsg,
        style: const TextStyle(height: 1.5),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(
            context.tr.back,
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            cubit.cancelAppointment(appointmentId: id);
            context.pop();
            context.pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE74C3C),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(context.tr.cancelAppointment),
        ),
      ],
    ),
  );
}
