import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
  Future<void> newUser() async {
    await asyncPrefs.setBool('NewUser', false);
  }

  Future<bool> isNewUser() async {
    final bool newUser = await asyncPrefs.getBool('NewUser') ?? true;
    return newUser;
  }

  Future<void> clearsAllPreferences() async {
    await asyncPrefs.clear();
  }
}
