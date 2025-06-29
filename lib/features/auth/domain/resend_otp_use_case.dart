import 'package:oxytocin/features/auth/data/models/resend_otp_request.dart';
import 'package:oxytocin/features/auth/data/services/auth_service.dart';

class ResendOtpUseCase {
  final AuthService repository;

  ResendOtpUseCase(this.repository);

  Future<String> execute(ResendOtpRequest request) {
    return repository.resendOtp(request);
  }
}
