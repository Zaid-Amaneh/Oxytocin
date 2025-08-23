import 'package:flutter/material.dart';

class SubspecialtyModel {
  final int id;
  final String nameEn;
  final String nameAr;

  SubspecialtyModel({required this.id, required this.nameEn, required this.nameAr});

  factory SubspecialtyModel.fromJson(Map<String, dynamic> json) {
    return SubspecialtyModel(
      id: json['id'],
      nameEn: json['name_en'],
      nameAr: json['name_ar'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name_en': nameEn,
    'name_ar': nameAr,
  };
}

class CategoryModel {
  final int id;
  final String nameEn;
  final String nameAr;
  final List<SubspecialtyModel> subspecialties;

  CategoryModel({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.subspecialties,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      nameEn: json['name_en'],
      nameAr: json['name_ar'],
      subspecialties: (json['subspecialties'] as List)
          .map((e) => SubspecialtyModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name_en': nameEn,
    'name_ar': nameAr,
    'subspecialties': subspecialties.map((e) => e.toJson()).toList(),
  };
}
