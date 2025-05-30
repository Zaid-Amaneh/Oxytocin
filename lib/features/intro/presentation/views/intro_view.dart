import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/features/intro/data/models/intro_header_item.dart';
import 'package:oxytocin/features/intro/presentation/widget/intro_view_body.dart';
import 'package:oxytocin/generated/l10n.dart';

class IntroView extends StatelessWidget {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<IntroHeaderItem> intro = [
      IntroHeaderItem(
        titel: S.of(context).FindPerfectDoctor,
        subtitle: S.of(context).FindPerfectDoctorDes,
        gif: Assets.imagesPerfectdoctor,
      ),
      IntroHeaderItem(
        titel: S.of(context).MedicalRecordInYourHand,
        subtitle: S.of(context).MedicalRecordInYourHandDes,
        gif: Assets.imagesMedicalrecord,
      ),
      IntroHeaderItem(
        titel: S.of(context).YourPrivacyProtected,
        subtitle: S.of(context).YourPrivacyProtectedDes,
        gif: Assets.imagesPrivacy,
      ),
    ];
    return Scaffold(body: IntroViewBody(intro: intro));
  }
}
