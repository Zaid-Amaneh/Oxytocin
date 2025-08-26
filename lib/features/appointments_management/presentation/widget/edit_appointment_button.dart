import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/features/appointments_management/data/models/appointment_model.dart';
import 'package:oxytocin/features/appointments_management/presentation/viewmodels/management_appointments_cubit.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/custom_appointment_card_button.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/show_edit_appointment_bottom_sheet.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/test.dart';

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
        isWithin24Hours
            ? showQueueStatusSheet(
                context,
                queuePatients: [
                  QueuePatient(
                    appointmentTime: '10:00 ص',
                    actualEntryTime: '10:00 ص',
                    actualExitTime: '10:14 ص',
                    status: PatientStatus.completed,
                    orderNumber: 1,
                  ),
                  QueuePatient(
                    appointmentTime: '10:15 ص',
                    actualEntryTime: '10:18 ص',
                    actualExitTime: '10:32 ص',
                    status: PatientStatus.completed,
                    orderNumber: 2,
                  ),
                  QueuePatient(
                    appointmentTime: '10:30 ص',
                    actualEntryTime: '10:36 ص',
                    actualExitTime: '10:44 ص',
                    status: PatientStatus.completed,
                    orderNumber: 3,
                  ),
                  QueuePatient(
                    appointmentTime: '10:45 ص',
                    status: PatientStatus.absent,
                    orderNumber: 4,
                  ),
                  QueuePatient(
                    appointmentTime: '11:00 ص',
                    status: PatientStatus.inProgress,
                    orderNumber: 5,
                  ),
                  QueuePatient(
                    appointmentTime: '11:15 ص',
                    status: PatientStatus.cancelled,
                    orderNumber: 6,
                  ),
                  QueuePatient(
                    appointmentTime: '11:30 ص',
                    status: PatientStatus.waiting,
                    orderNumber: 7,
                  ),
                ],
                currentPatientOrder: 8,
                estimatedWaitingMinutes: 36,
                doctorName: 'د. أحمد محمد العلي',
                averageExaminationTime: 15, // متوسط 15 دقيقة للفحص
                averageDelayTime: 8, // م
              )
            : showEditAppointmentBottomSheet(
                context,
                context.read<ManagementAppointmentsCubit>(),
                appointmentModel.id,
                appointmentModel,
              );
      },
    );
  }
}
