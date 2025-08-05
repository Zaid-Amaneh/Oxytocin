import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/features/medical_appointments/presentation/widget/call_button.dart';
import 'package:oxytocin/features/medical_appointments/presentation/widget/custom_appointment_card_side.dart';
import 'package:oxytocin/features/medical_appointments/presentation/widget/custom_appointment_card_button.dart';
import 'package:oxytocin/features/medical_appointments/presentation/widget/custom_appointment_card_info.dart';

class CanceledAppointmentCard extends StatelessWidget {
  const CanceledAppointmentCard({super.key});

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
                        t: false,
                        text: 'إعادة الحجز',
                        icon: SvgPicture.asset(AppImages.rescheduleIcon),
                      ),
                      const CallButton(phoneNumber: "0944373305"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const CustomAppointmentCardSide(
            color: Color(0xFFFF2400),
            textcolor: AppColors.background,
            text: 'لقد قمت بإلغاء هذا الحجز بنجاح.',
            gif: AppImages.canceledAppointmentGif,
          ),
        ],
      ),
    );
  }
}
