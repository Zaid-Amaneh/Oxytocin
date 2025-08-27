import 'dart:convert';

import 'package:oxytocin/core/constants/api_endpoints.dart';

List<AttachmentModel> attachmentModelFromJson(String str) =>
    List<AttachmentModel>.from(
      json.decode(str).map((x) => AttachmentModel.fromJson(x)),
    );

class AttachmentModel {
  final int id;
  final String document;
  final String createdAt;

  AttachmentModel({
    required this.id,
    required this.document,
    required this.createdAt,
  });

  factory AttachmentModel.fromJson(Map<String, dynamic> json) =>
      AttachmentModel(
        id: json["id"],
        document: '${ApiEndpoints.baseURL}${json["document"]}',
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "document": document,
    "created_at": createdAt,
  };
}
