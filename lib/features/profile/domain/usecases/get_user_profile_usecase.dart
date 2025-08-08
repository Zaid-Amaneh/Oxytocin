import 'package:oxytocin/features/profile/data/model/user_profile_model.dart';
import 'package:oxytocin/features/profile/data/repositories/profile_repository_impl.dart';

class GetUserProfileUseCase {
  final ProfileRepository _repository;

  GetUserProfileUseCase(this._repository);

  Future<UserProfileModel> call() async {
    return await _repository.getUserProfile();
  }
}
