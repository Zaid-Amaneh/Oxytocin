import 'package:flutter/material.dart';
import 'package:oxytocin/features/auth/presentation/widget/auth_view_body.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: AuthViewBody());
  }
}
