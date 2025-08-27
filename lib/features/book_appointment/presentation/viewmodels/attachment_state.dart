import 'package:equatable/equatable.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/features/book_appointment/data/models/upload_attachments_response_model.dart';

abstract class AttachmentState extends Equatable {
  const AttachmentState();

  @override
  List<Object> get props => [];
}

class AttachmentInitial extends AttachmentState {}

class AttachmentLoading extends AttachmentState {}

class AttachmentSuccess extends AttachmentState {
  final UploadAttachmentsResponseModel response;

  const AttachmentSuccess({required this.response});

  @override
  List<Object> get props => [response];
}

class AttachmentFailure extends AttachmentState {
  final String errorMessage;
  final Failure failure;
  const AttachmentFailure({required this.errorMessage, required this.failure});

  @override
  List<Object> get props => [errorMessage];
}
