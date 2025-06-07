import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:oxytocin/core/routing/app_router.dart';
import 'package:oxytocin/core/routing/navigation_service.dart';
import 'package:oxytocin/core/theme/app_theme.dart';
import 'package:oxytocin/generated/l10n.dart';

void main() {
  final navigationService = NavigationService();
  final router = AppRouter.createRouter(navigationService);
  runApp(OxytocinApp(router: router));
}

class OxytocinApp extends StatelessWidget {
  const OxytocinApp({super.key, required this.router});
  final GoRouter router;
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      locale: const Locale('ar'),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}
