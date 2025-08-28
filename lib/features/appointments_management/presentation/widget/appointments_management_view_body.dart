import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/widgets/un_expected_error.dart';
import 'package:oxytocin/features/appointments_management/presentation/viewmodels/management_appointments_cubit.dart';
import 'package:oxytocin/features/appointments_management/presentation/viewmodels/management_appointments_state.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/absent_appointment_card.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/canceled_appointment_card.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/completed_appointment_card.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/current_appointment_card.dart';
import 'package:toastification/toastification.dart';

class AppointmentsManagementViewBody extends StatefulWidget {
  const AppointmentsManagementViewBody({super.key});

  @override
  State<AppointmentsManagementViewBody> createState() =>
      _AppointmentsManagementViewBodyState();
}

class _AppointmentsManagementViewBodyState
    extends State<AppointmentsManagementViewBody> {
  String _selectedFilterKey = 'all';
  bool _didInit = false;
  late final Map<String, Map<String, dynamic>> _filters;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ManagementAppointmentsCubit>().fetchAppointments(status: '');
    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didInit) {
      _filters = {
        'all': {
          'displayText': context.tr.allReservations,
          'apiStatus': "waiting,cancelle,completed,absent",
        },
        'current': {
          'displayText': context.tr.currentReservations,
          'apiStatus': "waiting",
        },
        'past': {
          'displayText': context.tr.pastReservations,
          'apiStatus': "completed,absent",
        },
        'cancelled': {
          'displayText': context.tr.canceledReservations,
          'apiStatus': "cancelled",
        },
      };
    }

    _didInit = true;
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ManagementAppointmentsCubit>().fetchMoreAppointments();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll - 50);
  }

  String textState = '';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final height = size.height;
    return BlocConsumer<
      ManagementAppointmentsCubit,
      ManagementAppointmentsState
    >(
      listenWhen: (previous, current) {
        return current is EvaluationLoading ||
            current is EvaluationSuccess ||
            current is EvaluationFailure ||
            current is AppointmentCancellationLoading ||
            current is AppointmentCancellationSuccess ||
            current is AppointmentCancellationFailure ||
            current is AppointmentRebookLoading ||
            current is AppointmentRebookSuccess ||
            current is AppointmentRebookFailure;
      },
      listener: (context, state) {
        if (state is EvaluationLoading) {
          Helper.showCircularProgressIndicator(context);
        } else if (state is EvaluationFailure) {
          Logger().e(state.errorMessage);
          context.pop();
          Helper.customToastification(
            context: context,
            type: ToastificationType.error,
            title: context.tr.error,
            description: context.tr.ratingFailed,
            seconds: 5,
          );
        } else if (state is EvaluationSuccess) {
          context.pop();
          Helper.customToastification(
            context: context,
            type: ToastificationType.success,
            title: context.tr.success_title,
            description: context.tr.ratingSuccess,
            seconds: 5,
          );
        } else if (state is AppointmentCancellationLoading) {
          Helper.showCircularProgressIndicator(context);
        } else if (state is AppointmentCancellationFailure) {
          Logger().e(state.errorMessage);
          context.pop();
          Helper.customToastification(
            context: context,
            type: ToastificationType.error,
            title: context.tr.error,
            description: context.tr.cancellationFailed,
            seconds: 5,
          );
        } else if (state is AppointmentCancellationSuccess) {
          context.pop();
          Helper.customToastification(
            context: context,
            type: ToastificationType.success,
            title: context.tr.success_title,
            description: context.tr.cancellationSuccess,
            seconds: 5,
          );
        } else if (state is AppointmentRebookLoading) {
          Helper.showCircularProgressIndicator(context);
        } else if (state is AppointmentRebookFailure) {
          Logger().e(state.errorMessage);
          context.pop();
          Helper.customToastification(
            context: context,
            type: ToastificationType.error,
            title: context.tr.error,
            description: context.tr.rebookingFailed,
            seconds: 5,
          );
        } else if (state is AppointmentRebookSuccess) {
          context.pop();
          Helper.customToastification(
            context: context,
            type: ToastificationType.success,
            title: context.tr.success_title,
            description: context.tr.rebookingSuccess,
            seconds: 5,
          );
        }
      },
      buildWhen: (previous, current) {
        return current is! EvaluationLoading &&
            current is! EvaluationSuccess &&
            current is! EvaluationFailure &&
            current is! AppointmentCancellationLoading &&
            current is! AppointmentCancellationSuccess &&
            current is! AppointmentCancellationFailure &&
            current is! AppointmentRebookLoading &&
            current is! AppointmentRebookSuccess &&
            current is! AppointmentRebookFailure;
      },
      builder: (context, state) {
        return CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: height * 0.022)),
            SliverToBoxAdapter(
              child: SizedBox(
                height: height * 0.1,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _filters.length,
                  itemBuilder: (context, index) {
                    final key = _filters.keys.elementAt(index);
                    final filterData = _filters[key]!;
                    final displayText = filterData['displayText'] as String;
                    final apiStatus = filterData['apiStatus'] as String;
                    final isSelected = _selectedFilterKey == key;
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            textState = displayText;
                            Logger().f(textState);
                            _selectedFilterKey = key;
                            context
                                .read<ManagementAppointmentsCubit>()
                                .fetchAppointments(status: apiStatus);
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.kPrimaryColor2
                                : AppColors.background,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.kPrimaryColor2
                                  : AppColors.textfieldBorder,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: isSelected
                                    ? AppColors.kPrimaryColor2.withAlpha(
                                        (255 * 0.3).round(),
                                      )
                                    : Colors.black.withAlpha(
                                        (255 * 0.1).round(),
                                      ),
                                blurRadius: 4,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              displayText,
                              style: AppStyles.almaraiExtraBold(context)
                                  .copyWith(
                                    fontSize: 12,
                                    color: isSelected
                                        ? AppColors.background
                                        : AppColors.textPrimary,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: height * 0.02)),
            if (state is AppointmentsLoading)
              SliverToBoxAdapter(
                child: Helper.buildShimmerBox(
                  width: size.width * 0.9,
                  height: height * 0.25,
                  count: 3,
                ),
              )
            else if (state is AppointmentsFailure)
              SliverToBoxAdapter(
                child: state.failure is AuthenticationFailure
                    ? Text(
                        context.tr.loginRequiredForCurrentReservations,
                        style: AppStyles.almaraiBold(context).copyWith(
                          color: AppColors.kPrimaryColor1,
                          fontSize: 22,
                        ),
                      )
                    : const UnExpectedError(),
              )
            else if (state is AppointmentsLoaded && state.appointments.isEmpty)
              SliverToBoxAdapter(
                child: EmptyState(
                  text: textState == context.tr.canceledReservations
                      ? context.tr.noCancelledAppointments
                      : textState == context.tr.currentReservations
                      ? context.tr.noCurrentAppointments
                      : context.tr.noPastAppointments,
                ),
              )
            else if (state is AppointmentsLoaded)
              SliverList.builder(
                itemCount:
                    state.appointments.length + (state.hasReachedMax ? 0 : 1),
                itemBuilder: (context, index) {
                  if (index >= state.appointments.length) {
                    return const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final appointmentModel = state.appointments[index];
                  final String status = appointmentModel.status;
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: status == "waiting" || status == "in_consultation"
                        ? CurrentAppointmentCard(
                            appointmentModel: appointmentModel,
                          )
                        : status == "cancelled"
                        ? CanceledAppointmentCard(
                            appointmentModel: appointmentModel,
                          )
                        : status == "absent"
                        ? AbsentAppointmentCard(
                            appointmentModel: appointmentModel,
                          )
                        : CompletedAppointmentCard(
                            appointmentModel: appointmentModel,
                          ),
                  );
                },
              )
            else
              const SliverToBoxAdapter(child: SizedBox.shrink()),
          ],
        );
      },
    );
  }
}

class EmptyState extends StatelessWidget {
  final String text;

  const EmptyState({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const double baseWidth = 375.0;
        final double scale = constraints.maxWidth / baseWidth;

        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(height: 180 * scale),
            Container(
              width: 120 * scale,
              height: 120 * scale,
              decoration: const BoxDecoration(
                color: Color.fromARGB(26, 190, 40, 40),
                shape: BoxShape.circle,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 90 * scale,
                    height: 90 * scale,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(51, 190, 39, 39),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Icon(
                    Icons.event_busy,
                    size: 50 * scale,
                    color: const Color.fromARGB(255, 196, 39, 39),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 26),
            Text(
              text,
              style: TextStyle(
                fontSize: 20 * scale,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2C3E50),
              ),
            ),
          ],
        );
      },
    );
  }
}
