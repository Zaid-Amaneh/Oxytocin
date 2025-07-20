part of 'sign_in_bloc.dart';

abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {
  final SignInResponse response;

  SignInSuccess(this.response);
}

class SignInFailure extends SignInState {
  final Failure error;

  SignInFailure(this.error);
}
