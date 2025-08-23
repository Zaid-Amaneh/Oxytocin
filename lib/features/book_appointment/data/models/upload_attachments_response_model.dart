import 'package:equatable/equatable.dart';

class UploadAttachmentsResponseModel extends Equatable {
  final String details;

  const UploadAttachmentsResponseModel({required this.details});

  factory UploadAttachmentsResponseModel.fromJson(Map<String, dynamic> json) {
    return UploadAttachmentsResponseModel(details: json['details']);
  }

  @override
  List<Object?> get props => [details];
}
