import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/widgets/custom_back_button.dart';
import 'package:oxytocin/core/widgets/skeleton_loading_app_bar.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/viewmodels/doctor_profile_cubit.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/viewmodels/doctor_profile_state.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/widget/animated_favorite_button.dart';

class DoctorAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ValueChanged<bool>? onFavoriteToggle;
  final Color backgroundColor;
  final Color textColor;
  final int doctorId;
  const DoctorAppBar({
    super.key,
    this.onFavoriteToggle,
    this.backgroundColor = AppColors.kPrimaryColor1,
    this.textColor = Colors.black,
    required this.doctorId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
      builder: (context, state) {
        if (state is DoctorProfileAllDataSuccess) {
          bool isFavorite = state.doctorProfile.isFavorite;
          return AppBar(
            backgroundColor: backgroundColor,
            leading: Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.kPrimaryColor1.withValues(alpha: 0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                    spreadRadius: 1,
                  ),
                  const BoxShadow(
                    color: Color(0x0F000000),
                    blurRadius: 4,
                    offset: Offset(0, 1),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: const CustomeBackButton(),
            ),
            title: Text(
              state.doctorProfile.user.fullName,
              style: AppStyles.almaraiBold(context).copyWith(fontSize: 16),
            ),
            centerTitle: true,
            actions: [
              AnimatedFavoriteButton(
                doctorId: doctorId,
                initialFavoriteStatus: isFavorite,
              ),
            ],
          );
        } else {
          return const SkeletonLoadingAppBar();
        }
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
