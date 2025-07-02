part of 'verify_forgot_password_otp_bloc.dart';

abstract class VerifyForgotPasswordOtpState {}

class VerifyForgotPasswordOtpInitial extends VerifyForgotPasswordOtpState {}

class VerifyForgotPasswordOtpLoading extends VerifyForgotPasswordOtpState {}

class VerifyForgotPasswordOtpSuccess extends VerifyForgotPasswordOtpState {
  final VerifyOtpResponse response;

  VerifyForgotPasswordOtpSuccess(this.response);
}

class VerifyForgotPasswordOtpFailure extends VerifyForgotPasswordOtpState {
  final Failure error;

  VerifyForgotPasswordOtpFailure(this.error);
}
