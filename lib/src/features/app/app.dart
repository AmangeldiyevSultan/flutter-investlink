import 'package:flutter/material.dart';
import 'package:flutter_easy_dialogs/flutter_easy_dialogs.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:investlink/src/core/assets/themes/theme_data.dart';
import 'package:investlink/src/core/router/routes.dart';
import 'package:investlink/src/features/app/di/app_scope.dart';
import 'package:investlink/src/features/snackbar_queue/presentation/snack_queue_provider.dart';
import 'package:investlink/src/features/theme_mode/presentation/widget/theme_mode_builder.dart';
import 'package:nested/nested.dart';

final navigatorKey = GlobalKey<NavigatorState>();

/// {@template app.class}
/// Application.
/// {@endtemplate}
class App extends StatefulWidget {
  /// {@macro app.class}
  const App({required this.appScope, super.key});

  final IAppScope appScope;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  static late final GoRouter _router;

  /// Scope of dependencies which need through all app's life.
  @override
  void initState() {
    super.initState();
    _router = _initializeRouter();
  }

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeModeBuilder(
      builder: (_, themeMode) {
        return MaterialApp.router(
          /// Navigation.
          routerConfig: _router,

          ///? Both Light Theme

          theme: AppThemeData.lightTheme,
          darkTheme: AppThemeData.lightTheme,
          themeMode: themeMode,
          debugShowCheckedModeBanner: false,

          builder: (builderContext, widget) {
            final mediaQueryData = MediaQuery.of(builderContext);
            final easyDialogsBuilder = FlutterEasyDialogs.builder();

            return Nested(
              children: [
                SnackQueueProvider(
                  router: _router,
                ),
              ],
              child: MediaQuery(
                data: mediaQueryData.copyWith(textScaler: TextScaler.noScaling),
                child: Overlay(
                  initialEntries: [
                    OverlayEntry(
                      builder: (overlayContext) => easyDialogsBuilder(overlayContext, widget),
                    ),
                  ],
                ),
              ),
            );
          },

          /// Localization.
          locale: _localizations.firstOrNull,
          localizationsDelegates: _localizationsDelegates,
          supportedLocales: _localizations,
        );
      },
    );
  }

  GoRouter _initializeRouter() {
    return GoRouter(
      navigatorKey: navigatorKey,
      debugLogDiagnostics: true,
      initialLocation: '/',
      routes: $appRoutes,
      redirect: (context, state) async {
        if (state.matchedLocation == '/') {
          return '/';
        }
        return null;
      },
    );
  }
}

const _localizations = [
  Locale('ru', 'RU'),
];

const _localizationsDelegates = [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];
