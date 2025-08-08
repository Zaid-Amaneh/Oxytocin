import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/features/medical_appointments/presentation/widget/call_button.dart';
import 'package:oxytocin/features/medical_appointments/presentation/widget/custom_appointment_card_side.dart';
import 'package:oxytocin/features/medical_appointments/presentation/widget/custom_appointment_card_button.dart';
import 'package:oxytocin/features/medical_appointments/presentation/widget/custom_appointment_card_info.dart';
import 'package:oxytocin/features/medical_appointments/presentation/widget/show_edit_appointment_bottom_sheet.dart';

class CurrentAppointmentCard extends StatelessWidget {
  const CurrentAppointmentCard({super.key});

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
                const CustomAppointmentCardInfo(
                  image:
                      "https://img.freepik.com/premium-photo/female-doctor-smiling-white-background_1038537-86.jpg",
                  doctorName: "د. فراس القاسم",
                  specialization: "طب الأسنان",
                  address: "دمشق - المالكي",
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomAppointmentCardButton(
                        t: true,
                        text: 'الخريطه',
                        icon: SvgPicture.asset(AppImages.mapLocationIcon),
                      ),
                      CustomAppointmentCardButton(
                        t: true,
                        text: 'تعديل',
                        icon: SvgPicture.asset(AppImages.editIcon),
                        onTap: () {
                          showEditAppointmentBottomSheet(context);
                        },
                      ),
                      const CallButton(phoneNumber: "0944373305"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const CustomAppointmentCardSide(
            color: Color(0xFFCBE2FF),
            textcolor: AppColors.textPrimary,
            text: '19 يونيو 2025\n 04:30 مساءً ',
            gif: AppImages.waitAppointmentGif,
          ),
        ],
      ),
    );
  }
}
