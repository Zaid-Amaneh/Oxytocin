import 'package:shared_preferences/shared_preferences.dart';
import 'i_local_storage_service.dart';

class LocalStorageService implements ILocalStorageService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static const String _searchHistoryKey = 'user_search_history';

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

  @override
  Future<void> saveUserQuery(String value) async {
    final prefs = await _prefs;
    List<String> history = prefs.getStringList(_searchHistoryKey) ?? [];
    history.remove(value);
    if (value.isNotEmpty) {
      history.insert(0, value);
    }
    if (history.length > 10) {
      history = history.sublist(0, 10);
    }

    await prefs.setStringList(_searchHistoryKey, history);
  }

  @override
  Future<List<String>> getUserSearchHistory() async {
    final prefs = await _prefs;
    return prefs.getStringList(_searchHistoryKey) ?? [];
  }

  @override
  Future<void> clearUserSearchHistory() async {
    final prefs = await _prefs;
    await prefs.remove(_searchHistoryKey);
  }
}
