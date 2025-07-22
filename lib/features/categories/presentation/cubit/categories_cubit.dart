import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/features/categories/data/models/category_model.dart';
import 'package:oxytocin/features/categories/presentation/cubit/categories_state.dart';


class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  final List<CategoryModel> _allCategories = [
    CategoryModel(name: "الغدد الصماء", icon: Icons.medical_services),
    CategoryModel(name: "المسالك البولية", icon: Icons.healing),
    CategoryModel(name: "القلب والأوعية", icon: Icons.favorite),
    CategoryModel(name: "الجهاز الهضمي", icon: Icons.local_hospital),
    CategoryModel(name: "طب الرئة", icon: Icons.air),
    CategoryModel(name: "جراحة التجميل", icon: Icons.face),
    CategoryModel(name: "طب العيون", icon: Icons.remove_red_eye),
    CategoryModel(name: "طب الأسنان", icon: Icons.medical_information),
    // ضيفي يلي بدك ياه
  ];

  void loadCategories() {
    emit(CategoriesLoaded(_allCategories));
  }

  void search(String query) {
    final filtered = _allCategories
        .where((cat) => cat.name.contains(query))
        .toList();

    emit(CategoriesLoaded(filtered));
  }
}
