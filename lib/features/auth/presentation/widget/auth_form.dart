import 'package:flutter/material.dart';
import 'package:oxytocin/features/auth/presentation/widget/sign_in_form.dart';
import 'package:oxytocin/features/auth/presentation/widget/sign_up_form.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({super.key, required this.form});
  final bool form;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final height = size.height;
    return Positioned(
      top: height * 0.3,
      bottom: 0,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 450),
        transitionBuilder: (child, animation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: Offset(form ? -2.0 : 2.0, 2.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        child: form ? const SignInForm() : const SignUpForm(),
      ),
    );
  }
}
