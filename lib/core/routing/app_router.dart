import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:oxytocin/core/routing/navigation_service.dart';
import 'package:oxytocin/core/routing/route_names.dart';
import 'package:oxytocin/features/appointments_management/data/services/appointment_cancellation_service.dart';
import 'package:oxytocin/features/appointments_management/data/services/appointments_fetch_service.dart';
import 'package:oxytocin/features/appointments_management/data/services/evaluation_service.dart';
import 'package:oxytocin/features/appointments_management/data/services/manage_attachment_service.dart';
import 'package:oxytocin/features/appointments_management/data/services/queue_service.dart';
import 'package:oxytocin/features/appointments_management/data/services/re_book_appointment_service.dart';
import 'package:oxytocin/features/appointments_management/data/services/rebook_appointment_service.dart';
import 'package:oxytocin/features/appointments_management/presentation/viewmodels/attachments_manager_cubit.dart';
import 'package:oxytocin/features/appointments_management/presentation/viewmodels/management_appointments_cubit.dart';
import 'package:oxytocin/features/appointments_management/presentation/viewmodels/queue_cubit.dart';
import 'package:oxytocin/features/appointments_management/presentation/viewmodels/re_booking_cubit.dart';
import 'package:oxytocin/features/appointments_management/presentation/views/attachments_manager_screen.dart';
import 'package:oxytocin/features/appointments_management/presentation/views/re_appointment_view.dart';
import 'package:oxytocin/features/appointments_management/presentation/views/re_book_Appointment_view.dart';
import 'package:oxytocin/features/book_appointment/data/models/booked_appointment_model.dart';
import 'package:oxytocin/features/book_appointment/data/services/appointment_service.dart';
import 'package:oxytocin/features/book_appointment/data/services/attachment_service.dart';
import 'package:oxytocin/features/book_appointment/presentation/viewmodels/attachment_cubit.dart';
import 'package:oxytocin/features/book_appointment/presentation/viewmodels/booking_cubit.dart';
import 'package:oxytocin/features/book_appointment/presentation/views/appointment_successfully_booked.dart';
import 'package:oxytocin/features/book_appointment/presentation/views/book_appointment_view.dart';
import 'package:oxytocin/features/doctor_profile.dart/data/models/visit_time_model.dart';
import 'package:oxytocin/features/doctor_profile.dart/data/services/doctor_profile_service.dart';
import 'package:oxytocin/features/doctor_profile.dart/data/services/favorites_service.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/viewmodels/doctor_profile_cubit.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/viewmodels/evaluations_cubit.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/viewmodels/favorites_cubit.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/views/all_appointment_month.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/views/all_reviews_view.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/views/doctor_profile_view.dart';
import 'package:oxytocin/features/manage_medical_records/data/services/specialty_access_service.dart';
import 'package:oxytocin/features/manage_medical_records/presentation/viewmodels/specialty_access_cubit.dart';
import 'package:oxytocin/features/manage_medical_records/presentation/views/manage_medical_records.dart';
import 'package:oxytocin/features/medical_records/data/repositories/doctors_repository.dart';
import 'package:oxytocin/features/medical_records/data/services/archives_service.dart';
import 'package:oxytocin/features/medical_records/data/services/doctors_service.dart';
import 'package:oxytocin/features/medical_records/data/services/specialties_service.dart';
import 'package:oxytocin/features/medical_records/presentation/viewmodels/doctors_cubit.dart';
import 'package:oxytocin/features/medical_records/presentation/viewmodels/patient_archives_cubit.dart';
import 'package:oxytocin/features/medical_records/presentation/viewmodels/specialties_cubit.dart';
import 'package:oxytocin/features/medical_records/presentation/views/doctor_list_view.dart';
import 'package:oxytocin/features/medical_records/presentation/views/medical_records_view.dart';
import 'package:oxytocin/features/medical_records/presentation/views/specializations_view.dart';
import 'package:oxytocin/features/search_doctors_page/data/services/doctor_search_service.dart';
import 'package:oxytocin/features/search_doctors_page/presentation/viewmodels/doctorSearch/doctor_search_cubit.dart';
import 'package:oxytocin/features/search_doctors_page/presentation/views/search_doctors_view.dart';
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
import 'package:oxytocin/features/appointments_management/presentation/views/appointments_management_view.dart';
import 'package:oxytocin/features/profile/presentation/view/profile_view.dart';
import 'package:oxytocin/features/profile/di/profile_dependency_injection.dart';

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
          path: '/${RouteNames.allReviewsView}/:clinicId',
          name: RouteNames.allReviewsView,
          builder: (context, state) {
            final clinicId = int.parse(state.pathParameters['clinicId']!);
            return BlocProvider(
              create: (context) =>
                  EvaluationsCubit(DoctorProfileService())
                    ..fetchEvaluations(clinicId),
              child: const AllReviewsView(),
            );
          },
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
          // builder: (context, state) =>
          //     BlocProvider(create: (_) => HomeCubit(), child: const HomeView()),
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
          builder: (context, state) {
            final profileInfoCubit = state.extra as ProfileInfoCubit;
            return BlocProvider.value(
              value: profileInfoCubit,
              child: MedicalInfoBody(profileInfoCubit),
            );
          },
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
          path: '/${RouteNames.searchDoctorsView}',
          name: RouteNames.searchDoctorsView,
          builder: (context, state) {
            final searchRepository = DoctorSearchService(http.Client());
            return BlocProvider(
              create: (_) => DoctorSearchCubit(searchRepository),
              child: const SearchDoctorsView(),
            );
          },
        ),

        GoRoute(
          path: '/${RouteNames.appointmentsManagementView}',
          name: RouteNames.appointmentsManagementView,
          builder: (context, state) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ManagementAppointmentsCubit(
                  evaluationService: EvaluationService(http.Client()),
                  appointmentsFetchService: AppointmentsFetchService(
                    http.Client(),
                  ),
                  cancellationService: AppointmentCancellationService(
                    http.Client(),
                  ),
                  rebookService: RebookAppointmentService(http.Client()),
                ),
              ),
              BlocProvider(
                create: (context) => QueueCubit(QueueService(http.Client())),
              ),
            ],
            child: const AppointmentsManagementView(),
          ),
        ),
        GoRoute(
          path: '/${RouteNames.profile}',
          name: RouteNames.profile,
          builder: (context, state) => BlocProvider(
            create: (_) => ProfileDependencyInjection.getProfileCubit(),
            child: const ProfileView(),
          ),
        ),

        GoRoute(
          path: '/${RouteNames.doctorProfileView}',
          name: RouteNames.doctorProfileView,
          builder: (context, state) {
            int id = int.tryParse(state.uri.queryParameters['id'] ?? '') ?? 0;
            final now = DateTime.now();
            final startDate = now;
            final endDate = now.add(const Duration(days: 31));

            final String formattedStartDate =
                "${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}";
            final String formattedEndDate =
                "${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}";
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) =>
                      DoctorProfileCubit(DoctorProfileService())
                        ..fetchAllDoctorData(
                          clinicId: id,
                          startDate: formattedStartDate,
                          endDate: formattedEndDate,
                        ),
                ),
                BlocProvider(
                  create: (context) =>
                      FavoritesCubit(FavoritesService(http.Client())),
                ),
              ],
              child: DoctorProfileView(id: id),
            );
          },
        ),

        GoRoute(
          path: '/${RouteNames.allAppointmentMonth}',
          name: RouteNames.allAppointmentMonth,
          builder: (context, state) {
            int id = int.tryParse(state.uri.queryParameters['id'] ?? '') ?? 0;
            final now = DateTime.now();
            final startDate = DateTime(now.year, now.month, 1);
            final endDate = DateTime(now.year, now.month + 1, 0);
            final String formattedStartDate =
                "${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}";

            final String formattedEndDate =
                "${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}";
            return BlocProvider(
              create: (context) => DoctorProfileCubit(DoctorProfileService())
                ..fetchAppointmentDates(
                  clinicId: id,
                  startDate: formattedStartDate,
                  endDate: formattedEndDate,
                ),
              child: AllAppointmentMonth(id: id),
            );
          },
        ),
        GoRoute(
          path: '/${RouteNames.bookAppointment}',
          name: RouteNames.bookAppointment,
          builder: (context, state) {
            final args = state.extra as Map<String, dynamic>;
            final appointmentService = AppointmentService(http.Client());
            return BlocProvider(
              create: (_) => BookingCubit(appointmentService),
              child: BookAppointmentView(
                id: args['id'] as String,
                dateText: args['dateText'] as String,
                dayName: args['dayName'] as String,
                availableTimes: List<VisitTime>.from(
                  args['availableTimes'] as List,
                ),
              ),
            );
          },
        ),
        GoRoute(
          path: '/${RouteNames.appointmentSuccessfullyBooked}',
          name: RouteNames.appointmentSuccessfullyBooked,
          builder: (context, state) {
            final args = state.extra as Map<String, dynamic>;

            final attachmentService = AttachmentService();

            return BlocProvider(
              create: (_) => AttachmentCubit(attachmentService),
              child: AppointmentSuccessfullyBooked(
                bookedAppointmentModel:
                    args['bookedAppointmentModel'] as BookedAppointmentModel,
              ),
            );
          },
        ),
        GoRoute(
          path: '/${RouteNames.reAppointment}',
          name: RouteNames.reAppointment,
          builder: (context, state) {
            final args = state.extra as Map<String, dynamic>;
            final id = args['id'] as int;
            final appointmentId = args['appointmentId'] as int;
            final now = DateTime.now();
            final startDate = DateTime(now.year, now.month, 1);
            final endDate = DateTime(now.year, now.month + 1, 0);
            final String formattedStartDate =
                "${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}";

            final String formattedEndDate =
                "${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}";

            return BlocProvider(
              create: (context) => DoctorProfileCubit(DoctorProfileService())
                ..fetchAppointmentDates(
                  clinicId: id,
                  startDate: formattedStartDate,
                  endDate: formattedEndDate,
                ),
              child: ReAppointmentView(id: id, appointmentId: appointmentId),
            );
          },
        ),

        GoRoute(
          path: '/${RouteNames.reBookAppointment}',
          name: RouteNames.reBookAppointment,
          builder: (context, state) {
            final args = state.extra as Map<String, dynamic>;
            final appointmentService = ReBookAppointmentService(http.Client());
            return BlocProvider(
              create: (_) => ReBookingCubit(appointmentService),
              child: ReBookAppointmentView(
                id: args['id'] as String,
                dateText: args['dateText'] as String,
                dayName: args['dayName'] as String,
                availableTimes: List<VisitTime>.from(
                  args['availableTimes'] as List,
                ),
              ),
            );
          },
        ),

        GoRoute(
          path: '/${RouteNames.attachmentsManagerScreen}',
          name: RouteNames.attachmentsManagerScreen,
          builder: (context, state) {
            final args = state.extra as Map<String, dynamic>;
            final manageAttachmentService = ManageAttachmentService(
              http.Client(),
            );
            return BlocProvider(
              create: (_) => AttachmentsManagerCubit(manageAttachmentService),
              child: AttachmentsManagerScreen(appointmentId: args['id'] as int),
            );
          },
        ),

        GoRoute(
          path: '/${RouteNames.specializationsView}',
          name: RouteNames.specializationsView,
          builder: (context, state) {
            final specialtiesService = SpecialtiesService(http.Client());
            return BlocProvider(
              create: (_) =>
                  SpecialtiesCubit(specialtiesService)..fetchSpecialties(),
              child: const SpecializationsView(),
            );
          },
        ),
        GoRoute(
          path: '/${RouteNames.doctorListView}',
          name: RouteNames.doctorListView,
          builder: (context, state) {
            final args = state.extra as Map<String, dynamic>;
            final int id = args['id'] as int;
            final String name = args['name'] as String;

            return BlocProvider(
              create: (context) {
                final DoctorsService doctorsService = DoctorsService(
                  http.Client(),
                );
                final DoctorsRepository repository = DoctorsRepositoryImpl(
                  doctorsService,
                );
                return DoctorsCubit(repository)..fetchDoctors(id);
              },
              child: DoctorListView(id: id, specName: name),
            );
          },
        ),
        GoRoute(
          path: '/${RouteNames.medicalRecordsView}',
          name: RouteNames.medicalRecordsView,
          builder: (context, state) {
            final args = state.extra as Map<String, dynamic>;
            final int doctorId = args['id'] as int;
            final String doctorName = args['name'] as String;
            return BlocProvider(
              create: (context) {
                final archivesService = ArchivesService(http.Client());
                return PatientArchivesCubit(archivesService)
                  ..fetchDoctorArchives(doctorId);
              },
              child: MedicalRecordsView(doctorName: doctorName),
            );
          },
        ),
        GoRoute(
          path: '/${RouteNames.manageMedicalRecords}',
          name: RouteNames.manageMedicalRecords,
          builder: (context, state) => BlocProvider(
            create: (context) =>
                SpecialtyAccessCubit(SpecialtyAccessService(http.Client()))
                  ..fetchSpecialtyAccessList(),
            child: const ManageMedicalRecords(),
          ),
        ),
      ],
    );
    navigationService.setRouter(router);
    return router;
  }
}
