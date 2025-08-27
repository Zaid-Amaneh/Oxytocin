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

      await _tryLoadingSavedSelections(cats);
    } catch (e) {
      emit(
        state.copyWith(status: CategoriesStatus.failure, error: e.toString()),
      );
    }
  }

  Future<void> _tryLoadingSavedSelections(
    List<CategoryModel> allCategories,
  ) async {
    try {
      final savedCategory = await localStorage.getSelectedCategory();
      final savedSub = await localStorage.getSelectedSubspecialty();

      if (savedCategory != null &&
          savedSub != null &&
          allCategories.isNotEmpty) {
        final category = allCategories.firstWhere(
          (c) => c.id == savedCategory['id'],
        );

        if (category != null) {
          final sub = category.subspecialties.firstWhere(
            (s) => s.id == savedSub['id'],
          );
          if (sub != null) {
            emit(state.copyWith(selectedCategory: category, selectedSub: sub));
          }
        }
      }
    } catch (e) {
      print('Error loading saved selections: $e');
    }
  }

  void selectCategory(CategoryModel category) {
    emit(state.copyWith(selectedCategory: category, selectedSub: null));
  }

  Future<void> selectSubspecialty(SubspecialtyModel sub) async {
    emit(state.copyWith(selectedSub: sub));
    if (state.selectedCategory != null) {
      try {
        await localStorage.addCategoryToHistory(
          state.selectedCategory!.id,
          state.selectedCategory!.nameAr,
        );
        await localStorage.addSubspecialtyToHistory(sub.id, sub.nameAr);
      } catch (e) {
        print('Failed to save to history: $e');
      }
    }
  }

  Future<void> loadSavedSelection() async {}

  Future<void> clearSavedSelection() async {
    try {
      await localStorage.clearSelectedCategory();
      await localStorage.clearSelectedSubspecialty();
    } catch (e) {
      print('Failed to clear saved selection: $e');
    }
    emit(state.copyWith(selectedCategory: null, selectedSub: null));
  }
}
