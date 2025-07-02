import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/features/auth/data/models/forgot_password_request.dart';
import 'package:oxytocin/features/auth/domain/forgot_password_usecase.dart';
part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPasswordUseCase forgotPasswordUseCase;

  ForgotPasswordBloc(this.forgotPasswordUseCase)
    : super(ForgotPasswordInitial()) {
    on<SendPhoneNumberEvent>((event, emit) async {
      emit(ForgotPasswordLoading());

      try {
        final response = await forgotPasswordUseCase(
          ForgotPasswordRequest(phone: event.phone),
        );
        emit(ForgotPasswordSuccess(response.message));
      } on Failure catch (failure) {
        emit(ForgotPasswordFailure(failure));
      } catch (_) {
        emit(ForgotPasswordFailure(const ServerFailure()));
      }
    });
  }
}
