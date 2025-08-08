import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/features/medical_appointments/presentation/widget/custom_appointment_card_button.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

class CallButton extends StatelessWidget {
  const CallButton({super.key, required this.phoneNumber});
  final String phoneNumber;
  @override
  Widget build(BuildContext context) {
    return CustomAppointmentCardButton(
      t: true,
      text: 'اتصال',
      icon: SvgPicture.asset(AppImages.callIcon),
      onTap: () {
        _makingPhoneCall(phoneNumber, context);
      },
    );
  }
}

_makingPhoneCall(String phoneNumber, BuildContext context) async {
  final url = Uri.parse("tel:$phoneNumber");

  try {
    final launched = await launchUrl(url, mode: LaunchMode.externalApplication);
    if (!launched) {
      throw Exception('Could not launch $url');
    }
  } catch (e) {
    if (context.mounted) {
      Helper.customToastification(
        context: context,
        type: ToastificationType.error,
        title: 'عذرًا، لم نتمكن من إجراء المكالمة',
        description: 'تعذّر فتح تطبيق الاتصال. جرّب لاحقًا أو اتصل يدويًا.',
        seconds: 5,
      );
    }
  }
}
