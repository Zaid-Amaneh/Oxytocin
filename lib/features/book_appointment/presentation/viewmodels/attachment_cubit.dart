import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/features/book_appointment/data/services/attachment_service.dart';
import 'attachment_state.dart';

class AttachmentCubit extends Cubit<AttachmentState> {
  final AttachmentService _attachmentService;

  AttachmentCubit(this._attachmentService) : super(AttachmentInitial());

  Future<void> uploadAttachments({
    required int appointmentId,
    required List<String> filePaths,
  }) async {
    emit(AttachmentLoading());
    try {
      final result = await _attachmentService.uploadAttachments(
        appointmentId: appointmentId,
        filePaths: filePaths,
      );
      emit(AttachmentSuccess(response: result));
    } on Failure catch (e) {
      emit(AttachmentFailure(errorMessage: e.toString(), failure: e));
    } catch (e) {
      emit(
        AttachmentFailure(
          errorMessage: e.toString(),
          failure: const UnknownFailure(),
        ),
      );
    }
  }
}
