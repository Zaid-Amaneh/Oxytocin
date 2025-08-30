import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/features/profile/data/model/user_profile_model.dart';
import 'package:oxytocin/features/profile/presentation/widget/profile_edit_form.dart';
import 'package:oxytocin/features/profile/di/profile_dependency_injection.dart';
import 'package:oxytocin/features/profile/presentation/cubit/profile_edit_cubit.dart';

class ProfileEditView extends StatefulWidget {
  final UserProfileModel profile;

  const ProfileEditView({super.key, required this.profile});

  @override
  State<ProfileEditView> createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends State<ProfileEditView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ProfileDependencyInjection.getProfileEditCubit()
            ..startEditing(widget.profile),
      child: BlocConsumer<ProfileEditCubit, ProfileEditState>(
        listener: (context, state) {
          if (state is ProfileEditError) {
          } else if (state is ProfileEditSuccess) {
            Navigator.pop(context, state.updatedProfile);
          }
        },
        builder: (context, state) {
          final isSaving = state is ProfileEditSaving;
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              backgroundColor: AppColors.kPrimaryColor1,
              foregroundColor: Colors.white,
              title: Text(
                context.tr.editProfile,
                // 'تعديل الملف الشخصي',
                style: TextStyle(
                  fontFamily: 'AlmaraiBold',
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
            ),
            body: AbsorbPointer(
              absorbing: isSaving,
              child: Stack(
                children: [
                  ProfileEditForm(
                    profile: widget.profile,
                    onSave: (p) =>
                        context.read<ProfileEditCubit>().updateProfile(p),
                    onCancel: () => Navigator.of(context).pop(),
                    isLoading: isSaving,
                  ),
                  if (isSaving)
                    const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.kPrimaryColor1,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
