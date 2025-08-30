import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/features/appointments_management/data/models/appointment_model.dart';
import 'package:oxytocin/features/appointments_management/presentation/viewmodels/management_appointments_cubit.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/custom_appointment_card_button.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/queue_status_sheet.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/show_edit_appointment_bottom_sheet.dart';

class EditAppointmentButton extends StatelessWidget {
  const EditAppointmentButton({
    super.key,
    required this.isWithin24Hours,
    required this.appointmentModel,
  });
  final bool isWithin24Hours;
  final AppointmentModel appointmentModel;

  @override
  Widget build(BuildContext context) {
    return CustomAppointmentCardButton(
      t: true,
      text: isWithin24Hours ? context.tr.queue : context.tr.edit,
      icon: isWithin24Hours
          ? SvgPicture.asset(
              AppImages.queueIcon,
              width: 20,
              height: 20,
              colorFilter: const ColorFilter.mode(
                AppColors.background,
                BlendMode.srcIn,
              ),
            )
          : SvgPicture.asset(AppImages.editIcon),
      onTap: () {
        if (isWithin24Hours) {
          showQueueStatusSheet(
            context: context,
            appointmentId: appointmentModel.id,
            doctorName: appointmentModel.clinic.doctor.user.fullName,
          );
        } else {
          showEditAppointmentBottomSheet(
            context,
            context.read<ManagementAppointmentsCubit>(),
            appointmentModel.id,
            appointmentModel,
          );
        }
      },
    );
  }
}
