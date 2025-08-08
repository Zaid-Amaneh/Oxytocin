import 'dart:async';


import 'dart:core';

abstract class ILocalStorageService {
  Future<void> setNewUserFlag(bool value);
  Future<bool> isNewUser();
  Future<void> clearAll();
  Future<void> setKeepUserSignedIn(bool value);
  Future<bool> isUserKeptSignedIn();
}
