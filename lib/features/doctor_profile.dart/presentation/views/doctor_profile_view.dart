import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/viewmodels/doctor_profile_cubit.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/viewmodels/favorites_cubit.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/viewmodels/favorites_state.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/widget/doctor_profile_app_bar.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/widget/doctor_profile_view_body.dart';
import 'package:toastification/toastification.dart';

class DoctorProfileView extends StatelessWidget {
  const DoctorProfileView({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavoritesCubit, FavoritesState>(
      listener: (context, state) {
        if (state is FavoritesAddSuccess) {
          Helper.customToastification(
            context: context,
            type: ToastificationType.success,
            title: context.tr.success_title,
            description: context.tr.doctor_added_success,
            seconds: 5,
          );

          context.read<DoctorProfileCubit>().toggleFavoriteStatus();
        } else if (state is FavoritesRemoveSuccess) {
          Helper.customToastification(
            context: context,
            type: ToastificationType.success,
            title: context.tr.success_title,
            description: context.tr.doctor_removed_success,
            seconds: 5,
          );
          context.read<DoctorProfileCubit>().toggleFavoriteStatus();
        } else if (state is FavoritesFailure) {
          if (state.errorMessage.contains('AuthenticationFailure')) {
            Helper.customToastification(
              context: context,
              type: ToastificationType.error,
              title: context.tr.failure_title,
              description: context.tr.doctor_added_failure_auth,
              seconds: 5,
            );
          } else {
            Helper.customToastification(
              context: context,
              type: ToastificationType.error,
              title: context.tr.failure_title,
              description: context.tr.doctor_added_failure_network,
              seconds: 5,
            );
          }
        }
      },
      child: Scaffold(
        appBar: DoctorAppBar(doctorId: id),
        body: DoctorProfileViewBody(doctorId: id),
      ),
    );
  }
}
