import 'package:oxytocin/features/auth/data/models/sign_up_request.dart';
import 'package:oxytocin/features/auth/data/models/user_model.dart';
import 'package:oxytocin/features/auth/data/services/auth_service.dart';

class SignUpUseCase {
  final AuthService authService;

  SignUpUseCase({required this.authService});

  Future<UserModel> call(SignUpRequest request) async {
    return await authService.signUp(request);
  }
}
