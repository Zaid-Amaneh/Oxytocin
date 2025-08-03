import 'package:oxytocin/features/profile/data/repositories/profile_repository_impl.dart';

class LogoutUseCase {
  final ProfileRepository _repository;

  LogoutUseCase(this._repository);

  Future<void> call() async {
    await _repository.logout();
  }
}
