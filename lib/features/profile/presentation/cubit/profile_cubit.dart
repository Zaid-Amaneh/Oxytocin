// // features/profile/presentation/cubit/profile_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/features/profile/data/model/user_profile_model.dart';
import 'package:oxytocin/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:oxytocin/features/profile/presentation/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository repository;
  ProfileCubit(this.repository) : super(ProfileInitial());
  Future<void> getProfile() async {
    emit(ProfileLoading());
    try {
      final profile = await repository.getProfile();
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> updateProfile(UserProfileModel profile) async {
    emit(ProfileUpdating());
    try {
      final updatedProfile = await repository.updateProfile(profile);
      emit(ProfileLoaded(updatedProfile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
