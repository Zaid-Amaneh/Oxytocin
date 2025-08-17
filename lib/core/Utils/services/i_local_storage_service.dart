import 'dart:async';

import 'dart:core';

abstract class ILocalStorageService {
  Future<void> setNewUserFlag(bool value);
  Future<bool> isNewUser();
  Future<void> clearAll();
  Future<void> setKeepUserSignedIn(bool value);
  Future<bool> isUserKeptSignedIn();

  // General storage methods
  Future<void> setValue(String key, dynamic value);
  Future<dynamic> getValue(String key);

  // Category and Subspecialty storage methods
  Future<void> saveSelectedCategory(int categoryId, String categoryNameAr);
  Future<void> saveSelectedSubspecialty(int subId, String subNameAr);
  Future<Map<String, dynamic>?> getSelectedCategory();
  Future<Map<String, dynamic>?> getSelectedSubspecialty();
  Future<void> clearSelectedCategory();
  Future<void> clearSelectedSubspecialty();
}
