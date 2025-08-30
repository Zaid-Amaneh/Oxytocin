import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/widgets/custom_app_bar.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/attachments_manager_screen_body.dart';

class AttachmentsManagerScreen extends StatelessWidget {
  const AttachmentsManagerScreen({super.key, required this.appointmentId});
  final int appointmentId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titel: context.tr.manageAttachments),
      body: AttachmentsManagerScreenBody(appointmentId: appointmentId),
    );
  }
}
