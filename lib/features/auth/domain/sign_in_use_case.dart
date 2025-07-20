import 'package:oxytocin/features/auth/data/models/sign_in_request.dart';
import 'package:oxytocin/features/auth/data/models/sign_in_response.dart';
import 'package:oxytocin/features/auth/data/services/auth_service.dart';

class SignInUseCase {
  final AuthService authService;

  SignInUseCase({required this.authService});

  Future<SignInResponse> call(SignInRequest request) async {
    return await authService.login(request);
  }
}
