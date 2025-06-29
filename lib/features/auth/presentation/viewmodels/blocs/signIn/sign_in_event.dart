part of 'sign_in_bloc.dart';

abstract class SignInEvent {}

class SignInSubmitted extends SignInEvent {
  final SignInRequest request;

  SignInSubmitted(this.request);
}
