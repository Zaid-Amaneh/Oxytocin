import 'package:flutter/material.dart';

class SearchViewModel extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  bool _isFieldEmpty = true;
  bool get isFieldEmpty => _isFieldEmpty;
  void onSearchChanged() {
    final bool newState = searchController.text.isEmpty;
    _isFieldEmpty = newState;
    notifyListeners();
  }

  void clearSearch() {
    searchController.clear();
    onSearchChanged();
  }

  void historySearch(String query) {
    searchController.text = query;
    onSearchChanged();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
