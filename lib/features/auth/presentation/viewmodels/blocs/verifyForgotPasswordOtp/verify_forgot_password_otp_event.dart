part of 'verify_forgot_password_otp_bloc.dart';

abstract class VerifyForgotPasswordOtpEvent {}

class SubmitForgotPasswordOtp extends VerifyForgotPasswordOtpEvent {
  final VerifyOtpRequest request;

  SubmitForgotPasswordOtp(this.request);
}
