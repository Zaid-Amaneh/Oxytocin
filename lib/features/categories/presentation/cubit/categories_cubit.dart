import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/features/categories/data/models/category_model.dart';
import 'package:oxytocin/features/categories/presentation/cubit/categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  final List<CategoryModel> _allCategories = [
    // الفئات الأساسية
    CategoryModel(
      name: "الغدد الصماء",
      iconAsset: AppImages.categoryEndocrineGlands,
    ),
    CategoryModel(
      name: "المسالك البولية",
      iconAsset: AppImages.categoryUrinaryTract,
    ),
    CategoryModel(
      name: "الجهاز الهضمي",
      iconAsset: AppImages.categoryDigestiveSystem,
    ),
    CategoryModel(
      name: "طب الرئة",
      iconAsset: AppImages.categoryPulmonaryMedicine,
    ),
    CategoryModel(
      name: "جراحة التجميل",
      iconAsset: AppImages.categoryPlasticSurgery,
    ),
    CategoryModel(name: "طب العيون", iconAsset: AppImages.categoryEyes),
    CategoryModel(name: "طب الأسنان", iconAsset: AppImages.categoryDentistry),
    CategoryModel(name: "التخدير", iconAsset: AppImages.categoryAnesthesia),
    CategoryModel(
      name: "أنف وأذن وحنجرة",
      iconAsset: AppImages.categoryEarNoseThroat,
    ),
    CategoryModel(name: "طب الأعصاب", iconAsset: AppImages.categoryNerves),
    CategoryModel(
      name: "طب العمل",
      iconAsset: AppImages.categoryOccupationalMedicine,
    ),
    CategoryModel(name: "الأشعة", iconAsset: AppImages.categoryRays),
    CategoryModel(name: "طب النفس", iconAsset: AppImages.categoryMyself),
    // جميع الفئات المتبقية من الصور الموجودة
  ];

  void loadCategories() {
    print('Loading categories...'); // للتصحيح
    print('Categories count: ${_allCategories.length}'); // للتصحيح

    // طباعة جميع مسارات الصور للتأكد
    for (int i = 0; i < _allCategories.length; i++) {
      print(
        'Category ${i + 1}: ${_allCategories[i].name} -> ${_allCategories[i].iconAsset}',
      );
    }

    emit(CategoriesLoaded(_allCategories));
  }

  void search(String query) {
    final filtered = _allCategories
        .where((cat) => cat.name.contains(query))
        .toList();

    emit(CategoriesLoaded(filtered));
  }
}
