class SpecialtyModel {
  final int id;
  final String nameEn;
  final String nameAr;

  SpecialtyModel({
    required this.id,
    required this.nameEn,
    required this.nameAr,
  });

  factory SpecialtyModel.fromJson(Map<String, dynamic> json) {
    return SpecialtyModel(
      id: json['id'],
      nameEn: json['name_en'],
      nameAr: json['name_ar'],
    );
  }
}
