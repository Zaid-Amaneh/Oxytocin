import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/features/doctor_profile.dart/data/models/appointment_date_model.dart';
import 'package:oxytocin/features/doctor_profile.dart/data/models/visit_time_model.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
    super.key,
    required this.appointment,
    this.onBookAppointment,
  });
  final AppointmentDate appointment;
  final Function(DateTime date, String time)? onBookAppointment;
  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final dayName = _getDayName(appointment.visitDate, context);
    final dateText = appointment.visitDate;

    List<VisitTime> availableTimes = [];
    for (var i in appointment.visitTimes) {
      if (!i.isBooked) {
        availableTimes.add(i);
      }
    }
    final hasAvailableTimes =
        availableTimes.isNotEmpty &&
        !isDateOlderThanToday(appointment.visitDate);
    final displayTimes = availableTimes.take(2).toList();
    final remainingCount = availableTimes.length - 2;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
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
                                  '${context.tr.available}: ${_convertTo12Hour(time.visitTime, context)}',
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
                            context.tr.noAppointmentsMessage,
                            textAlign: TextAlign.center,
                            style: AppStyles.almaraiBold(context).copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 10,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
          GestureDetector(
            // onTap: hasAvailableTimes
            //     ? () => onBookAppointment?.call(
            //         appointment.date,
            //         displayTimes.first,
            //       )
            //     : null,
            child: Container(
              width: double.infinity,
              height: screenHeight * 0.05,
              decoration: BoxDecoration(
                color: hasAvailableTimes
                    ? AppColors.kPrimaryColor4
                    : AppColors.textSecondary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Center(
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
          ),
        ],
      ),
    );
  }
}

String _getDayName(String date, BuildContext context) {
  final weekdays = [
    context.tr.monday,
    context.tr.tuesday,
    context.tr.wednesday,
    context.tr.thursday,
    context.tr.friday,
    context.tr.saturday,
    context.tr.sunday,
  ];

  final parsedDate = DateTime.parse(date);

  return weekdays[parsedDate.weekday - 1];
}

String _convertTo12Hour(String time24, BuildContext context) {
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

bool isDateOlderThanToday(String dateString) {
  final inputDate = DateTime.parse(dateString);
  final today = DateTime.now();
  final todayDateOnly = DateTime(today.year, today.month, today.day);
  return inputDate.isBefore(todayDateOnly);
}
