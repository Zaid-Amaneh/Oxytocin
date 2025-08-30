import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/l10n/app_localizations.dart';

extension FailureLocalization on AppLocalizations {
  String getTranslatedError(Failure failure) {
    switch (failure.translationKey) {
      case 'error_server':
        return errorServer;
      case 'error_network':
        return errorNetwork;
      case 'error_validation':
        return errorValidation;
      case 'error_phone_exists':
        return errorPhoneExists;
      case 'error_phone_invalid':
        return errorPhoneInvalid;
      case 'error_unknown':
        return errorUnknown;
      case 'error_invalid_credentials':
        return errorInvalidCredentials;
      case 'resend_otp_failed':
        return resendOtpFailedTitle;
      case 'resend_otp_success':
        return resendOtpSuccessTitle;
      case 'otp_verified_successfully':
        return otpVerifiedSuccessfullyTitle;
      case 'invalid_otp_code':
        return invalidOtpCodeTitle;
      case 'unverified_phone':
        return 'unverifiedPhone';
      case 'error_phone_not_found':
        return errorPhoneNotFound;
      case 'token_not_valid':
        return 'tokenNotValid';
      case 'authentication_failed':
        return authentication_failed;
      case 'appointment_not_available':
        return appointment_not_available;
      case 'files_upload_error':
        return files_upload_error;
      case 'invalid_uploaded_file':
        return invalid_uploaded_file;
      case 'patientBannedTitle':
        return patientBannedTitle;
      default:
        return errorUnknown;
    }
  }
}
