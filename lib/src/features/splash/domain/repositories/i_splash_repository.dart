import 'package:investlink/src/core/persistence/tokens_storage/auth_token_pair.dart';

/// Interface for [ISplashRepository].
abstract interface class ISplashRepository {
  /// Check if the token exists.
  Future<AuthTokenPair?> isTokenExist();
}
