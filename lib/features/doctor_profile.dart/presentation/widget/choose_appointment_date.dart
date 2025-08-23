import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/features/doctor_profile.dart/data/models/appointment_date.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/widget/appointment_card.dart';

class ChooseAppointmentDate extends StatefulWidget {
  final List<AppointmentDate> appointments;
  final VoidCallback? onShowAllMonthDays;
  final String id, mainSpecialty, address;
  const ChooseAppointmentDate({
    super.key,
    required this.appointments,
    this.onShowAllMonthDays,
    required this.id,
    required this.mainSpecialty,
    required this.address,
  });

  @override
  State<ChooseAppointmentDate> createState() => _ChooseAppointmentDateState();
}

class _ChooseAppointmentDateState extends State<ChooseAppointmentDate> {
  int currentStartIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Text(
            context.tr.near_appointments,
            style: AppStyles.almaraiBold(
              context,
            ).copyWith(color: AppColors.textPrimary, fontSize: 18),
          ),
        ),
        SizedBox(
          height: screenHeight * 0.22,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  right: Helper.isArabic(context) ? 8 : 0,
                  left: Helper.isArabic(context) ? 0 : 8,
                ),
                child: Center(
                  child: InkWell(
                    onTap: currentStartIndex > 0 ? _goToPreviousDays : null,
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 25,
                      color: currentStartIndex > 0
                          ? AppColors.kPrimaryColor1
                          : Colors.grey,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(3, (index) {
                    final appointmentIndex = currentStartIndex + index;
                    if (appointmentIndex >= widget.appointments.length) {
                      return Flexible(
                        child: _buildEmptyCard(screenWidth, screenHeight),
                      );
                    }
                    return Flexible(
                      child: AppointmentCard(
                        appointment: widget.appointments[appointmentIndex],
                        id: widget.id,
                      ),
                    );
                  }),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: Helper.isArabic(context) ? 0 : 6,
                  right: Helper.isArabic(context) ? 6 : 0,
                ),
                child: Center(
                  child: InkWell(
                    onTap: _canGoToNextDays() ? _goToNextDays : null,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: _canGoToNextDays()
                          ? AppColors.kPrimaryColor1
                          : Colors.grey,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: GestureDetector(
            onTap: widget.onShowAllMonthDays,
            child: Text(
              context.tr.view_all_reservations,
              style: AppStyles.almaraiExtraBold(context).copyWith(
                color: Theme.of(context).primaryColor,
                decoration: TextDecoration.underline,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyCard(double screenWidth, double screenHeight) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
          child: Text(
            context.tr.appointments_expired,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  void _goToNextDays() {
    if (_canGoToNextDays()) {
      setState(() {
        currentStartIndex += 3;
      });
    }
  }

  void _goToPreviousDays() {
    if (currentStartIndex > 0) {
      setState(() {
        currentStartIndex = (currentStartIndex - 3).clamp(
          0,
          widget.appointments.length - 1,
        );
      });
    }
  }

  bool _canGoToNextDays() {
    return currentStartIndex + 3 < widget.appointments.length;
  }
}
