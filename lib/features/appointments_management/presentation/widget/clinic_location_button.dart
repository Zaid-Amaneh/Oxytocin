import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/features/appointments_management/data/models/appointment_model.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/custom_appointment_card_button.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/show_clinic_location_sheet.dart';

class ClinicLocationButton extends StatelessWidget {
  const ClinicLocationButton({
    super.key,
    required this.appointmentModel,
    required this.t,
  });
  final AppointmentModel appointmentModel;
  final bool t;
  @override
  Widget build(BuildContext context) {
    return CustomAppointmentCardButton(
      t: t,
      text: context.tr.map,
      icon: SvgPicture.asset(AppImages.mapLocationIcon),
      onTap: () {
        showClinicLocationSheet(
          context,
          clinicName: appointmentModel.clinic.doctor.user.fullName,
          clinicAddress: appointmentModel.clinic.address,
          latitude: appointmentModel.clinic.latitude,
          longitude: appointmentModel.clinic.longitude,
        );
      },
    );
  }
}
