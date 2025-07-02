import 'package:oxytocin/features/auth/data/models/forgot_password_request.dart';
import 'package:oxytocin/features/auth/data/models/forgot_password_response.dart';
import 'package:oxytocin/features/auth/data/services/auth_service.dart';

class ForgotPasswordUseCase {
  final AuthService authService;

  ForgotPasswordUseCase({required this.authService});

  Future<ForgotPasswordResponse> call(ForgotPasswordRequest request) async {
    return await authService.forgotPassword(request);
  }
}
