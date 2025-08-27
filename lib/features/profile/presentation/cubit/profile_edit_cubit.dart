import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/features/profile/data/model/user_profile_model.dart';
import 'package:oxytocin/features/profile/data/repositories/profile_repository_impl.dart';

// Events
abstract class ProfileEditEvent {}

class StartEditing extends ProfileEditEvent {}

class CancelEditing extends ProfileEditEvent {}

class UpdateProfile extends ProfileEditEvent {
  final UserProfileModel updatedProfile;
  UpdateProfile(this.updatedProfile);
}

// States
abstract class ProfileEditState {}

class ProfileEditInitial extends ProfileEditState {}

class ProfileEditMode extends ProfileEditState {
  final UserProfileModel originalProfile;
  ProfileEditMode(this.originalProfile);
}

class ProfileEditSaving extends ProfileEditState {
  final UserProfileModel originalProfile;
  ProfileEditSaving(this.originalProfile);
}

class ProfileEditSuccess extends ProfileEditState {
  final UserProfileModel updatedProfile;
  ProfileEditSuccess(this.updatedProfile);
}

class ProfileEditError extends ProfileEditState {
  final String message;
  final UserProfileModel originalProfile;
  ProfileEditError(this.message, this.originalProfile);
}

// Cubit
class ProfileEditCubit extends Cubit<ProfileEditState> {
  final ProfileRepository repository;
  File? _selectedImage;

  ProfileEditCubit(this.repository) : super(ProfileEditInitial());

  void startEditing(UserProfileModel profile) {
    emit(ProfileEditMode(profile));
  }

  void cancelEditing() {
    emit(ProfileEditInitial());
  }

  void setSelectedImage(File image) {
    _selectedImage = image;
  }

  // Future<void> updateProfileWithImage(File image) async {
  //   if (state is ProfileEditMode) {
  //     final currentState = state as ProfileEditMode;
  //     emit(ProfileEditSaving(currentState.originalProfile));

  //     try {
  //       final Map<String, dynamic> imageField = {'image': image};
  //       final result = await repository.updateProfile(imageField);
  //       emit(ProfileEditSuccess(result));
  //     } catch (e) {
  //       emit(ProfileEditError(e.toString(), currentState.originalProfile));
  //     }
  //   }
  // }

  // Future<void> updateProfile(UserProfileModel updatedProfile) async {
  //   if (state is ProfileEditMode) {
  //     final currentState = state as ProfileEditMode;
  //     emit(ProfileEditSaving(currentState.originalProfile));

  //     try {
  //       final Map<String, dynamic> updatedFields = {};

  //       final Map<String, dynamic> userData = {};

  //       if (updatedProfile.firstName !=
  //           currentState.originalProfile.firstName) {
  //         userData['first_name'] = updatedProfile.firstName;
  //       }
  //       if (updatedProfile.lastName != currentState.originalProfile.lastName) {
  //         userData['last_name'] = updatedProfile.lastName;
  //       }
  //       if (updatedProfile.gender != currentState.originalProfile.gender) {
  //         userData['gender'] = updatedProfile.gender;
  //       }
  //       if (updatedProfile.phone != currentState.originalProfile.phone) {
  //         userData['phone'] = updatedProfile.phone;
  //       }
  //       if (updatedProfile.birthDate !=
  //           currentState.originalProfile.birthDate) {
  //         userData['birth_date'] = updatedProfile.birthDate
  //             ?.toIso8601String()
  //             .split('T')[0];
  //       }

  //       if (userData.isNotEmpty) {
  //         updatedFields['user'] = userData;
  //       }
  //       final simpleFields = {
  //         'address': updatedProfile.address,
  //         'job': updatedProfile.job,
  //         'blood_type': updatedProfile.bloodType,
  //         'medical_history': updatedProfile.medicalHistory,
  //         'surgical_history': updatedProfile.surgicalHistory,
  //         'allergies': updatedProfile.allergies,
  //         'medicines': updatedProfile.medicines,
  //         'is_smoker': updatedProfile.isSmoker,
  //         'is_drinker': updatedProfile.isDrinker,
  //         'is_married': updatedProfile.isMarried,
  //         'longitude': updatedProfile.longitude,
  //         'latitude': updatedProfile.latitude,
  //       };

  //       simpleFields.forEach((key, value) {
  //         final originalValue = _getFieldValue(
  //           currentState.originalProfile,
  //           key,
  //         );
  //         if (value != originalValue) {
  //           updatedFields[key] = value;
  //         }
  //       });

