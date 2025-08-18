import 'package:equatable/equatable.dart';

class ClinicImage extends Equatable {
  final int id;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ClinicImage({
    required this.id,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ClinicImage.fromJson(Map<String, dynamic> json) {
    return ClinicImage(
      id: json['id'] ?? 0,
      image: json['image'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  ClinicImage copyWith({
    int? id,
    String? image,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ClinicImage(
      id: id ?? this.id,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object> get props => [id, image, createdAt, updatedAt];

  @override
  String toString() {
    return 'ClinicImage(id: $id, image: $image, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
