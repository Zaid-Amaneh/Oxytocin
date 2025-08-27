import 'package:oxytocin/features/profile/data/model/user_profile_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserProfileModel profile;
  ProfileLoaded(this.profile);
}

class ProfileUpdating extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}

class ProfileLoggedOut extends ProfileState {}
