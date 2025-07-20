part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent {}

class SubmitChangePassword extends ChangePasswordEvent {
  final ChangePasswordRequest request;

  SubmitChangePassword(this.request);
}
