// sign_up_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/features/auth/data/models/sign_up_request.dart';
import 'package:oxytocin/features/auth/data/models/user_model.dart';
import 'package:oxytocin/features/auth/domain/sign_up_use_case.dart';
part 'sign_up_state.dart';
part 'sign_up_event.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase signUpUseCase;

  SignUpBloc(this.signUpUseCase) : super(SignUpInitial()) {
    on<SignUpSubmitted>((event, emit) async {
      emit(SignUpLoading());
      try {
        final user = await signUpUseCase.execute(event.request);
        emit(SignUpSuccess(user));
      } catch (e) {
        if (e is Failure) {
          emit(SignUpFailure(e));
        } else {
          emit(SignUpFailure(const UnknownFailure()));
        }
      }
    });
  }
}
