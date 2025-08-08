import 'package:oxytocin/features/profile/data/model/user_profile_model.dart';
import 'package:oxytocin/features/profile/data/repositories/profile_repository_impl.dart';

class UpdateUserProfileUseCase {
  final ProfileRepository _repository;

  UpdateUserProfileUseCase(this._repository);

  Future<UserProfileModel> call(UserProfileModel profile) async {
    return await _repository.updateUserProfile(profile);
  }
}
