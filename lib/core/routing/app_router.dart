import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:oxytocin/core/routing/navigation_service.dart';
import 'package:oxytocin/core/routing/route_names.dart';
import 'package:oxytocin/features/auth/data/services/auth_service.dart';
import 'package:oxytocin/features/auth/domain/resend_otp_use_case.dart';
import 'package:oxytocin/features/auth/domain/sign_in_use_case.dart';
import 'package:oxytocin/features/auth/domain/sign_up_use_case.dart';
import 'package:oxytocin/features/auth/domain/verify_otp_use_case.dart';
import 'package:oxytocin/features/auth/presentation/viewmodels/blocs/verification/otp_bloc.dart';
import 'package:oxytocin/features/auth/presentation/viewmodels/blocs/signIn/sign_in_bloc.dart';
import 'package:oxytocin/features/auth/presentation/viewmodels/blocs/signUp/sign_up_bloc.dart';
import 'package:oxytocin/features/auth/presentation/views/auth_view.dart';
import 'package:oxytocin/features/auth/presentation/views/forgot_password_verification_view.dart';
import 'package:oxytocin/features/auth/presentation/views/forgot_password_view.dart';
import 'package:oxytocin/features/auth/presentation/views/reset_password_view.dart';
import 'package:oxytocin/features/auth/presentation/views/verification_phone_number_view.dart';
import 'package:oxytocin/features/intro/presentation/views/intro_view.dart';
import 'package:oxytocin/features/intro/presentation/views/splash_view.dart';

class AppRouter {
  static GoRouter createRouter(NavigationService navigationService) {
    final router = GoRouter(
      initialLocation: '/${RouteNames.splash}',
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
          builder: (context, state) {
            final authRepository = AuthService(http.Client());

            return MultiRepositoryProvider(
              providers: [
                RepositoryProvider<SignUpUseCase>(
                  create: (_) => SignUpUseCase(authRepository),
                ),
                RepositoryProvider<SignInUseCase>(
                  create: (_) => SignInUseCase(authRepository),
                ),
              ],
              child: MultiBlocProvider(
                providers: [
                  BlocProvider<SignUpBloc>(
                    create: (context) =>
                        SignUpBloc(context.read<SignUpUseCase>()),
                  ),
                  BlocProvider<SignInBloc>(
                    create: (context) =>
                        SignInBloc(context.read<SignInUseCase>()),
                  ),
                ],
                child: const AuthView(), // هنا ستستفيد الشاشة من كلا البلوكين
              ),
            );
          },
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
        GoRoute(
          path: '/${RouteNames.verificationPhoneNumber}',
          name: RouteNames.verificationPhoneNumber,
          builder: (context, state) {
            final authRepository = AuthService(http.Client());
            final phoneNumber = state.uri.queryParameters['phoneNumber'];
            return MultiRepositoryProvider(
              providers: [
                RepositoryProvider<VerifyOtpUseCase>(
                  create: (_) => VerifyOtpUseCase(authRepository),
                ),
                RepositoryProvider<ResendOtpUseCase>(
                  create: (_) => ResendOtpUseCase(authRepository),
                ),
              ],
              child: BlocProvider<OtpBloc>(
                create: (context) => OtpBloc(
                  context.read<VerifyOtpUseCase>(),
                  context.read<ResendOtpUseCase>(),
                ),
                child: VerificationPhoneNumberView(phoneNumber: phoneNumber),
              ),
            );
          },
        ),
      ],
    );

    // Inject the router into the navigation service

    navigationService.setRouter(router);
    return router;
  }
}
