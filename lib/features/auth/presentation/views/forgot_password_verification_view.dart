import 'package:flutter/material.dart';
import 'package:oxytocin/features/auth/presentation/widget/forgot_password_verification_view_body.dart';

class ForgotPasswordVerificationView extends StatelessWidget {
  const ForgotPasswordVerificationView({super.key, this.phoneNumber});
  final dynamic phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ForgotPasswordVerificationViewBody(phoneNumber: phoneNumber),
    );
  }
}
