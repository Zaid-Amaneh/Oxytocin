import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/features/medical_appointments/presentation/widget/canceled_appointment_card.dart';
import 'package:oxytocin/features/medical_appointments/presentation/widget/completed_appointment_card.dart';
import 'package:oxytocin/features/medical_appointments/presentation/widget/current_appointment_card.dart';

class MedicalAppointmentsViewBody extends StatefulWidget {
  const MedicalAppointmentsViewBody({super.key});

  @override
  State<MedicalAppointmentsViewBody> createState() =>
      _MedicalAppointmentsViewBodyState();
}

class _MedicalAppointmentsViewBodyState
    extends State<MedicalAppointmentsViewBody> {
  String selectedGender = 'جميع الحجوزات';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    final List<Widget> cards = [
      const CurrentAppointmentCard(),
      const CompletedAppointmentCard(),
      const CanceledAppointmentCard(),
      const CanceledAppointmentCard(),
      const CompletedAppointmentCard(),
      const CurrentAppointmentCard(),
      const CanceledAppointmentCard(),
      const CompletedAppointmentCard(),
      const CurrentAppointmentCard(),
    ];
    final List<String> genders = [
      'جميع الحجوزات',
      'الحجوزات الحالية',
      'الحجوزات السابقة',
      'الحجوزات الملغاة',
    ];
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 80)),
        SliverToBoxAdapter(
          child: SizedBox(
            height: height * 0.1,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGender = genders[index];
                      });
                    },
                    child: Container(
                      width: width * 0.25,
                      decoration: ShapeDecoration(
                        color: selectedGender == genders[index]
                            ? AppColors.kPrimaryColor2
                            : AppColors.background,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            color: selectedGender == genders[index]
                                ? AppColors.kPrimaryColor2
                                : AppColors.textfieldBorder,
                          ),
                          borderRadius: BorderRadius.circular(12),
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
                      child: Center(
                        child: Text(
                          genders[index],
                          style: AppStyles.almaraiExtraBold(context).copyWith(
                            fontSize: 10,
                            color: selectedGender == genders[index]
                                ? AppColors.background
                                : AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 30)),
        SliverList.builder(
          itemCount: cards.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: cards[index],
            );
          },
        ),
      ],
    );
  }
}
