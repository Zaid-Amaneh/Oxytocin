import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/features/intro/data/models/intro_header_item.dart';
import 'package:oxytocin/features/intro/presentation/widget/intro_view_body.dart';
import 'package:oxytocin/l10n/app_localizations.dart';

class IntroView extends StatelessWidget {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<IntroHeaderItem> intro = [
      IntroHeaderItem(
        titel: AppLocalizations.of(context)!.findPerfectDoctor,
        subtitle: AppLocalizations.of(context)!.findPerfectDoctorDes,
        gif: AppImages.imagesPerfectdoctor,
      ),
      IntroHeaderItem(
        titel: AppLocalizations.of(context)!.medicalRecordInYourHand,
        subtitle: AppLocalizations.of(context)!.medicalRecordInYourHandDes,
        gif: AppImages.imagesMedicalrecord,
      ),
      IntroHeaderItem(
        titel: AppLocalizations.of(context)!.yourPrivacyProtected,
        subtitle: AppLocalizations.of(context)!.yourPrivacyProtectedDes,
        gif: AppImages.imagesPrivacy,
      ),
    ];
    return Scaffold(body: IntroViewBody(intro: intro));
  }
}
