import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/features/appointments_management/data/models/appointment_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oxytocin/features/appointments_management/presentation/viewmodels/management_appointments_cubit.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/custom_appointment_card_button.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/show_rating_sheet.dart';

class AddRateButton extends StatelessWidget {
  const AddRateButton({super.key, required this.appointmentModel});
  final AppointmentModel appointmentModel;
  @override
  Widget build(BuildContext context) {
    return CustomAppointmentCardButton(
      t: false,
      text: appointmentModel.evaluation == null
          ? context.tr.rateDoctor
          : context.tr.alreadyRatedOrCommented,
      icon: appointmentModel.evaluation == null
          ? SvgPicture.asset(
              width: 12,
              height: 12,
              AppImages.starSolid,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            )
          : const Icon(
              Icons.done_outline_sharp,
              color: AppColors.background,
              size: 14,
            ),
      onTap: appointmentModel.evaluation == null
          ? () {
              showRatingSheet(
                context,
                appointmentModel.id,
                context.read<ManagementAppointmentsCubit>(),
              );
            }
          : null,
    );
  }
}
