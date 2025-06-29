import 'package:flutter/material.dart';
import 'package:oxytocin/features/auth/presentation/widget/verification_phone_number_view_body.dart';

class VerificationPhoneNumberView extends StatelessWidget {
  final dynamic phoneNumber;

  const VerificationPhoneNumberView({super.key, this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VerificationPhoneNumberViewBody(phoneNumber: phoneNumber),
    );
  }
}
