import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:oxytocin/core/routing/app_router.dart';
import 'package:oxytocin/core/routing/navigation_service.dart';
import 'package:oxytocin/core/theme/app_theme.dart';
import 'package:oxytocin/features/favorites/data/services/favorite_manager.dart';
import 'package:oxytocin/features/home/presentation/cubit/home_cubit.dart';
import 'package:oxytocin/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'features/auth_complete/presentation/cubit/profile_info_cubit.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProfileInfoCubit()),
        BlocProvider(create: (context) => HomeCubit()),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => FavoriteManager()),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          locale: const Locale('ar'),
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          theme: AppTheme.lightTheme,
          routerConfig: router,
        ),
      ),
    );
  }
}
