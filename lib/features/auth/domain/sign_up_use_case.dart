import 'package:oxytocin/features/auth/data/models/sign_up_request.dart';
import 'package:oxytocin/features/auth/data/models/user_model.dart';
import 'package:oxytocin/features/auth/data/services/auth_service.dart';

class SignUpUseCase {
  final AuthService repository;

  SignUpUseCase(this.repository);

  Future<UserModel> execute(SignUpRequest request) {
    return repository.signUp(request);
  }
}
