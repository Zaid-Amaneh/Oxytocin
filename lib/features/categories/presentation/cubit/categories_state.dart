import 'package:oxytocin/features/categories/data/models/category_model.dart';


abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final List<CategoryModel> categories;

  CategoriesLoaded(this.categories);
}
