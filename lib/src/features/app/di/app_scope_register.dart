import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:investlink/src/core/components/api/app_dio_configurator.dart';
import 'package:investlink/src/core/config/app_config.dart';
import 'package:investlink/src/core/config/environment/environment.dart';
import 'package:investlink/src/features/app/di/app_scope.dart';

import 'package:shared_preferences/shared_preferences.dart';

/// {@template app_scope_register.class}
/// Creates and initializes AppScope.
/// {@endtemplate}
final class AppScopeRegister {
  /// {@macro app_scope_register.class}
  const AppScopeRegister();

  /// Create scope.
  Future<IAppScope> createScope(Environment env) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final appConfig = _createAppConfig(env, sharedPreferences);

    const dioConfigurator = AppDioConfigurator();
    final interceptors = <Interceptor>[];
    final dio = dioConfigurator.create(
      interceptors: interceptors,
      url: appConfig.url.value,
      proxyUrl: appConfig.proxyUrl,
    );

    return AppScope(
      env: env,
      appConfig: appConfig,
      sharedPreferences: sharedPreferences,
      dio: dio,
    );
  }

  AppConfig _createAppConfig(Environment env, SharedPreferences prefs) {
    if (env.isProd && kReleaseMode) {
      return AppConfig(url: env.buildType.defaultUrl);
    }

    return AppConfig(
      url: env.buildType.defaultUrl,
    );
  }
}
