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
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  bool? _previousForm;

  final List<Widget> formList = const [
    SignInForm(key: ValueKey('sign_in')),
    SignUpForm(key: ValueKey('sign_up')),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _updateAnimations();
    _controller.forward();
  }

  void _updateAnimations() {
    _slideAnimation = Tween<Offset>(
      begin: _calculateBeginOffset(),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );
  }

  Offset _calculateBeginOffset() {
    if (_previousForm == null) {
      return const Offset(0, 0.3);
    }

    double dx = widget.form ? -1.0 : 1.0;
    return Offset(dx, 0);
  }

  @override
  void didUpdateWidget(covariant AuthForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.form != oldWidget.form) {
      _previousForm = oldWidget.form;
      _updateAnimations();
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.sizeOf(context).height * 0.3,
      bottom: 0,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(
                scale: Tween<double>(begin: 0.95, end: 1.0).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
                ),
                child: child,
              );
            },
            child: widget.form ? formList[0] : formList[1],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:oxytocin/features/auth/presentation/widget/sign_in_form.dart';
// import 'package:oxytocin/features/auth/presentation/widget/sign_up_form.dart';

// class AuthForm extends StatefulWidget {
//   const AuthForm({super.key, required this.form});
//   final bool form;

//   @override
//   State<AuthForm> createState() => _AuthFormState();
// }

// class _AuthFormState extends State<AuthForm>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Offset> _offsetAnimation;
//   bool? _previousForm;

//   final List<Widget> formList = const [
//     SignInForm(key: ValueKey('sign_in')),
//     SignUpForm(key: ValueKey('sign_up')),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 400),
//       vsync: this,
//     );
//     _updateAnimation();
//     _controller.forward();
//   }

//   @override
//   void didUpdateWidget(covariant AuthForm oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.form != oldWidget.form) {
//       _previousForm = oldWidget.form;
//       _controller.reset();
//       _controller.forward();
//     }
//   }

//   void _updateAnimation() {
//     _offsetAnimation = Tween<Offset>(
//       begin: _calculateBeginOffset(),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutQuad));
//   }

//   Offset _calculateBeginOffset() {
//     if (_previousForm == null) return Offset.zero;

//     return Offset(widget.form ? -2.0 : 2.0, 2.0);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     _updateAnimation();
//     return Positioned(
//       top: MediaQuery.sizeOf(context).height * 0.3,
//       bottom: 0,
//       child: SlideTransition(
//         position: _offsetAnimation,
//         child: widget.form ? formList[0] : formList[1],
//       ),
//     );
//   }
// }
