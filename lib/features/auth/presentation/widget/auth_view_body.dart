import 'package:flutter/material.dart';
import 'package:oxytocin/features/auth/presentation/widget/assistant_illustration.dart';
import 'package:oxytocin/features/auth/presentation/widget/additional_container.dart';
import 'package:oxytocin/features/auth/presentation/widget/auth_form.dart';
import 'package:oxytocin/features/auth/presentation/widget/custom_switch.dart';
import 'package:oxytocin/features/auth/presentation/widget/first_layer.dart';
import 'package:oxytocin/features/auth/presentation/widget/second_layer.dart';

class AuthViewBody extends StatefulWidget {
  const AuthViewBody({super.key});

  @override
  State<AuthViewBody> createState() => _AuthViewBodyState();
}

// The boolean value for switcher
bool form = true;

class _AuthViewBodyState extends State<AuthViewBody> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    return SingleChildScrollView(
      child: Stack(
        children: [
          SizedBox(width: width, height: height),
          // Layer2
          const SecondLayer(),
          // Layer1
          const FirstLayer(),
          // Form Card
          AuthForm(form: form),
          // This container is for clipping the intersects with switcher
          const AdditionalContainer(),
          // Form switcher
          CustomSwitch(
            inup: form,
            signInTap: () {
              setState(() {
                form = true;
              });
            },
            signUpTap: () {
              setState(() {
                form = false;
              });
            },
          ),
          // Assistant image
          AssistantIllustration(form: form),
        ],
      ),
    );
  }
}
