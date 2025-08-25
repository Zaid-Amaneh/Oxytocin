import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/features/appointments_management/data/models/appointment_model.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/call_button.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/custom_appointment_card_side.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/custom_appointment_card_button.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/custom_appointment_card_info.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/show_edit_appointment_bottom_sheet.dart';

class CurrentAppointmentCard extends StatelessWidget {
  const CurrentAppointmentCard({super.key, required this.appointmentModel});
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
        mainAxisAlignment: MainAxisAlignment.end,
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
                        t: true,
                        text: context.tr.map,
                        icon: SvgPicture.asset(AppImages.mapLocationIcon),
                      ),
                      CustomAppointmentCardButton(
                        t: true,
                        text:
                            isWithin24Hours(
                              appointmentModel.visitDate,
                              appointmentModel.visitTime,
                            )
                            ? context.tr.about
                            : context.tr.edit,
                        icon: SvgPicture.asset(AppImages.editIcon),
                        onTap: () {
                          isWithin24Hours(
                                appointmentModel.visitDate,
                                appointmentModel.visitTime,
                              )
                              ? null
                              : showEditAppointmentBottomSheet(context);
                        },
                      ),
                      CallButton(phoneNumber: appointmentModel.clinic.phone),
                    ],
                  ),
                ),
              ],
            ),
          ),
          CustomAppointmentCardSide(
            color: const Color(0xFFCBE2FF),
            textcolor: AppColors.textPrimary,
            appointmentModel: appointmentModel,
            gif: AppImages.waitAppointmentGif,
          ),
        ],
      ),
    );
  }
}

bool isWithin24Hours(String visitDate, String visitTime) {
  try {
    final dateParts = visitDate.split('-');
    final timeParts = visitTime.split(':');

    final dateTime = DateTime(
      int.parse(dateParts[0]),
      int.parse(dateParts[1]),
      int.parse(dateParts[2]),
      int.parse(timeParts[0]),
      int.parse(timeParts[1]),
      timeParts.length > 2 ? int.parse(timeParts[2]) : 0,
    );

    final now = DateTime.now();
    final difference = dateTime.difference(now);
    return !difference.isNegative && difference.inHours <= 24;
  } catch (e) {
    return false;
  }
}
