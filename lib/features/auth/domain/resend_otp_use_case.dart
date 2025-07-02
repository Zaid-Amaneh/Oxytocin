import 'package:oxytocin/features/auth/data/models/resend_otp_request.dart';
import 'package:oxytocin/features/auth/data/services/auth_service.dart';

class ResendOtpUseCase {
  final AuthService authService;

  ResendOtpUseCase({required this.authService});

  Future<String> call(ResendOtpRequest request) async {
    return await authService.resendOtp(request);
  }
}
