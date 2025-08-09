import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/Utils/services/local_storage_service.dart';
import 'package:oxytocin/core/theme/app_colors.dart';

class SearchHistory extends StatefulWidget {
  const SearchHistory({super.key});

  @override
  State<SearchHistory> createState() => _SearchHistoryState();
}

class _SearchHistoryState extends State<SearchHistory> {
  final LocalStorageService _storageService = LocalStorageService();
  List<String> _history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final history = await _storageService.getUserSearchHistory();
    setState(() {
      _history = history;
    });
  }

  Future<void> _clearHistory() async {
    await _storageService.clearUserSearchHistory();
    setState(() {
      _history.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
              child: Text(
                context.tr.searchHistory,
                style: AppStyles.almaraiBold(
                  context,
                ).copyWith(color: AppColors.textPrimary, fontSize: 14),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: _clearHistory,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                child: Text(
                  context.tr.clearSearchHistory,
                  style: AppStyles.almaraiBold(
                    context,
                  ).copyWith(color: AppColors.kPrimaryColor2, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _history
              .map(
                (query) => GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(query, style: const TextStyle(fontSize: 14)),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
