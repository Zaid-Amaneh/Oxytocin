import 'i_local_storage_service.dart';

class CategoryStorageHelper {
  final ILocalStorageService _storage;

  CategoryStorageHelper(this._storage);

  Future<void> saveCategory(int categoryId, String categoryNameAr) async {
    await _storage.saveSelectedCategory(categoryId, categoryNameAr);
  }

  Future<void> saveSubspecialty(int subId, String subNameAr) async {
    await _storage.saveSelectedSubspecialty(subId, subNameAr);
  }

  Future<void> saveCategoryAndSubspecialty(
    int categoryId,
    String categoryNameAr,
    int subId,
    String subNameAr,
  ) async {
    await _storage.saveSelectedCategory(categoryId, categoryNameAr);
    await _storage.saveSelectedSubspecialty(subId, subNameAr);
  }

  Future<Map<String, dynamic>?> getSavedCategory() async {
    return await _storage.getSelectedCategory();
  }

  Future<Map<String, dynamic>?> getSavedSubspecialty() async {
    return await _storage.getSelectedSubspecialty();
  }

  Future<Map<String, dynamic>?> getAllSavedSelections() async {
    final category = await _storage.getSelectedCategory();
    final subspecialty = await _storage.getSelectedSubspecialty();

    if (category != null && subspecialty != null) {
      return {'category': category, 'subspecialty': subspecialty};
    }
    return null;
  }

  Future<void> clearCategory() async {
    await _storage.clearSelectedCategory();
  }

  Future<void> clearSubspecialty() async {
    await _storage.clearSelectedSubspecialty();
  }

  Future<void> clearAllSelections() async {
    await _storage.clearSelectedCategory();
    await _storage.clearSelectedSubspecialty();
  }

  Future<bool> hasSavedSelections() async {
    final category = await _storage.getSelectedCategory();
    final subspecialty = await _storage.getSelectedSubspecialty();
    return category != null && subspecialty != null;
  }

  /// جلب ID الاختصاص الأساسي
  Future<int?> getCategoryId() async {
    final category = await _storage.getSelectedCategory();
    return category?['id'];
  }

  Future<int?> getSubspecialtyId() async {
    final subspecialty = await _storage.getSelectedSubspecialty();
    return subspecialty?['id'];
  }

  Future<String?> getCategoryName() async {
    final category = await _storage.getSelectedCategory();
    return category?['nameAr'];
  }

  Future<String?> getSubspecialtyName() async {
    final subspecialty = await _storage.getSelectedSubspecialty();
    return subspecialty?['nameAr'];
  }

  Future<void> printAllSavedData() async {
    final category = await _storage.getSelectedCategory();
    final subspecialty = await _storage.getSelectedSubspecialty();

    print(' الاختصاص الأساسي:');
    if (category != null) {
      print('   ID: ${category['id']}');
      print('   Name: ${category['nameAr']}');
    } else {}

    print(' الاختصاص الفرعي:');
    if (subspecialty != null) {
      print('   ID: ${subspecialty['id']}');
      print('   Name: ${subspecialty['nameAr']}');
    } else {}
  }

  Future<void> checkSavedData() async {
    final hasCategory = await _storage.getSelectedCategory() != null;
    final hasSubspecialty = await _storage.getSelectedSubspecialty() != null;
  }
}
