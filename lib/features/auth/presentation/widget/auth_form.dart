import 'package:flutter/material.dart';
import 'package:oxytocin/features/auth/presentation/widget/sign_in_form.dart';
import 'package:oxytocin/features/auth/presentation/widget/sign_up_form.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key, required this.form});
  final bool form;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  bool? _previousForm; // Track previous state

  final List<Widget> formList = const [
    SignInForm(key: ValueKey('sign_in')),
    SignUpForm(key: ValueKey('sign_up')),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _updateAnimation();
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant AuthForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.form != oldWidget.form) {
      _previousForm = oldWidget.form;
      _controller.reset();
      _controller.forward();
    }
  }

  void _updateAnimation() {
    _offsetAnimation = Tween<Offset>(
      begin: _calculateBeginOffset(),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutQuad));
  }

  Offset _calculateBeginOffset() {
    if (_previousForm == null) return Offset.zero;

    return Offset(widget.form ? -2.0 : 2.0, 2.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _updateAnimation(); // Ensure animation uses latest values
    return Positioned(
      top: MediaQuery.sizeOf(context).height * 0.3,
      bottom: 0,
      child: SlideTransition(
        position: _offsetAnimation,
        child: widget.form ? formList[0] : formList[1],
      ),
    );
  }
}
