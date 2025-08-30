import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/features/appointments_management/data/models/appointment_model.dart';

class CustomAppointmentCardSide extends StatelessWidget {
  const CustomAppointmentCardSide({
    super.key,
    this.text,
    required this.gif,
    required this.color,
    required this.textcolor,
    required this.appointmentModel,
  });
  final String? gif, text;
  final AppointmentModel appointmentModel;
  final Color color, textcolor;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    return Container(
      width: width * 0.21,
      decoration: ShapeDecoration(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: Helper.isArabic(context)
              ? const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                )
              : const BorderRadius.only(
                  topRight: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              text ??
                  '${appointmentModel.visitDate}\n ${_convertTo12Hour(appointmentModel.visitTime, context)}',
              textAlign: TextAlign.center,
              style: AppStyles.almaraiBold(
                context,
              ).copyWith(fontSize: 10, color: textcolor),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Image.asset(gif!),
        ],
      ),
    );
  }
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
