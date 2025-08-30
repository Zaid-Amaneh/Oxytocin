import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  static const _prefsKey = 'languageCode';

  Locale? _locale;
  Locale? get locale => _locale;

  LocaleProvider() {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final p = await SharedPreferences.getInstance();
    final code = p.getString(_prefsKey);
    if (code != null && code.isNotEmpty) {
      _locale = Locale(code);
      notifyListeners();
    }
  }

  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    final p = await SharedPreferences.getInstance();
    await p.setString(_prefsKey, locale.languageCode);
    notifyListeners();
  }
}
