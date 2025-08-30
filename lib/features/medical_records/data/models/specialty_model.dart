import 'dart:convert';

List<SpecialtyModel> specialtyModelFromJson(String str) =>
    List<SpecialtyModel>.from(
      json.decode(str).map((x) => SpecialtyModel.fromJson(x)),
    );

class SpecialtyModel {
  final int id;
  final String nameEn;
  final String nameAr;
  final String? image;

  SpecialtyModel({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    this.image,
  });

  factory SpecialtyModel.fromJson(Map<String, dynamic> json) => SpecialtyModel(
    id: json["id"],
    nameEn: json["name_en"],
    nameAr: json["name_ar"],
    image: json["image"],
  );
}
