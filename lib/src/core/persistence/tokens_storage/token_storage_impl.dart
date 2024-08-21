// ignore_for_file: sort_constructors_first

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:investlink/src/core/persistence/tokens_storage/auth_token_pair.dart';
import 'package:investlink/src/core/persistence/tokens_storage/i_token_storage.dart';

/// {@template tokens_storage.class}
/// Implementation [ITokenStorage]
/// {@endtemplate}
final class TokenStorageImpl implements ITokenStorage<AuthTokenPair> {
  /// {@macro tokens_storage.class}
  const TokenStorageImpl(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  @override
  Future<AuthTokenPair?> read() async {
    final tokenJson = await _secureStorage.read(key: TokensStorageKeys.authToken.keyName);

    if (tokenJson == null) return null;

    return AuthTokenPair.fromJson(jsonDecode(tokenJson) as Map<String, dynamic>);
  }

  @override
  Future<void> write(AuthTokenPair token) {
    return _secureStorage.write(
      key: TokensStorageKeys.authToken.keyName,
      value: jsonEncode(token.toJson()),
    );
  }

  @override
  Future<void> delete() async {
    for (final key in TokensStorageKeys.values) {
      await _secureStorage.delete(key: key.keyName);
    }
  }
}

/// Keys for [TokenStorageImpl]
enum TokensStorageKeys {
  /// @nodoc
  authToken('app_auth_token');

  /// Key name
  final String keyName;

  const TokensStorageKeys(this.keyName);
}
