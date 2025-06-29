import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/features/auth/data/models/sign_in_request.dart';
import 'package:oxytocin/features/auth/data/models/sign_in_response.dart';
import 'package:oxytocin/features/auth/domain/sign_in_use_case.dart';
part 'sign_in_state.dart';
part 'sign_in_event.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInUseCase loginUseCase;

  SignInBloc(this.loginUseCase) : super(SignInInitial()) {
    on<SignInSubmitted>((event, emit) async {
      emit(SignInLoading());
      try {
        final response = await loginUseCase.execute(event.request);
        emit(SignInSuccess(response));
      } catch (e) {
        if (e is Failure) {
          emit(SignInFailure(e));
        } else {
          emit(SignInFailure(const UnknownFailure()));
        }
      }
    });
  }
}
