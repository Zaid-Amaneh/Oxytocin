import 'dart:async'; // <-- لا تنسَ إضافة هذه المكتبة
import 'package:flutter/material.dart';

class SearchViewModel extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  bool _isFieldEmpty = true;
  bool get isFieldEmpty => _isFieldEmpty;

  Timer? _debounce;

  void cancelDebounce() {
    _debounce?.cancel();
  }

  void onSearchChanged({
    required Function(String) onDebounce,
    Function(String)? onTyping,
  }) {
    final currentQuery = searchController.text;

    if (onTyping != null) {
      onTyping(currentQuery);
    }

    if (_debounce?.isActive ?? false) _debounce!.cancel();

    final bool newState = currentQuery.isEmpty;
    if (newState != _isFieldEmpty) {
      _isFieldEmpty = newState;
      notifyListeners();
    }

    _debounce = Timer(const Duration(milliseconds: 750), () {
      final query = searchController.text.trim();
      if (query.isNotEmpty) {
        onDebounce(query);
      }
    });
  }

  void clearSearch() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    searchController.clear();
    _isFieldEmpty = true;
    notifyListeners();
  }

  void historySearch(String query) {
    searchController.text = query;
    _isFieldEmpty = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }
}
