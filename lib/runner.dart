import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:investlink/src/core/config/environment/environment.dart';
import 'package:investlink/src/features/app/app_flow.dart';
import 'package:investlink/src/features/app/di/app_scope_register.dart';

/// App launch.
Future<void> run(Environment env) async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await _runApp(env);
}

Future<void> _runApp(Environment env) async {
  const scopeRegister = AppScopeRegister();
  final scope = await scopeRegister.createScope(env);

  runApp(AppFlow(appScope: scope));
}
