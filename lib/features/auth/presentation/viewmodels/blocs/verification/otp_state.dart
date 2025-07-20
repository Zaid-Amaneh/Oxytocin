part of 'otp_bloc.dart';

abstract class OtpState {}

class OtpInitial extends OtpState {}

class OtpLoading extends OtpState {}

class OtpSuccess extends OtpState {
  final VerifyOtpResponse response;
  OtpSuccess(this.response);
}

class OtpResendSuccess extends OtpState {
  final String message;
  OtpResendSuccess(this.message);
}

class OtpFailure extends OtpState {
  final Failure error;
  OtpFailure(this.error);
}
