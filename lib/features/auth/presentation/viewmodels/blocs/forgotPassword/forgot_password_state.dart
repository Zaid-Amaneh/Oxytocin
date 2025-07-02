part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordSuccess extends ForgotPasswordState {
  final String message;

  ForgotPasswordSuccess(this.message);
}

class ForgotPasswordFailure extends ForgotPasswordState {
  final Failure failure;

  ForgotPasswordFailure(this.failure);
}
