import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/features/auth/data/models/resend_otp_request.dart';
import 'package:oxytocin/features/auth/data/models/verify_otp_request.dart';
import 'package:oxytocin/features/auth/data/models/verify_otp_response.dart';
import 'package:oxytocin/features/auth/domain/resend_otp_use_case.dart';
import 'package:oxytocin/features/auth/domain/verify_otp_use_case.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final VerifyOtpUseCase verifyOtpUseCase;
  final ResendOtpUseCase resendOtpUseCase;

  OtpBloc(this.verifyOtpUseCase, this.resendOtpUseCase) : super(OtpInitial()) {
    on<OtpSubmitted>((event, emit) async {
      emit(OtpLoading());
      try {
        final result = await verifyOtpUseCase.execute(event.request);
        emit(OtpSuccess(result));
      } catch (e) {
        emit(OtpFailure(e is Failure ? e : const UnknownFailure()));
      }
    });

    on<OtpResendRequested>((event, emit) async {
      emit(OtpLoading());
      try {
        final message = await resendOtpUseCase.execute(event.request);
        emit(OtpResendSuccess(message));
      } catch (e) {
        emit(OtpFailure(e is Failure ? e : const UnknownFailure()));
      }
    });
  }
}
