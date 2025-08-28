import 'package:oxytocin/features/categories/data/models/category_model.dart';
import 'package:oxytocin/features/categories/data/models/doctors_response.dart';

enum CategoriesStatus { initial, loading, success, failure }

class CategoriesState {
  final CategoriesStatus status;
  final List<CategoryModel> categories;
  final CategoryModel? selectedCategory;
  final SubspecialtyModel? selectedSub;
  final String? error;
  final List<DoctorsResponse> doctors;
  CategoriesState({
    this.status = CategoriesStatus.initial,
    this.categories = const [],
    this.selectedCategory,
    this.selectedSub,
    this.error,
    this.doctors = const [],
  });

  CategoriesState copyWith({
    CategoriesStatus? status,
    List<CategoryModel>? categories,
    CategoryModel? selectedCategory,
    SubspecialtyModel? selectedSub,
    String? error,
    List<DoctorsResponse>? doctors,
  }) {
    return CategoriesState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedSub: selectedSub ?? this.selectedSub,
      error: error ?? this.error,
      doctors: doctors ?? this.doctors,
    );
  }
}
