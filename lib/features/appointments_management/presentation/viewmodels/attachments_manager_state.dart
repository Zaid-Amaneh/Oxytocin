import 'package:equatable/equatable.dart';
import 'package:oxytocin/features/appointments_management/data/models/attachment_model.dart';

enum AttachmentStatus { initial, loading, success, error, uploading, deleting }

class AttachmentsManagerState extends Equatable {
  final AttachmentStatus status;
  final List<AttachmentModel> attachments;
  final String? errorMessage;

  const AttachmentsManagerState({
    this.status = AttachmentStatus.initial,
    this.attachments = const [],
    this.errorMessage,
  });

  AttachmentsManagerState copyWith({
    AttachmentStatus? status,
    List<AttachmentModel>? attachments,
    String? errorMessage,
  }) {
    return AttachmentsManagerState(
      status: status ?? this.status,
      attachments: attachments ?? this.attachments,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, attachments, errorMessage];
}
