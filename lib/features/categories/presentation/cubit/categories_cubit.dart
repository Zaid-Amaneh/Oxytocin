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
      emit(
        state.copyWith(status: CategoriesStatus.failure, error: e.toString()),
      );
    }
  }

  void selectCategory(CategoryModel category) {
    print('=== تم اختيار الاختصاص الأساسي ===');
    print('Category ID: ${category.id}');
    print('Category Name (Ar): ${category.nameAr}');
    print('Category Name (En): ${category.nameEn}');
    print('================================');

    emit(state.copyWith(selectedCategory: category, selectedSub: null));
  }

  Future<void> selectSubspecialty(SubspecialtyModel sub) async {
    print('=== تم اختيار الاختصاص الفرعي ===');
    print('Subspecialty ID: ${sub.id}');
    print('Subspecialty Name (Ar): ${sub.nameAr}');
    print('Subspecialty Name (En): ${sub.nameEn}');

    if (state.selectedCategory != null) {
      print('--- الاختصاص الأساسي المرتبط ---');
      print('Category ID: ${state.selectedCategory!.id}');
      print('Category Name (Ar): ${state.selectedCategory!.nameAr}');
      print('Category Name (En): ${state.selectedCategory!.nameEn}');
    }
    print('================================');

    emit(state.copyWith(selectedSub: sub));

    // حفظ الاختيارات في التخزين المحلي باستخدام الـ methods الجديدة
    if (state.selectedCategory != null) {
      await localStorage.saveSelectedCategory(
        state.selectedCategory!.id,
        state.selectedCategory!.nameAr,
      );
      print('✅ تم حفظ الاختصاص الأساسي في التخزين المحلي');
    }
    await localStorage.saveSelectedSubspecialty(sub.id, sub.nameAr);
    print('✅ تم حفظ الاختصاص الفرعي في التخزين المحلي');

    // طباعة البيانات المحفوظة للتأكد
    await _printSavedData();
  }

  Future<void> loadSavedSelection() async {
    print('=== جاري تحميل الاختيارات المحفوظة ===');
    final savedCategory = await localStorage.getSelectedCategory();
    final savedSub = await localStorage.getSelectedSubspecialty();

    if (savedCategory != null) {
      print('📋 الاختصاص الأساسي المحفوظ:');
      print('   ID: ${savedCategory['id']}');
      print('   Name: ${savedCategory['nameAr']}');
    } else {
      print('❌ لا يوجد اختصاص أساسي محفوظ');
    }

    if (savedSub != null) {
      print('📋 الاختصاص الفرعي المحفوظ:');
      print('   ID: ${savedSub['id']}');
      print('   Name: ${savedSub['nameAr']}');
    } else {
      print('❌ لا يوجد اختصاص فرعي محفوظ');
    }

    if (savedCategory != null &&
        savedSub != null &&
        state.categories.isNotEmpty) {
      try {
        final category = state.categories.firstWhere(
          (c) => c.id == savedCategory['id'],
          orElse: () => state.categories.first,
        );

        final sub = category.subspecialties.firstWhere(
          (s) => s.id == savedSub['id'],
          orElse: () => category.subspecialties.first,
        );

        emit(state.copyWith(selectedCategory: category, selectedSub: sub));
        print('✅ تم تحميل الاختيارات بنجاح');
        print('   الاختصاص الأساسي: ${category.nameAr}');
        print('   الاختصاص الفرعي: ${sub.nameAr}');
      } catch (e) {
        print('❌ خطأ في تحميل الاختيارات: $e');
      }
    } else {
      print('❌ لا يمكن تحميل الاختيارات - بيانات غير مكتملة');
    }
    print('================================');
  }

  Future<void> clearSavedSelection() async {
    print('=== جاري مسح الاختيارات المحفوظة ===');
    await localStorage.clearSelectedCategory();
    await localStorage.clearSelectedSubspecialty();
    emit(state.copyWith(selectedCategory: null, selectedSub: null));
    print('✅ تم مسح جميع الاختيارات');
    print('================================');
  }

  // دالة مساعدة لطباعة البيانات المحفوظة
  Future<void> _printSavedData() async {
    print('=== البيانات المحفوظة حالياً ===');
    final savedCategory = await localStorage.getSelectedCategory();
    final savedSub = await localStorage.getSelectedSubspecialty();

    if (savedCategory != null) {
      print('📋 الاختصاص الأساسي:');
      print('   ID: ${savedCategory['id']}');
      print('   Name: ${savedCategory['nameAr']}');
    }

    if (savedSub != null) {
      print('📋 الاختصاص الفرعي:');
      print('   ID: ${savedSub['id']}');
      print('   Name: ${savedSub['nameAr']}');
    }

    if (savedCategory == null && savedSub == null) {
      print('❌ لا توجد بيانات محفوظة');
    }
    print('================================');
  }

  // دالة لفحص البيانات المحفوظة (يمكن استدعاؤها من أي مكان)
  Future<void> checkSavedData() async {
    print('🔍 === فحص شامل للبيانات المحفوظة ===');

    final savedCategory = await localStorage.getSelectedCategory();
    final savedSub = await localStorage.getSelectedSubspecialty();

    print('📊 ملخص البيانات:');
    print(
      '   الاختصاص الأساسي: ${savedCategory != null ? "✅ موجود" : "❌ غير موجود"}',
    );
    print(
      '   الاختصاص الفرعي: ${savedSub != null ? "✅ موجود" : "❌ غير موجود"}',
    );

    if (savedCategory != null) {
      print('📋 تفاصيل الاختصاص الأساسي:');
      print('   ID: ${savedCategory['id']}');
      print('   Name: ${savedCategory['nameAr']}');
    }

    if (savedSub != null) {
      print('📋 تفاصيل الاختصاص الفرعي:');
      print('   ID: ${savedSub['id']}');
      print('   Name: ${savedSub['nameAr']}');
    }

    // التحقق من تطابق البيانات مع الـ state
    if (state.selectedCategory != null) {
      print('🔄 مقارنة مع الـ state:');
      print('   State Category ID: ${state.selectedCategory!.id}');
      print('   Saved Category ID: ${savedCategory?['id']}');
      print('   متطابق: ${state.selectedCategory!.id == savedCategory?['id']}');
    }

    if (state.selectedSub != null) {
      print('   State Sub ID: ${state.selectedSub!.id}');
      print('   Saved Sub ID: ${savedSub?['id']}');
      print('   متطابق: ${state.selectedSub!.id == savedSub?['id']}');
    }

    print('================================');
  }
}
