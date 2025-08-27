import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/features/appointments_management/data/models/appointment_model.dart';
import 'package:oxytocin/features/appointments_management/presentation/viewmodels/management_appointments_cubit.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/custom_appointment_card_side.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/custom_appointment_card_button.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/custom_appointment_card_info.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/show_appointment_details_sheet.dart';

class CanceledAppointmentCard extends StatelessWidget {
  const CanceledAppointmentCard({super.key, required this.appointmentModel});
  final AppointmentModel appointmentModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    return Container(
      width: width,
      height: height * 0.245,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: AppColors.containerBorder),
          borderRadius: BorderRadius.circular(25),
        ),
        shadows: [
          const BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                CustomAppointmentCardInfo(clinic: appointmentModel.clinic),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomAppointmentCardButton(
                        t: false,
                        text: context.tr.rebook,
                        icon: SvgPicture.asset(AppImages.rescheduleIcon),
                        onTap: () {
                          context
                              .read<ManagementAppointmentsCubit>()
                              .rebookAppointment(
                                appointmentId: appointmentModel.id,
                              );
                        },
                      ),
                      CustomAppointmentCardButton(
                        t: false,
                        text: context.tr.details,
                        icon: SvgPicture.asset(AppImages.infoIcon),
                        onTap: () {
                          showAppointmentDetailsSheet(
                            context,
                            appointmentModel,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          CustomAppointmentCardSide(
            color: const Color(0xFFD32F2F),
            textcolor: AppColors.background,
            appointmentModel: appointmentModel,
            text: context.tr.reservationCanceledSuccess,
            gif: AppImages.canceledAppointmentGif,
          ),
        ],
      ),
    );
  }
}
