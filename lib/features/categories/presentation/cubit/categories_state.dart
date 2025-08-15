import 'package:oxytocin/features/categories/data/models/category_model.dart';

enum CategoriesStatus { initial, loading, success, failure }

class CategoriesState {
  final CategoriesStatus status;
  final List<CategoryModel> categories;
  final CategoryModel? selectedCategory;
  final SubspecialtyModel? selectedSub;
  final String? error;

  CategoriesState({
    this.status = CategoriesStatus.initial,
    this.categories = const [],
    this.selectedCategory,
    this.selectedSub,
    this.error,
  });

  CategoriesState copyWith({
    CategoriesStatus? status,
    List<CategoryModel>? categories,
    CategoryModel? selectedCategory,
    SubspecialtyModel? selectedSub,
    String? error,
  }) {
    return CategoriesState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedSub: selectedSub ?? this.selectedSub,
      error: error ?? this.error,
    );
  }
}
