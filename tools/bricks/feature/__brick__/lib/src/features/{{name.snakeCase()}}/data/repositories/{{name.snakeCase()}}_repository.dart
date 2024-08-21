import 'package:investlink/src/core/components/rest_client/rest_client.dart';
import 'package:investlink/src/features/{{{path}}}/domain/repositories/i_{{name.snakeCase()}}_repository.dart';

/// {@template {{name.snakeCase()}}_repository.class}
/// Implementation of [I{{name.pascalCase()}}Repository].
/// {@endtemplate}
final class {{name.pascalCase()}}Repository implements I{{name.pascalCase()}}Repository {
  /// {@macro {{name.snakeCase()}}_repository.class}
  const {{name.pascalCase()}}Repository(this._client);

  final RestClient _client;
}
