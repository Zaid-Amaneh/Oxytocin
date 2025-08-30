import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/viewmodels/doctor_profile_cubit.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/viewmodels/doctor_profile_state.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/widget/appointment_card.dart';

class ReAppointmentBody extends StatelessWidget {
  const ReAppointmentBody({
    super.key,
    required this.id,
    required this.appointmentId,
  });
  final String id;
  final String appointmentId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
      builder: (context, state) {
        if (state is AppointmentDatesLoading) {
          return _buildLoadingState(context);
        } else if (state is AppointmentDatesSuccess) {
          if (state.appointmentDates.isEmpty) {
            return _buildEmptyState(context);
          }
          return _buildSuccessState(context, state);
        } else if (state is AppointmentDatesFailure) {
          return _buildErrorState(context);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: AppColors.kPrimaryColor1,
            strokeWidth: 3,
          ),
          const SizedBox(height: 16),
          Text(
            context.tr.loadingAppointments,
            style: AppStyles.almaraiBold(
              context,
            ).copyWith(color: AppColors.textSecondary, fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_busy_rounded,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 24),
            Text(
              context.tr.no_appointments_available,
              style: AppStyles.almaraiBold(
                context,
              ).copyWith(fontSize: 20, color: Colors.grey.shade700),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              context.tr.no_appointments_description,
              style: AppStyles.almaraiRegular(
                context,
              ).copyWith(fontSize: 16, color: Colors.grey.shade500),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 80,
              color: Colors.red.shade400,
            ),
            const SizedBox(height: 24),
            Text(
              context.tr.error_loading_appointments,
              style: AppStyles.almaraiBold(
                context,
              ).copyWith(fontSize: 20, color: Colors.red.shade700),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              context.tr.please_try_again,
              style: AppStyles.almaraiRegular(
                context,
              ).copyWith(fontSize: 16, color: Colors.grey.shade500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<DoctorProfileCubit>().refreshAppointmentDates();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kPrimaryColor1,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.refresh_rounded, size: 20),
              label: Text(
                context.tr.retry,
                style: AppStyles.almaraiBold(
                  context,
                ).copyWith(fontSize: 14, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessState(
    BuildContext context,
    AppointmentDatesSuccess state,
  ) {
    int availableAppointments = 0;
    for (var i in state.appointmentDates) {
      if (!isDateOlderThanToday(i.visitDate)) {
        for (var j in i.visitTimes) {
          if (!j.isBooked) {
            availableAppointments++;
            break;
          }
        }
      }
    }
    return RefreshIndicator(
      color: AppColors.kPrimaryColor1,
      onRefresh: () async {
        context.read<DoctorProfileCubit>().refreshAppointmentDates();
      },
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.kPrimaryColor1.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.kPrimaryColor1.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_month_rounded,
                    color: AppColors.kPrimaryColor1,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.tr.availableDays,
                          style: AppStyles.almaraiBold(context).copyWith(
                            fontSize: 16,
                            color: AppColors.kPrimaryColor1,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '$availableAppointments ${context.tr.days}',
                          style: AppStyles.almaraiRegular(
                            context,
                          ).copyWith(fontSize: 14, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            sliver: SliverGrid.builder(
              itemCount: state.appointmentDates.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _getCrossAxisCount(context),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: _getChildAspectRatio(context),
              ),
              itemBuilder: (BuildContext context, int index) {
                return _buildAnimatedCard(
                  context,
                  state.appointmentDates[index],
                  index,
                );
              },
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

  Widget _buildAnimatedCard(BuildContext context, appointment, int index) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        final clampedValue = value.clamp(0.0, 1.0);

        return Transform.scale(
          scale: clampedValue,
          child: Opacity(
            opacity: clampedValue,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.kPrimaryColor1.withValues(alpha: 0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      HapticFeedback.lightImpact();
                    },
                    child: AppointmentCard(
                      appointment: appointment,
                      id: appointmentId,
                      re: true,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      return 4;
    } else if (screenWidth > 400) {
      return 3;
    } else {
      return 2;
    }
  }

  double _getChildAspectRatio(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      return 0.85;
    } else if (screenWidth > 400) {
      return 0.8;
    } else {
      return 0.8;
    }
  }
}
