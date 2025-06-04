import 'package:flutter/material.dart';
import 'package:oxytocin/features/auth/presentation/widget/sign_in_view_body.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SignInViewBody());
  }
}
