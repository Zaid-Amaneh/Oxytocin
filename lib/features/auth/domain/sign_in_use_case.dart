import 'package:oxytocin/features/auth/data/models/sign_in_request.dart';
import 'package:oxytocin/features/auth/data/models/sign_in_response.dart';
import 'package:oxytocin/features/auth/data/services/auth_service.dart';

class SignInUseCase {
  final AuthService repository;

  SignInUseCase(this.repository);

  Future<SignInResponse> execute(SignInRequest request) {
    return repository.login(request);
  }
}
