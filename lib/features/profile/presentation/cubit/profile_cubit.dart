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

  void refreshWith(UserProfileModel profile) {
    emit(ProfileLoaded(profile));
  }

  Future<void> logout() async {
    emit(ProfileLoading());
    try {
      await repository.logout();
      await Future.delayed(const Duration(milliseconds: 500));
      emit(ProfileLoggedOut());
    } catch (e) {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(ProfileLoggedOut());
    }
  }
}
