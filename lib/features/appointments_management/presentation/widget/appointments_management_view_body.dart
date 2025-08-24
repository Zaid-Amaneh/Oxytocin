import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/widgets/un_expected_error.dart';
import 'package:oxytocin/features/appointments_management/presentation/viewmodels/appointments_cubit.dart';
import 'package:oxytocin/features/appointments_management/presentation/viewmodels/appointments_state.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/absent_appointment_card.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/canceled_appointment_card.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/completed_appointment_card.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/current_appointment_card.dart';

class AppointmentsManagementViewBody extends StatefulWidget {
  const AppointmentsManagementViewBody({super.key});

  @override
  State<AppointmentsManagementViewBody> createState() =>
      _AppointmentsManagementViewBodyState();
}

class _AppointmentsManagementViewBodyState
    extends State<AppointmentsManagementViewBody> {
  String _selectedFilterKey = 'all';
  late final Map<String, Map<String, dynamic>> _filters;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<AppointmentsCubit>().fetchAppointments(status: '');
    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _filters = {
      'all': {'displayText': context.tr.allReservations, 'apiStatus': ""},
      'current': {
        'displayText': context.tr.currentReservations,
        'apiStatus': "waiting,in_consultation",
      },
      'past': {
        'displayText': context.tr.pastReservations,
        'apiStatus': "abuse,completed",
      },
      'cancelled': {
        'displayText': context.tr.canceledReservations,
        'apiStatus': "cancelled",
      },
    };
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
      context.read<AppointmentsCubit>().fetchMoreAppointments();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll - 50);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: height * 0.06)),
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
                        _selectedFilterKey = key;
                        context.read<AppointmentsCubit>().fetchAppointments(
                          status: apiStatus,
                        );
                      });
                    },
                    //this Container need some edit and make it responsive for the text inside him, and make it more modern and putifull
                    child: Container(
                      width: width * 0.25,
                      decoration: ShapeDecoration(
                        color: isSelected
                            ? AppColors.kPrimaryColor2
                            : AppColors.background,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            color: isSelected
                                ? AppColors.kPrimaryColor2
                                : AppColors.textfieldBorder,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        shadows: [
                          const BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          displayText,
                          style: AppStyles.almaraiExtraBold(context).copyWith(
                            fontSize: 10,
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
        BlocBuilder<AppointmentsCubit, AppointmentsState>(
          builder: (context, state) {
            if (state is AppointmentsLoading) {
              return SliverToBoxAdapter(
                child: Helper.buildShimmerBox(
                  width: width * 0.9,
                  height: height * 0.25,
                  count: 3,
                ),
              );
            } else if (state is AppointmentsFailure) {
              if (state.failure is AuthenticationFailure) {
                return SliverToBoxAdapter(
                  child: Text(
                    context.tr.loginRequiredForCurrentReservations,
                    style: AppStyles.almaraiBold(
                      context,
                    ).copyWith(color: AppColors.kPrimaryColor1, fontSize: 22),
                  ),
                );
              }
              return const SliverToBoxAdapter(child: UnExpectedError());
            } else if (state is AppointmentsLoaded) {
              final int itemCount = state.appointments.length;
              return SliverList.builder(
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  if (index == itemCount - 1 && !state.hasReachedMax) {
                    return const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  final String status = state.appointments[index].status;
                  final appointmentModel = state.appointments[index];
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
                        : status == "abuse"
                        ? AbsentAppointmentCard(
                            appointmentModel: appointmentModel,
                          )
                        : CompletedAppointmentCard(
                            appointmentModel: appointmentModel,
                          ),
                  );
                },
              );
            }
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          },
        ),
      ],
    );
  }
}
