import 'package:flutter/material.dart';
import 'package:investlink/src/core/common/widgets/di_scope.dart';
import 'package:investlink/src/features/app/app.dart';
import 'package:investlink/src/features/app/di/app_scope.dart';
import 'package:investlink/src/features/database/di/database_scope.dart';
import 'package:investlink/src/features/socket/di/socket_scope.dart';
import 'package:investlink/src/features/theme_mode/presentation/theme_mode_provider.dart';
import 'package:nested/nested.dart';

/// {@template app_flow.class}
/// Entry point for the application.
/// {@endtemplate}
class AppFlow extends StatelessWidget {
  /// {@macro app_flow.class}
  const AppFlow({
    required this.appScope,
    required this.databaseScope,
    required this.socketScope,
    super.key,
  });

  /// {@macro app_scope.class}
  final IAppScope appScope;
  final IDatabaseScope databaseScope;
  final ISocketScope socketScope;

  @override
  Widget build(BuildContext context) {
    return Nested(
      child: App(appScope: appScope),
      children: [
        DiScope<IAppScope>(factory: (_) => appScope),
        const ThemeModeProvider(),
        DiScope<IDatabaseScope>(factory: (_) => databaseScope),
        DiScope<ISocketScope>(factory: (_) => socketScope),
      ],
    );
  }
}
