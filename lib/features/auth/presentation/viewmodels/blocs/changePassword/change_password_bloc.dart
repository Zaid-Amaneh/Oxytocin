import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/features/auth/data/models/change_password_request.dart';
import 'package:oxytocin/features/auth/data/models/change_password_response.dart';
import 'package:oxytocin/features/auth/domain/change_password_use_case.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ChangePasswordUseCase useCase;

  ChangePasswordBloc(this.useCase) : super(ChangePasswordInitial()) {
    on<SubmitChangePassword>((event, emit) async {
      emit(ChangePasswordLoading());
      try {
        final response = await useCase(event.request);
        emit(ChangePasswordSuccess(response));
      } catch (e) {
        if (e is Failure) {
          emit(ChangePasswordFailure(e));
        } else {
          emit(ChangePasswordFailure(const UnknownFailure()));
        }
      }
    });
  }
}
