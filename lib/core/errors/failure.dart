abstract class Failure {
  final String translationKey;

  const Failure(this.translationKey);
}

class ServerFailure extends Failure {
  const ServerFailure() : super('error_server');
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super('error_network');
}

class PhoneExistsFailure extends Failure {
  const PhoneExistsFailure() : super('error_phone_exists');
}

class PhoneInvalidFailure extends Failure {
  const PhoneInvalidFailure() : super('error_phone_invalid');
}

class InvalidCredentialsFailure extends Failure {
  const InvalidCredentialsFailure() : super('error_invalid_credentials');
}

class ValidationFailure extends Failure {
  const ValidationFailure() : super('error_validation');
}

class UnknownFailure extends Failure {
  const UnknownFailure() : super('error_unknown');
}

class OtpResendFailure extends Failure {
  const OtpResendFailure() : super('resend_otp_failed');
}

class InvalidOtpFailure extends Failure {
  const InvalidOtpFailure() : super('invalid_otp_code');
}

class OtpVerifiedSuccess extends Failure {
  const OtpVerifiedSuccess() : super('otp_verified_successfully');
}

class OtpResendSuccess extends Failure {
  const OtpResendSuccess() : super('resend_otp_success');
}

class UnverifiedPhoneFailure extends Failure {
  const UnverifiedPhoneFailure() : super('unverified_phone');
}
