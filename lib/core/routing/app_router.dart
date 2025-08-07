import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:oxytocin/core/routing/navigation_service.dart';
import 'package:oxytocin/core/routing/route_names.dart';
import 'package:oxytocin/features/all_doctors_page/presentation/views/all_doctors_view.dart';
import 'package:oxytocin/features/auth/data/services/auth_service.dart';
import 'package:oxytocin/features/auth/domain/change_password_use_case.dart';
import 'package:oxytocin/features/auth/domain/forgot_password_usecase.dart';
import 'package:oxytocin/features/auth/domain/resend_otp_use_case.dart';
import 'package:oxytocin/features/auth/domain/sign_in_use_case.dart';
import 'package:oxytocin/features/auth/domain/sign_up_use_case.dart';
import 'package:oxytocin/features/auth/domain/verify_forgot_password_otp_use_case.dart';
import 'package:oxytocin/features/auth/domain/verify_otp_use_case.dart';
import 'package:oxytocin/features/auth/presentation/viewmodels/blocs/changePassword/change_password_bloc.dart';
import 'package:oxytocin/features/auth/presentation/viewmodels/blocs/forgotPassword/forgot_password_bloc.dart';
import 'package:oxytocin/features/auth/presentation/viewmodels/blocs/signIn/sign_in_bloc.dart';
import 'package:oxytocin/features/auth/presentation/viewmodels/blocs/signUp/sign_up_bloc.dart';
import 'package:oxytocin/features/auth/presentation/viewmodels/blocs/verification/otp_bloc.dart';
import 'package:oxytocin/features/auth/presentation/viewmodels/blocs/verifyForgotPasswordOtp/verify_forgot_password_otp_bloc.dart';
import 'package:oxytocin/features/auth/presentation/views/auth_view.dart';
import 'package:oxytocin/features/auth/presentation/views/forgot_password_verification_view.dart';
import 'package:oxytocin/features/auth/presentation/views/forgot_password_view.dart';
import 'package:oxytocin/features/auth/presentation/views/reset_password_view.dart';
import 'package:oxytocin/features/auth/presentation/views/verification_phone_number_view.dart';
import 'package:oxytocin/features/categories/presentation/view/categories_view.dart';
import 'package:oxytocin/features/home/presentation/view/home_view.dart';
import 'package:oxytocin/features/intro/presentation/views/intro_view.dart';
import 'package:oxytocin/features/intro/presentation/views/splash_view.dart';
import 'package:oxytocin/features/auth_complete/presentation/cubit/profile_info_cubit.dart';
import 'package:oxytocin/features/auth_complete/presentation/views/congrats_view.dart';
import 'package:oxytocin/features/auth_complete/presentation/views/medical_info_view.dart';
import 'package:oxytocin/features/auth_complete/presentation/views/profile_info_view.dart';
import 'package:oxytocin/features/auth_complete/presentation/views/set_location.dart';
import 'package:oxytocin/features/auth_complete/presentation/views/upload_profile_photo.dart';
import 'package:oxytocin/features/medical_appointments/presentation/views/medical_appointments_view.dart';

class AppRouter {
  static GoRouter createRouter(NavigationService navigationService) {
    final router = GoRouter(
      initialLocation: '/${RouteNames.home}',
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
          path: '/${RouteNames.categories}',
          name: RouteNames.categories,
          builder: (context, state) => const CategoriesView(),
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
          path: '/${RouteNames.home}',
          name: RouteNames.home,
          builder: (context, state) => const HomeView(),
        ),
        GoRoute(
          path: '/${RouteNames.signIn}',
          name: RouteNames.signIn,
          builder: (context, state) {
            final authRepository = AuthService(http.Client());

            return MultiRepositoryProvider(
              providers: [
                RepositoryProvider<SignUpUseCase>(
                  create: (_) => SignUpUseCase(authService: authRepository),
                ),
                RepositoryProvider<SignInUseCase>(
                  create: (_) => SignInUseCase(authService: authRepository),
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
                child: const AuthView(),
              ),
            );
          },
        ),
        GoRoute(
          path: '/${RouteNames.forgotPassword}',
          name: RouteNames.forgotPassword,
          builder: (context, state) {
            final authRepository = AuthService(http.Client());
            return RepositoryProvider<ForgotPasswordUseCase>(
              create: (_) => ForgotPasswordUseCase(authService: authRepository),
              child: BlocProvider<ForgotPasswordBloc>(
                create: (context) =>
                    ForgotPasswordBloc(context.read<ForgotPasswordUseCase>()),
                child: const ForgotPasswordView(),
              ),
            );
          },
        ),
        GoRoute(
          path: '/${RouteNames.setLocation}',
          name: RouteNames.setLocation,
          builder: (context, state) {
            final profileInfoCubit = state.extra as ProfileInfoCubit;
            return BlocProvider.value(
              value: profileInfoCubit,
              child: const SetLocation(),
            );
          },
        ),

        GoRoute(
          path: '/${RouteNames.upload}',
          name: RouteNames.upload,
          builder: (context, state) => const UploadProfilePhoto(),
        ),

        GoRoute(
          path: '/${RouteNames.forgotPasswordverification}',
          name: RouteNames.forgotPasswordverification,
          builder: (context, state) {
            final phoneNumber = state.uri.queryParameters['phoneNumber'];
            final authRepository = AuthService(http.Client());
            return RepositoryProvider<VerifyForgotPasswordOtpUseCase>(
              create: (_) =>
                  VerifyForgotPasswordOtpUseCase(authService: authRepository),
              child: BlocProvider<VerifyForgotPasswordOtpBloc>(
                create: (context) => VerifyForgotPasswordOtpBloc(
                  context.read<VerifyForgotPasswordOtpUseCase>(),
                ),
                child: ForgotPasswordVerificationView(phoneNumber: phoneNumber),
              ),
            );
          },
        ),

        GoRoute(
          path: '/${RouteNames.medicalInfoView}',
          name: RouteNames.medicalInfoView,
          builder: (context, state) => BlocProvider(
            create: (_) => ProfileInfoCubit(),
            child: MedicalInfoBody(ProfileInfoCubit()),
          ),
        ),
        GoRoute(
          path: '/${RouteNames.resetPassword}',
          name: RouteNames.resetPassword,
          builder: (context, state) {
            final authRepository = AuthService(http.Client());
            return RepositoryProvider<ChangePasswordUseCase>(
              create: (_) => ChangePasswordUseCase(authService: authRepository),
              child: BlocProvider<ChangePasswordBloc>(
                create: (context) =>
                    ChangePasswordBloc(context.read<ChangePasswordUseCase>()),
                child: const ResetPasswordView(),
              ),
            );
          },
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
                  create: (_) => VerifyOtpUseCase(authService: authRepository),
                ),
                RepositoryProvider<ResendOtpUseCase>(
                  create: (_) => ResendOtpUseCase(authService: authRepository),
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

        GoRoute(
          path: '/${RouteNames.allDoctorsView}',
          name: RouteNames.allDoctorsView,
          builder: (context, state) => const AllDoctorsView(),
        ),

        GoRoute(
          path: '/${RouteNames.medicalAppointmentsView}',
          name: RouteNames.medicalAppointmentsView,
          builder: (context, state) => const MedicalAppointmentsView(),
        ),
      ],
    );
    navigationService.setRouter(router);
    return router;
  }
}
