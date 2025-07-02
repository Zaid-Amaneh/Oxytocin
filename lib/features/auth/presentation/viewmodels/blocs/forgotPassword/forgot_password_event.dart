part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent {}

class SendPhoneNumberEvent extends ForgotPasswordEvent {
  final String phone;

  SendPhoneNumberEvent(this.phone);
}
