import 'package:oxytocin/features/medical_records/data/models/specialty_model.dart';

class SpecialtyAccess {
  final int id;
  final SpecialtyModel specialty;
  final String visibility;
  final DateTime createdAt;
  final DateTime updatedAt;

  SpecialtyAccess({
    required this.id,
    required this.specialty,
    required this.visibility,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SpecialtyAccess.fromJson(Map<String, dynamic> json) {
    return SpecialtyAccess(
      id: json['id'],
      specialty: SpecialtyModel.fromJson(json['specialty']),
      visibility: json['visibility'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
  SpecialtyAccess copyWith({
    int? id,
    SpecialtyModel? specialty,
    String? visibility,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SpecialtyAccess(
      id: id ?? this.id,
      specialty: specialty ?? this.specialty,
      visibility: visibility ?? this.visibility,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
