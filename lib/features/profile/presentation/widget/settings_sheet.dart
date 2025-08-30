import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:oxytocin/core/localization/locale_provider.dart';

class SettingsSheet {
  static void open(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context, listen: false);

    final currentCode =
        provider.locale?.languageCode ??
        Localizations.localeOf(context).languageCode;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (innerCtx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.language),
                title: Text("اللغة"),
              ),
              RadioListTile<String>(
                value: 'ar',
                groupValue: currentCode,
                title: const Text('العربية'),
                onChanged: (_) {
                  provider.setLocale(const Locale('ar'));
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                value: 'en',
                groupValue: currentCode,
                title: const Text('English'),
                onChanged: (_) {
                  provider.setLocale(const Locale('en'));
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
