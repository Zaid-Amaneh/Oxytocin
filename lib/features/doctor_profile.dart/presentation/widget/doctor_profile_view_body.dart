import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/widgets/sliver_divider.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/viewmodels/doctor_profile_cubit.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/viewmodels/doctor_profile_state.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/widget/clinic_evaluation.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/widget/clinic_photos_gallery.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/widget/doctor_info_section.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/widget/doctor_profile_shimmer.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/widget/doctor_profile_view_body_header.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/widget/error_display_widget.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/widget/review.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/widget/choose_appointment_date.dart';

class DoctorProfileViewBody extends StatelessWidget {
  const DoctorProfileViewBody({super.key, required this.doctorId});
  final int doctorId;
  @override
  Widget build(BuildContext context) {
    final appointments = [
      AppointmentModel(
        date: DateTime.now(),
        availableTimes: ['10:00', '08:00', '14:30', '16:45'],
      ),
      AppointmentModel(
        date: DateTime.now().add(const Duration(days: 1)),
        availableTimes: ['09:15', '11:30'],
      ),
      AppointmentModel(
        date: DateTime.now().add(const Duration(days: 2)),
        availableTimes: [], // لا توجد مواعيد
      ),
      AppointmentModel(
        date: DateTime.now().add(const Duration(days: 3)),
        availableTimes: [], // لا توجد مواعيد
      ),
      AppointmentModel(
        date: DateTime.now().add(const Duration(days: 4)),
        availableTimes: [], // لا توجد مواعيد
      ),
    ];
    return BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
      builder: (context, state) {
        if (state is DoctorProfileLoading) {
          return const DoctorProfileShimmer();
        } else if (state is DoctorProfileAllDataSuccess) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: DoctorProfileViewBodyHeader(
                  doctorName: state.doctorProfile.user.fullName,
                  imageUrl: state.doctorProfile.user.image ?? "",
                  rate: state.doctorProfile.rate,
                  specialty: Helper.isArabic(context)
                      ? state.doctorProfile.mainSpecialty.specialty.nameAr
                      : state.doctorProfile.mainSpecialty.specialty.nameEn,
                  margin: const EdgeInsets.all(0),
                ),
              ),

              SliverToBoxAdapter(
                child: ChooseAppointmentDate(
                  appointments: appointments,
                  onBookAppointment: (date, time) {
                    print('حجز موعد في $date الساعة $time');
                  },
                  onShowAllMonthDays: () {
                    print('عرض جميع أيام الشهر');
                  },
                ),
              ),
              // const SliverDivider(color: AppColors.textSecondary),
              // SliverToBoxAdapter(
              //   child: ClinicLocationPage(
              //     clinicLatitude: state.doctorProfile.clinic.latitude,
              //     clinicLongitude: state.doctorProfile.clinic.longitude,
              //     clinicName: state.doctorProfile.user.fullName,
              //     clinicLocation: state.doctorProfile.clinic.address,
              //     clinicPhone: state.doctorProfile.clinic.phone,
              //   ),
              // ),
              const SliverDivider(color: AppColors.textSecondary),
              SliverToBoxAdapter(
                child: ClinicPhotosGallery(imageUrls: state.clinicImages),
              ),
              const SliverDivider(color: AppColors.textSecondary),
              SliverToBoxAdapter(
                child: ClinicEvaluation(
                  rate: state.doctorProfile.rate,
                  evaluations: state.evaluations.results,
                  id: state.doctorProfile.user.id,
                ),
              ),
              const SliverDivider(color: AppColors.textSecondary),
              SliverToBoxAdapter(
                child: DoctorInfoSection(
                  placeOfStudy: state.doctorProfile.education,
                  about: state.doctorProfile.about,
                  age: state.doctorProfile.user.age ?? 0,
                  gender: state.doctorProfile.user.gender,
                  subSpecialty: state.doctorProfile.subspecialties,
                ),
              ),
            ],
          );
        } else if (state is DoctorProfileFailure) {
          return ErrorDisplayWidget(
            errorMessage: state.errorMessage,
            onRetry: () {
              context.read<DoctorProfileCubit>().fetchDoctorProfile(doctorId);
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
