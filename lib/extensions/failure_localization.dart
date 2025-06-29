import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/generated/l10n.dart';

extension FailureLocalization on S {
  String getTranslatedError(Failure failure) {
    switch (failure.translationKey) {
      case 'error_server':
        return error_server;
      case 'error_network':
        return error_network;
      case 'error_validation':
        return error_validation;
      case 'error_phone_exists':
        return error_phone_exists;
      case 'error_phone_invalid':
        return error_phone_invalid;
      case 'error_unknown':
        return error_unknown;
      case 'error_invalid_credentials':
        return error_invalid_credentials;
      case 'resend_otp_failed':
        return resend_otp_failed_title;
      case 'resend_otp_success':
        return resend_otp_success_title;
      case 'otp_verified_successfully':
        return otp_verified_successfully_title;
      case 'invalid_otp_code':
        return invalid_otp_code_title;
      case 'unverified_phone':
        return unverified_phone;
      default:
        return error_unknown;
    }
  }
}
