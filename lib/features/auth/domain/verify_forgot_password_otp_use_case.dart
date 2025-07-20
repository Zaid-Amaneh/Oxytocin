import 'package:oxytocin/features/auth/data/models/verify_otp_request.dart';
import 'package:oxytocin/features/auth/data/models/verify_otp_response.dart';
import 'package:oxytocin/features/auth/data/services/auth_service.dart';

class VerifyForgotPasswordOtpUseCase {
  final AuthService authService;

  VerifyForgotPasswordOtpUseCase({required this.authService});

  Future<VerifyOtpResponse> call(VerifyOtpRequest request) async {
    return await authService.verifyForgotPasswordOtp(request);
  }
}
