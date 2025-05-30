import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:oxytocin/features/intro/presentation/views/splash_view.dart';
import 'package:oxytocin/generated/l10n.dart';

void main() {
  runApp(const OxytocinApp());
}

class OxytocinApp extends StatelessWidget {
  const OxytocinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: const Locale('ar'),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: const SplashView(),
    );
  }
}
