import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investlink/src/core/common/utils/disposable_object/disposable_object.dart';
import 'package:investlink/src/core/components/rest_client/rest_client_dio.dart';
import 'package:investlink/src/core/persistence/tokens_storage/auth_token_pair.dart';
import 'package:investlink/src/core/persistence/tokens_storage/i_token_storage.dart';
import 'package:investlink/src/core/persistence/tokens_storage/token_storage_impl.dart';
import 'package:investlink/src/features/app/di/app_scope.dart';
import 'package:investlink/src/features/auth/data/repositories/auth_repository.dart';
import 'package:investlink/src/features/auth/presentation/bloc/auth_bloc.dart';

/// {@template auth_scope.class}
/// Implementation of [IAuthScope].
/// {@endtemplate}
final class AuthScope extends DisposableObject implements IAuthScope {
  /// {@macro auth_scope.class}
  AuthScope({
    required this.authBloc,
    required this.tokenStorage,
  });

  /// Factory constructor for [IAuthScope].
  factory AuthScope.create(BuildContext context) {
    final scope = context.read<IAppScope>();

    final authRepository = AuthRepository(
      RestClientDio(
        baseUrl: scope.appConfig.url.value,
        dio: scope.dio,
      ),
    );

    final tokenStorage = TokenStorageImpl(scope.secureStorage);

    return AuthScope(
      authBloc: AuthBloc(
        authRepository: authRepository,
      ),
      tokenStorage: tokenStorage,
    );
  }
  @override
  late final AuthBloc authBloc;

  @override
  late final ITokenStorage<AuthTokenPair> tokenStorage;
}

/// Scope dependencies of the Auth feature.
abstract interface class IAuthScope implements DisposableObject {
  /// AuthBloc.
  AuthBloc get authBloc;

  ITokenStorage<AuthTokenPair> get tokenStorage;
}
