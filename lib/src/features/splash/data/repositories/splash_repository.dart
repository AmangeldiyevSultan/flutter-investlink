import 'package:investlink/src/core/persistence/tokens_storage/auth_token_pair.dart';
import 'package:investlink/src/core/persistence/tokens_storage/i_token_storage.dart';
import 'package:investlink/src/features/splash/domain/repositories/i_splash_repository.dart';

/// {@template splash_repository.class}
/// Implementation of [ISplashRepository].
/// {@endtemplate}
final class SplashRepository implements ISplashRepository {
  /// {@macro splash_repository.class}
  const SplashRepository(this._tokenStorage);

  final ITokenStorage<AuthTokenPair> _tokenStorage;

  @override
  Future<AuthTokenPair?> isTokenExist() async {
    return _tokenStorage.read();
  }
}
