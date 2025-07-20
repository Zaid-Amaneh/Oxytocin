import 'package:shared_preferences/shared_preferences.dart';
import 'i_local_storage_service.dart';

class LocalStorageService implements ILocalStorageService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Future<void> setNewUserFlag(bool value) async {
    final prefs = await _prefs;
    await prefs.setBool('NewUser', value);
  }

  @override
  Future<bool> isNewUser() async {
    final prefs = await _prefs;
    return prefs.getBool('NewUser') ?? true;
  }

  @override
  Future<void> clearAll() async {
    final prefs = await _prefs;
    await prefs.clear();
  }

  @override
  Future<void> setKeepUserSignedIn(bool value) async {
    final prefs = await _prefs;
    await prefs.setBool('keep_signed_in', value);
  }

  @override
  Future<bool> isUserKeptSignedIn() async {
    final prefs = await _prefs;
    return prefs.getBool('keep_signed_in') ?? false;
  }
}
