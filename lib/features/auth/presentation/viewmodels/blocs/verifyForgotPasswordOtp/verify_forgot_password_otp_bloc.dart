import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import 'package:oxytocin/core/Utils/services/i_secure_storage_service.dart';
import 'package:oxytocin/core/Utils/services/secure_storage_service.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/features/auth/data/models/verify_otp_request.dart';
import 'package:oxytocin/features/auth/data/models/verify_otp_response.dart';
import 'package:oxytocin/features/auth/domain/verify_forgot_password_otp_use_case.dart';
part 'verify_forgot_password_otp_event.dart';
part 'verify_forgot_password_otp_state.dart';

class VerifyForgotPasswordOtpBloc
    extends Bloc<VerifyForgotPasswordOtpEvent, VerifyForgotPasswordOtpState> {
  final VerifyForgotPasswordOtpUseCase verifyForgotPasswordOtpUseCase;

  VerifyForgotPasswordOtpBloc(this.verifyForgotPasswordOtpUseCase)
    : super(VerifyForgotPasswordOtpInitial()) {
    on<SubmitForgotPasswordOtp>((event, emit) async {
      emit(VerifyForgotPasswordOtpLoading());

      try {
        final response = await verifyForgotPasswordOtpUseCase(event.request);
        final ISecureStorageService secureStorageService =
            SecureStorageService();
        await secureStorageService.saveAccessToken(response.accessToken);
        await secureStorageService.saveRefreshToken(response.refreshToken);
        Logger().i(response.accessToken);
        Logger().i(response.refreshToken);
        emit(VerifyForgotPasswordOtpSuccess(response));
      } catch (e) {
        if (e is Failure) {
          emit(VerifyForgotPasswordOtpFailure(e));
        } else {
          emit(VerifyForgotPasswordOtpFailure(const UnknownFailure()));
        }
      }
    });
  }
}
