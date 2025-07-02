part of 'change_password_bloc.dart';

abstract class ChangePasswordState {}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {}

class ChangePasswordSuccess extends ChangePasswordState {
  final ChangePasswordResponse response;

  ChangePasswordSuccess(this.response);
}

class ChangePasswordFailure extends ChangePasswordState {
  final Failure error;

  ChangePasswordFailure(this.error);
}