  //       if (_selectedImage != null) {
  //         updatedFields['image'] = _selectedImage;
  //       }

  //       if (updatedFields.isEmpty) {
  //         emit(ProfileEditInitial());
  //         return;
  //       }

  //       final result = await repository.updateProfile(updatedFields);
  //       emit(ProfileEditSuccess(result));
  //       _selectedImage = null;
  //     } catch (e) {
  //       emit(ProfileEditError(e.toString(), currentState.originalProfile));
  //     }
  //   }
  // }
  Future<void> updateProfile(UserProfileModel updatedProfile) async {
    if (state is ProfileEditMode) {
      final currentState = state as ProfileEditMode;
      emit(ProfileEditSaving(currentState.originalProfile));

      try {
        final Map<String, dynamic> updatedFields = {};
        final Map<String, dynamic> userData = {};

        if (updatedProfile.firstName !=
            currentState.originalProfile.firstName) {
          userData['first_name'] = updatedProfile.firstName;
        }
        if (updatedProfile.lastName != currentState.originalProfile.lastName) {
          userData['last_name'] = updatedProfile.lastName;
        }
        if (updatedProfile.gender != currentState.originalProfile.gender) {
          userData['gender'] = updatedProfile.gender;
        }
        if (updatedProfile.phone != currentState.originalProfile.phone) {
          userData['phone'] = updatedProfile.phone;
        }
        if (_selectedImage != null) {
          userData['image'] = _selectedImage; // 👈 بتكون File
        }
        if (updatedProfile.birthDate !=
            currentState.originalProfile.birthDate) {
          userData['birth_date'] = updatedProfile.birthDate
              ?.toIso8601String()
              .split('T')[0];
        }
        if (userData.isNotEmpty) {
          updatedFields['user'] = userData;
        }

        // 🔹 باقي الحقول العادية
        final simpleFields = {
          'address': updatedProfile.address,
          'job': updatedProfile.job,
          'blood_type': updatedProfile.bloodType,
          'medical_history': updatedProfile.medicalHistory,
          'surgical_history': updatedProfile.surgicalHistory,
          'allergies': updatedProfile.allergies,
          'medicines': updatedProfile.medicines,
          'is_smoker': updatedProfile.isSmoker,
          'is_drinker': updatedProfile.isDrinker,
          'is_married': updatedProfile.isMarried,
          'longitude': updatedProfile.longitude,
          'latitude': updatedProfile.latitude,
        };

        simpleFields.forEach((key, value) {
          final originalValue = _getFieldValue(
            currentState.originalProfile,
            key,
          );
          if (value != originalValue) {
            updatedFields[key] = value;
          }
        });

        if (updatedFields.isEmpty) {
          emit(ProfileEditInitial());
          return;
        }

        final result = await repository.updateProfile(updatedFields);
        emit(ProfileEditSuccess(result));
        _selectedImage = null;
      } catch (e) {
        emit(ProfileEditError(e.toString(), currentState.originalProfile));
      }
    }
  }

  dynamic _getFieldValue(UserProfileModel profile, String field) {
    switch (field) {
      case 'address':
        return profile.address;
      case 'job':
        return profile.job;
      case 'blood_type':
        return profile.bloodType;
      case 'medical_history':
        return profile.medicalHistory;
      case 'surgical_history':
        return profile.surgicalHistory;
      case 'allergies':
        return profile.allergies;
      case 'medicines':
        return profile.medicines;
      case 'is_smoker':
        return profile.isSmoker;
      case 'is_drinker':
        return profile.isDrinker;
      case 'is_married':
        return profile.isMarried;
      case 'longitude':
        return profile.longitude;
      case 'latitude':
        return profile.latitude;
      default:
        return null;
    }
  }

  // dynamic _getFieldValue(UserProfileModel profile, String field) {
  //   switch (field) {
  //     case 'address':
  //       return profile.address;
  //     case 'job':
  //       return profile.job;
  //     case 'blood_type':
  //       return profile.bloodType;
  //     case 'medical_history':
  //       return profile.medicalHistory;
  //     case 'surgical_history':
  //       return profile.surgicalHistory;
  //     case 'allergies':
  //       return profile.allergies;
  //     case 'medicines':
  //       return profile.medicines;
  //     case 'is_smoker':
  //       return profile.isSmoker;
  //     case 'is_drinker':
  //       return profile.isDrinker;
  //     case 'is_married':
  //       return profile.isMarried;
  //     case 'longitude':
  //       return profile.longitude;
  //     case 'latitude':
  //       return profile.latitude;
  //     default:
  //       return null;
  //   }
  // }
}
