import 'package:go_router/go_router.dart';
import 'package:oxytocin/core/routing/navigation_service.dart';
import 'package:oxytocin/core/routing/route_names.dart';
import 'package:oxytocin/features/auth/presentation/views/auth_view.dart';
import 'package:oxytocin/features/auth/presentation/views/forgot_password_verification_view.dart';
import 'package:oxytocin/features/auth/presentation/views/forgot_password_view.dart';
import 'package:oxytocin/features/auth/presentation/views/reset_password_view.dart';
import 'package:oxytocin/features/intro/presentation/views/intro_view.dart';
import 'package:oxytocin/features/intro/presentation/views/splash_view.dart';

class AppRouter {
  static GoRouter createRouter(NavigationService navigationService) {
    final router = GoRouter(
      initialLocation: '/${RouteNames.forgotPasswordverification}',
      routes: [
        GoRoute(
          path: '/${RouteNames.splash}',
          name: RouteNames.splash,
          builder: (context, state) => const SplashView(),
        ),
        GoRoute(
          path: '/${RouteNames.intro}',
          name: RouteNames.intro,
          builder: (context, state) => const IntroView(),
        ),
        GoRoute(
          path: '/${RouteNames.signIn}',
          name: RouteNames.signIn,
          builder: (context, state) => const AuthView(),
        ),
        GoRoute(
          path: '/${RouteNames.forgotPassword}',
          name: RouteNames.forgotPassword,
          builder: (context, state) => const ForgotPasswordView(),
        ),
        GoRoute(
          path: '/${RouteNames.forgotPasswordverification}',
          name: RouteNames.forgotPasswordverification,
          builder: (context, state) => const ForgotPasswordVerificationView(),
        ),
        GoRoute(
          path: '/${RouteNames.resetPassword}',
          name: RouteNames.resetPassword,
          builder: (context, state) => const ResetPasswordView(),
        ),
      ],
    );

    // Inject the router into the navigation service

    navigationService.setRouter(router);
    return router;
  }
}
