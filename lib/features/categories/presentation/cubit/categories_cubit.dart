import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/core/Utils/services/local_storage_service.dart';
import 'package:oxytocin/features/categories/data/datasources/categories_remote_data_source.dart';
import 'package:oxytocin/features/categories/data/models/category_model.dart';

import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoriesRemoteDataSource remoteDataSource;
  final LocalStorageService localStorage;

  CategoriesCubit(this.remoteDataSource, this.localStorage)
      : super(CategoriesState());

  Future<void> fetchCategories() async {
    emit(state.copyWith(status: CategoriesStatus.loading));
    try {
      final cats = await remoteDataSource.fetchCategories();
      emit(state.copyWith(status: CategoriesStatus.success, categories: cats));
    } catch (e) {
      emit(state.copyWith(status: CategoriesStatus.failure, error: e.toString()));
    }
  }

  void selectCategory(CategoryModel category) {
    emit(state.copyWith(selectedCategory: category, selectedSub: null));
  }

  Future<void> selectSubspecialty(SubspecialtyModel sub) async {
    emit(state.copyWith(selectedSub: sub));

    // حفظ الاختيارات في التخزين المحلي
    await localStorage.setValue('selected_category_id', state.selectedCategory!.id);
    await localStorage.setValue('selected_category_name_ar', state.selectedCategory!.nameAr);
    await localStorage.setValue('selected_sub_id', sub.id);
    await localStorage.setValue('selected_sub_name_ar', sub.nameAr);
  }

  Future<void> loadSavedSelection() async {
    final catId = await localStorage.getValue('selected_category_id');
    final catName = await localStorage.getValue('selected_category_name_ar');
    final subId = await localStorage.getValue('selected_sub_id');
    final subName = await localStorage.getValue('selected_sub_name_ar');

    if (catId != null && subId != null && state.categories.isNotEmpty) {
      try {
        final category = state.categories.firstWhere(
          (c) => c.id == catId,
          orElse: () => state.categories.first,
        );
        
        final sub = category.subspecialties.firstWhere(
          (s) => s.id == subId,
          orElse: () => category.subspecialties.first,
        );

        emit(state.copyWith(selectedCategory: category, selectedSub: sub));
      } catch (e) {
        print('Error loading saved selection: $e');
      }
    }
  }
}
