import 'package:oxytocin/features/auth/data/models/verify_otp_request.dart';
import 'package:oxytocin/features/auth/data/models/verify_otp_response.dart';
import 'package:oxytocin/features/auth/data/services/auth_service.dart';

class VerifyOtpUseCase {
  final AuthService repository;

  VerifyOtpUseCase(this.repository);

  Future<VerifyOtpResponse> execute(VerifyOtpRequest request) {
    return repository.verifyOtp(request);
  }
}
