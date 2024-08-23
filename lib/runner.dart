import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:investlink/src/core/config/environment/environment.dart';
import 'package:investlink/src/features/app/app_flow.dart';
import 'package:investlink/src/features/app/di/app_scope_register.dart';
import 'package:investlink/src/features/database/di/database_scope_register.dart';
import 'package:investlink/src/features/socket/di/socket_scope_register.dart';

/// App launch.
Future<void> run(Environment env) async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await _runApp(env);
}

Future<void> _runApp(Environment env) async {
  const scopeRegister = AppScopeRegister();
  final appScope = await scopeRegister.createScope(env);

  const dataScopeRegister = DatabaseScopeRegister();
  final databaseScope = await dataScopeRegister.createScope();

  const socketScopeRegister = SocketScopeRegister();
  final socketScope = await socketScopeRegister.createScope(appScope);

  runApp(
    AppFlow(
      appScope: appScope,
      databaseScope: databaseScope,
      socketScope: socketScope,
    ),
  );
}
