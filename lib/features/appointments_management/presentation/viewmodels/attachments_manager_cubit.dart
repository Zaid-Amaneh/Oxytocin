import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/features/appointments_management/data/services/manage_attachment_service.dart';
import 'package:oxytocin/features/appointments_management/presentation/viewmodels/attachments_manager_state.dart';

class AttachmentsManagerCubit extends Cubit<AttachmentsManagerState> {
  final ManageAttachmentService _manageAttachmentService;

  AttachmentsManagerCubit(this._manageAttachmentService)
    : super(const AttachmentsManagerState());

  Future<void> fetchAttachments({required int appointmentId}) async {
    emit(state.copyWith(status: AttachmentStatus.loading));
    try {
      final attachments = await _manageAttachmentService.getAttachments(
        appointmentId: appointmentId,
      );
      emit(
        state.copyWith(
          status: AttachmentStatus.success,
          attachments: attachments,
        ),
      );
    } on Failure catch (e) {
      emit(
        state.copyWith(
          status: AttachmentStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> uploadNewAttachments({
    required int appointmentId,
    required List<String> filePaths,
  }) async {
    emit(state.copyWith(status: AttachmentStatus.uploading));
    try {
      await _manageAttachmentService.uploadAttachments(
        appointmentId: appointmentId,
        filePaths: filePaths,
      );
      await fetchAttachments(appointmentId: appointmentId);
    } on Failure catch (e) {
      emit(
        state.copyWith(
          status: AttachmentStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> deleteAttachment({
    required int appointmentId,
    required int attachmentId,
  }) async {
    emit(state.copyWith(status: AttachmentStatus.deleting));
    try {
      await _manageAttachmentService.deleteAttachment(
        appointmentId: appointmentId,
        attachmentId: attachmentId,
      );
      await fetchAttachments(appointmentId: appointmentId);
    } on Failure catch (e) {
      emit(
        state.copyWith(
          status: AttachmentStatus.error,
          errorMessage: e.toString(),
        ),
      );
      await fetchAttachments(appointmentId: appointmentId);
    }
  }
}
