import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/widget/review.dart';

class AppointmentBookingWidget extends StatefulWidget {
  final List<AppointmentModel> appointments;
  final Function(DateTime date, String time)? onBookAppointment;
  final VoidCallback? onShowAllMonthDays;

  const AppointmentBookingWidget({
    super.key,
    required this.appointments,
    this.onBookAppointment,
    this.onShowAllMonthDays,
  });

  @override
  State<AppointmentBookingWidget> createState() =>
      _AppointmentBookingWidgetState();
}

class _AppointmentBookingWidgetState extends State<AppointmentBookingWidget> {
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
            context.tr.select_booking_time,
            style: AppStyles.almaraiBold(
              context,
            ).copyWith(color: AppColors.textPrimary, fontSize: 18),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: currentStartIndex > 0 ? _goToPreviousDays : null,
              child: Icon(
                Icons.arrow_back_ios,
                size: screenWidth * 0.04,
                color: currentStartIndex > 0 ? Colors.black : Colors.grey,
              ),
            ),
            Expanded(
              child: SizedBox(
                height: screenHeight * 0.24,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    final appointmentIndex = currentStartIndex + index;
                    if (appointmentIndex >= widget.appointments.length) {
                      return _buildEmptyCard(screenWidth, screenHeight);
                    }
                    return _buildAppointmentCard(
                      widget.appointments[appointmentIndex],
                      screenWidth,
                      screenHeight,
                    );
                  },
                ),
              ),
            ),
            InkWell(
              onTap: _canGoToNextDays() ? _goToNextDays : null,
              child: Icon(
                Icons.arrow_forward_ios,
                color: _canGoToNextDays() ? Colors.black : Colors.grey,
                size: screenWidth * 0.04,
              ),
            ),
          ],
        ),
        Center(
          child: GestureDetector(
            onTap: widget.onShowAllMonthDays,
            child: Text(
              context.tr.show_all_days,
              style: AppStyles.almaraiBold(context).copyWith(
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

  Widget _buildAppointmentCard(
    AppointmentModel appointment,
    double screenWidth,
    double screenHeight,
  ) {
    final dayName = _getDayName(appointment.date);
    final dateText = _getDateText(appointment.date);
    final hasAvailableTimes = appointment.availableTimes.isNotEmpty;
    final displayTimes = appointment.availableTimes.take(2).toList();
    final remainingCount = appointment.availableTimes.length - 2;

    return Container(
      width: screenWidth * 0.25,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: screenHeight * 0.05,
            decoration: BoxDecoration(
              color: hasAvailableTimes
                  ? AppColors.kPrimaryColor1
                  : AppColors.textSecondary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  dayName,
                  style: AppStyles.almaraiBold(
                    context,
                  ).copyWith(color: AppColors.background, fontSize: 10),
                ),
                Text(
                  dateText,
                  style: AppStyles.almaraiBold(
                    context,
                  ).copyWith(color: AppColors.background, fontSize: 10),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: hasAvailableTimes
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...displayTimes.map(
                              (time) => Padding(
                                padding: EdgeInsets.only(
                                  bottom: screenHeight * 0.005,
                                ),
                                child: Text(
                                  '${context.tr.available}: ${_convertTo12Hour(time)}',
                                  style: AppStyles.almaraiBold(context)
                                      .copyWith(
                                        color: AppColors.textSecondary,
                                        fontSize: 10,
                                      ),
                                ),
                              ),
                            ),
                            if (remainingCount > 0)
                              Padding(
                                padding: EdgeInsets.only(
                                  top: screenHeight * 0.01,
                                ),
                                child: Text(
                                  context.tr.remainingAppointmentsMessage(
                                    remainingCount,
                                  ),
                                  textAlign: TextAlign.center,
                                  style: AppStyles.almaraiBold(context)
                                      .copyWith(
                                        color: AppColors.textPrimary,
                                        fontSize: 10,
                                      ),
                                ),
                              ),
                          ],
                        )
                      : Center(
                          child: Text(
                            'لا يوجد مواعيد\nمتاحة',
                            textAlign: TextAlign.center,
                            style: AppStyles.almaraiBold(context).copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 10,
                            ),
                          ),
                        ),
                ),

                SizedBox(
                  width: double.infinity,
                  height: screenHeight * 0.04,
                  child: ElevatedButton(
                    onPressed: hasAvailableTimes
                        ? () => widget.onBookAppointment?.call(
                            appointment.date,
                            displayTimes.first,
                          )
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: hasAvailableTimes
                          ? AppColors.kPrimaryColor4
                          : AppColors.textSecondary,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                      ),
                    ),
                    child: Text(
                      context.tr.book_now,
                      style: AppStyles.almaraiBold(context).copyWith(
                        color: hasAvailableTimes
                            ? AppColors.textPrimary
                            : AppColors.background,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCard(double screenWidth, double screenHeight) {
    return Container(
      width: screenWidth * 0.25,
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Center(
        child: Text(
          context.tr.noAppointments,
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: screenWidth * 0.03,
          ),
        ),
      ),
    );
  }

  String _getDayName(DateTime date) {
    final weekdays = [
      context.tr.monday,
      context.tr.tuesday,
      context.tr.wednesday,
      context.tr.thursday,
      context.tr.friday,
      context.tr.saturday,
      context.tr.sunday,
    ];

    return weekdays[date.weekday - 1];
  }

  String _getDateText(DateTime date) {
    final months = [
      '01',
      '02',
      '03',
      '04',
      '05',
      '06',
      '07',
      '08',
      '09',
      '10',
      '11',
      '12',
    ];
    return '${date.day.toString().padLeft(2, '0')}/${months[date.month - 1]}';
  }

  String _convertTo12Hour(String time24) {
    final parts = time24.split(':');
    final hour = int.parse(parts[0]);
    final minute = parts[1];

    if (hour == 0) {
      return '12:$minute ${context.tr.am}';
    } else if (hour < 12) {
      return '$hour:$minute ${context.tr.am}';
    } else if (hour == 12) {
      return '12:$minute ${context.tr.pm}';
    } else {
      return '${hour - 12}:$minute ${context.tr.pm}';
    }
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
