import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart' show Logger;
import 'package:oxytocin/core/Utils/services/i_secure_storage_service.dart';
import 'package:oxytocin/core/Utils/services/secure_storage_service.dart';
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
        final response = await loginUseCase(event.request);
        final ISecureStorageService secureStorageService =
            SecureStorageService();
        await secureStorageService.saveAccessToken(response.accessToken);
        await secureStorageService.saveRefreshToken(response.refreshToken);
        Logger().i(response.accessToken);
        Logger().i(response.refreshToken);
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
