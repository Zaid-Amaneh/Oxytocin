part of 'otp_bloc.dart';

abstract class OtpEvent {}

class OtpSubmitted extends OtpEvent {
  final VerifyOtpRequest request;
  OtpSubmitted(this.request);
}

class OtpResendRequested extends OtpEvent {
  final ResendOtpRequest request;
  OtpResendRequested(this.request);
}
