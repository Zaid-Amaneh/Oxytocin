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
}
