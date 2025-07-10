import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:oxytocin/core/routing/navigation_service.dart';
import 'package:oxytocin/core/routing/route_names.dart';
import 'package:oxytocin/features/auth/presentation/views/auth_view.dart';
import 'package:oxytocin/features/auth/presentation/views/forgot_password_verification_view.dart';
import 'package:oxytocin/features/auth/presentation/views/forgot_password_view.dart';
import 'package:oxytocin/features/auth/presentation/views/reset_password_view.dart';
import 'package:oxytocin/features/auth/presentation/views/verification_phone_number_view.dart';
import 'package:oxytocin/features/intro/presentation/views/intro_view.dart';
import 'package:oxytocin/features/intro/presentation/views/splash_view.dart';
import 'package:oxytocin/features/profile/presentation/cubit/profile_info_cubit.dart';
import 'package:oxytocin/features/profile/presentation/views/congrats_view.dart';
import 'package:oxytocin/features/profile/presentation/views/medical_info_view.dart';
import 'package:oxytocin/features/profile/presentation/views/profile_info_view.dart';
import 'package:oxytocin/features/profile/presentation/views/set_location.dart';
import 'package:oxytocin/features/profile/presentation/views/upload_profile_photo.dart';

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
          path: '/${RouteNames.congratView}',
          name: RouteNames.congratView,
          builder: (context, state) => const CongratsView(),
        ),

        GoRoute(
          path: '/${RouteNames.profileInfo}',
          name: RouteNames.profileInfo,
          builder: (context, state) => BlocProvider(
            create: (_) => ProfileInfoCubit(),
            child: const ProfileInfo(),
          ),
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
          path: '/${RouteNames.setLocation}',
          name: RouteNames.setLocation,
          builder: (context, state) => const SetLocation(),
        ),
        GoRoute(
          path: '/${RouteNames.upload}',
          name: RouteNames.upload,
          builder: (context, state) => const UploadProfilePhoto(),
        ),
        GoRoute(
          path: '/${RouteNames.forgotPasswordverification}',
          name: RouteNames.forgotPasswordverification,
          builder: (context, state) => const ForgotPasswordVerificationView(),
        ),
        GoRoute(
          path: '/${RouteNames.medicalInfoView}',
          name: RouteNames.medicalInfoView,

          builder: (context, state) {
            final profileInfoCubit =
                (state.extra as Map)['profileInfoCubit'] as ProfileInfoCubit;
            return BlocProvider.value(
              value: profileInfoCubit,
              child: MedicalInfoBody(profileInfoCubit),
            );
          },
        ),
        GoRoute(
          path: '/${RouteNames.resetPassword}',
          name: RouteNames.resetPassword,
          builder: (context, state) => const ResetPasswordView(),
        ),
        GoRoute(
          path: '/${RouteNames.verificationPhoneNumber}',
          name: RouteNames.verificationPhoneNumber,
          builder: (context, state) => const VerificationPhoneNumberView(),
        ),
      ],
    );
    navigationService.setRouter(router);
    return router;
  }
}
