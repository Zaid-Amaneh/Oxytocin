import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/features/profile/data/model/user_profile_model.dart';
import 'package:oxytocin/features/profile/domain/usecases/get_user_profile_usecase.dart';
import 'package:oxytocin/features/profile/domain/usecases/logout_usecase.dart';
import 'package:oxytocin/features/profile/domain/usecases/update_user_profile_usecase.dart';
import 'package:oxytocin/features/profile/presentation/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetUserProfileUseCase _getUserProfileUseCase;
  final UpdateUserProfileUseCase _updateUserProfileUseCase;
  final LogoutUseCase _logoutUseCase;

  ProfileCubit({
    required GetUserProfileUseCase getUserProfileUseCase,
    required UpdateUserProfileUseCase updateUserProfileUseCase,
    required LogoutUseCase logoutUseCase,
  }) : _getUserProfileUseCase = getUserProfileUseCase,
       _updateUserProfileUseCase = updateUserProfileUseCase,
       _logoutUseCase = logoutUseCase,
       super(ProfileInitial());

  Future<void> getUserProfile() async {
    emit(ProfileLoading());
    try {
      final profile = await _getUserProfileUseCase();
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> updateUserProfile(UserProfileModel profile) async {
    emit(ProfileUpdating());
    try {
      final updatedProfile = await _updateUserProfileUseCase(profile);
      emit(ProfileLoaded(updatedProfile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(ProfileLoggingOut());
    try {
      await _logoutUseCase();
      emit(ProfileLoggedOut());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
