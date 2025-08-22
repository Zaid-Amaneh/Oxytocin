import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/widgets/custom_button.dart';
import 'package:oxytocin/core/widgets/custom_text_form_field.dart';
import 'package:oxytocin/features/book_appointment/presentation/widgets/time_card.dart';
import 'package:oxytocin/features/doctor_profile.dart/data/models/visit_time_model.dart';

class BookAppointmentViewBody extends StatefulWidget {
  const BookAppointmentViewBody({
    super.key,
    required this.dateText,
    required this.dayName,
    required this.availableTimes,
    required this.id,
    required this.mainSpecialty,
    required this.address,
  });
  final String dateText, dayName, id, mainSpecialty, address;

  final List<VisitTime> availableTimes;
  @override
  State<BookAppointmentViewBody> createState() =>
      _BookAppointmentViewBodyState();
}

class _BookAppointmentViewBodyState extends State<BookAppointmentViewBody> {
  String? selectedTime;

  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final dayDate = '${widget.dayName} ${widget.dateText}';
    final textParts = context.tr.availableAppointments(dayDate).split(dayDate);
    // final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: textParts[0],
                    style: AppStyles.almaraiBold(
                      context,
                    ).copyWith(color: AppColors.textPrimary, fontSize: 16),
                  ),
                  TextSpan(
                    text: dayDate,
                    style: AppStyles.almaraiBold(context).copyWith(
                      color: AppColors.kPrimaryColor1,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(
                    text: textParts[1],
                    style: AppStyles.almaraiBold(
                      context,
                    ).copyWith(color: AppColors.textPrimary, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          sliver: SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 12,
              childAspectRatio: 2.4,
            ),
            itemCount: widget.availableTimes.length,
            itemBuilder: (context, index) {
              final time = widget.availableTimes[index].visitTime;
              final isSelected = selectedTime == time;
              return TimeCard(
                time: _convertTo12Hour(time, context),
                isSelected: isSelected,
                onTap: () {
                  setState(() {
                    selectedTime = time;
                  });
                },
              );
            },
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Text(
              context.tr.appointmentInstructions,
              style: AppStyles.almaraiBold(
                context,
              ).copyWith(color: AppColors.textSecondary, fontSize: 14),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: CustomTextFormField(
            controller: controller,
            fieldName: context.tr.tellDoctorHowYouFeel,
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: screenHeight * 0.03)),
        SliverToBoxAdapter(
          child: CustomButton(
            borderRadius: 25,
            onTap: selectedTime != null
                ? () {
                    Logger().f(widget.mainSpecialty);
                    Logger().f(widget.address);
                    Logger().f(widget.id);
                    Logger().f(widget.dateText);
                    Logger().f(selectedTime);
                    Logger().f(controller.text);
                  }
                : null,
            borderColor: AppColors.kPrimaryColor1,
            data: context.tr.confirmBooking,
            style: AppStyles.almaraiBold(context),
            visible: selectedTime != null,
            padding: const EdgeInsetsGeometry.all(18),
          ),
        ),
      ],
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
