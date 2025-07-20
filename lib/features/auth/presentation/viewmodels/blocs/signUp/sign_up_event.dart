part of 'sign_up_bloc.dart';

abstract class SignUpEvent {}

class SignUpSubmitted extends SignUpEvent {
  final SignUpRequest request;

  SignUpSubmitted(this.request);
}
