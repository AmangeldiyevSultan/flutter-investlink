import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investlink/src/core/common/utils/disposable_object/disposable_object.dart';
import 'package:investlink/src/core/common/utils/disposable_object/i_disposable_object.dart';
import 'package:investlink/src/core/components/rest_client/rest_client_dio.dart';
import 'package:investlink/src/features/app/di/app_scope.dart';
import 'package:investlink/src/features/{{{path}}}/data/repositories/{{name.snakeCase()}}_repository.dart';
import 'package:investlink/src/features/{{{path}}}/presentation/bloc/{{name.snakeCase()}}_bloc.dart';

/// {@template {{name.snakeCase()}}_scope.class}
/// Implementation of [I{{name.pascalCase()}}Scope].
/// {@endtemplate}
final class {{name.pascalCase()}}Scope extends DisposableObject implements I{{name.pascalCase()}}Scope {

  /// {@macro {{name.snakeCase()}}_scope.class}
  /// Factory constructor for [I{{name.pascalCase()}}Scope].
  {{name.pascalCase()}}Scope({
    required {{name.pascalCase()}}Bloc {{name.camelCase()}}Bloc,
  }) : _{{name.camelCase()}}Bloc = {{name.camelCase()}}Bloc;

  /// Factory constructor for [I{{name.pascalCase()}}Scope].
  factory {{name.pascalCase()}}Scope.create(BuildContext context) {
    final scope = context.read<IAppScope>();

    final {{name.camelCase()}}Repository = {{name.pascalCase()}}Repository(
      RestClientDio(
        baseUrl: scope.appConfig.url.value,
        dio: scope.dio,
      ),
    );

    return {{name.pascalCase()}}Scope(
      {{name.camelCase()}}Bloc: {{name.pascalCase()}}Bloc(
        {{name.camelCase()}}Repository: {{name.camelCase()}}Repository,
      ),
    );
  }

  /// Private field to hold the bloc instance.
  final {{name.pascalCase()}}Bloc _{{name.camelCase()}}Bloc;

  @override
  late final {{name.pascalCase()}}Bloc {{name.camelCase()}}Bloc = _{{name.camelCase()}}Bloc;
}

/// Scope dependencies of the {{name.pascalCase()}} feature.
abstract interface class I{{name.pascalCase()}}Scope implements IDisposableObject {

  /// {{name.pascalCase()}}Bloc.
  {{name.pascalCase()}}Bloc get {{name.camelCase()}}Bloc;
}