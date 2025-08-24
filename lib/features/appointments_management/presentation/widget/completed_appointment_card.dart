import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/features/appointments_management/data/models/appointment_model.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/custom_appointment_card_button.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/custom_appointment_card_info.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/custom_appointment_card_side.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/show_rating_sheet.dart';

class CompletedAppointmentCard extends StatelessWidget {
  const CompletedAppointmentCard({super.key, required this.appointmentModel});
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
                        t: false,
                        text: context.tr.rateDoctor,
                        icon: SvgPicture.asset(
                          width: 16,
                          height: 16,
                          AppImages.starSolid,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        onTap: () {
                          showRatingSheet(context);
                        },
                      ),
                      CustomAppointmentCardButton(
                        t: false,
                        text: context.tr.details,
                        icon: SvgPicture.asset(AppImages.infoIcon),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          CustomAppointmentCardSide(
            color: const Color(0xFF00FF04),
            textcolor: AppColors.textPrimary,
            appointmentModel: appointmentModel,
            gif: AppImages.doneAppointmentGif,
          ),
        ],
      ),
    );
  }
}
