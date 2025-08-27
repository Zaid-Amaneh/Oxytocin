import 'dart:core';

abstract class ILocalStorageService {
  Future<void> setNewUserFlag(bool value);
  Future<bool> isNewUser();
  Future<void> clearAll();
  Future<void> setKeepUserSignedIn(bool value);
  Future<bool> isUserKeptSignedIn();
  Future<void> saveUserQuery(String value);
  Future<List<String>> getUserSearchHistory();
  Future<void> clearUserSearchHistory();

  Future<void> setValue(String key, dynamic value);
  Future<dynamic> getValue(String key);
  Future<void> saveSelectedCategory(int categoryId, String categoryNameAr);
  Future<void> saveSelectedSubspecialty(int subId, String subNameAr);
  Future<void> addCategoryToHistory(int categoryId, String categoryNameAr);
  Future<void> addSubspecialtyToHistory(int subId, String subNameAr);

  Future<List<Map<String, dynamic>>> getCategoryHistory();
  Future<List<Map<String, dynamic>>> getSubspecialtyHistory();

  Future<void> clearCategoryHistory();
  Future<void> clearSubspecialtyHistory();
}
