import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'i_local_storage_service.dart';

class LocalStorageService implements ILocalStorageService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static const String _searchHistoryKey = 'user_search_history';
  static const String _categoryHistoryKey = 'category_history';
  static const String _subspecialtyHistoryKey = 'subspecialty_history';
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

  @override
  Future<void> setValue(String key, dynamic value) async {
    final prefs = await _prefs;
    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    }
  }

  @override
  Future<dynamic> getValue(String key) async {
    final prefs = await _prefs;
    return prefs.get(key);
  }

  @override
  Future<void> saveSelectedCategory(
    int categoryId,
    String categoryNameAr,
  ) async {
    final prefs = await _prefs;
    await prefs.setInt('selected_category_id', categoryId);
    await prefs.setString('selected_category_name_ar', categoryNameAr);
  }

  @override
  Future<void> saveSelectedSubspecialty(int subId, String subNameAr) async {
    final prefs = await _prefs;
    await prefs.setInt('selected_sub_id', subId);
    await prefs.setString('selected_sub_name_ar', subNameAr);
  }

  @override
  Future<Map<String, dynamic>?> getSelectedCategory() async {
    final prefs = await _prefs;
    final categoryId = prefs.getInt('selected_category_id');
    final categoryNameAr = prefs.getString('selected_category_name_ar');

    if (categoryId != null && categoryNameAr != null) {
      return {'id': categoryId, 'nameAr': categoryNameAr};
    } else {
      return null;
    }
  }

  @override
  Future<Map<String, dynamic>?> getSelectedSubspecialty() async {
    final prefs = await _prefs;
    final subId = prefs.getInt('selected_sub_id');
    final subNameAr = prefs.getString('selected_sub_name_ar');
    if (subId != null && subNameAr != null) {
      return {'id': subId, 'nameAr': subNameAr};
    } else {
      return null;
    }
  }

  @override
  Future<void> clearSelectedCategory() async {
    final prefs = await _prefs;
    await prefs.remove('selected_category_id');
    await prefs.remove('selected_category_name_ar');
  }

  @override
  Future<void> clearSelectedSubspecialty() async {
    final prefs = await _prefs;
    await prefs.remove('selected_sub_id');
    await prefs.remove('selected_sub_name_ar');
  }

  @override
  Future<void> addCategoryToHistory(
    int categoryId,
    String categoryNameAr,
  ) async {
    final prefs = await _prefs;
    final history = await getCategoryHistory();
    final newEntry = {'id': categoryId, 'nameAr': categoryNameAr};
    history.removeWhere((item) => item['id'] == categoryId);
    history.insert(0, newEntry);
    final historyJson = jsonEncode(history);
    await prefs.setString(_categoryHistoryKey, historyJson);
  }

  @override
  Future<void> addSubspecialtyToHistory(int subId, String subNameAr) async {
    final prefs = await _prefs;
    final history = await getSubspecialtyHistory();
    final newEntry = {'id': subId, 'nameAr': subNameAr};

    history.removeWhere((item) => item['id'] == subId);
    history.insert(0, newEntry);

    final historyJson = jsonEncode(history);
    await prefs.setString(_subspecialtyHistoryKey, historyJson);
  }

  @override
  Future<List<Map<String, dynamic>>> getCategoryHistory() async {
    final prefs = await _prefs;
    final historyJson = prefs.getString(_categoryHistoryKey);
    if (historyJson != null) {
      final List<dynamic> historyList = jsonDecode(historyJson);
      return historyList.cast<Map<String, dynamic>>();
    }
    return [];
  }

  @override
  Future<List<Map<String, dynamic>>> getSubspecialtyHistory() async {
    final prefs = await _prefs;
    final historyJson = prefs.getString(_subspecialtyHistoryKey);
    if (historyJson != null) {
      final List<dynamic> historyList = jsonDecode(historyJson);
      return historyList.cast<Map<String, dynamic>>();
    }
    return [];
  }

  @override
  Future<void> clearCategoryHistory() async {
    final prefs = await _prefs;
    await prefs.remove(_categoryHistoryKey);
  }

  @override
  Future<void> clearSubspecialtyHistory() async {
    final prefs = await _prefs;
    await prefs.remove(_subspecialtyHistoryKey);
  }
}
