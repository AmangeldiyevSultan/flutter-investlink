import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investlink/src/core/common/utils/disposable_object/disposable_object.dart';
import 'package:investlink/src/core/components/rest_client/rest_client_dio.dart';
import 'package:investlink/src/features/app/di/app_scope.dart';
import 'package:investlink/src/features/auth/data/repositories/auth_repository.dart';
import 'package:investlink/src/features/auth/presentation/bloc/auth_bloc.dart';

/// {@template auth_scope.class}
/// Implementation of [IAuthScope].
/// {@endtemplate}
final class AuthScope extends DisposableObject implements IAuthScope {
  /// {@macro auth_scope.class}
  AuthScope({required this.authBloc});

  /// Factory constructor for [IAuthScope].
  factory AuthScope.create(BuildContext context) {
    final scope = context.read<IAppScope>();

    final authRepository = AuthRepository(
      RestClientDio(
        baseUrl: scope.appConfig.url.value,
        dio: scope.dio,
      ),
    );

    return AuthScope(
      authBloc: AuthBloc(
        authRepository: authRepository,
      ),
    );
  }
  @override
  late final AuthBloc authBloc;
}

/// Scope dependencies of the Auth feature.
abstract interface class IAuthScope implements DisposableObject {
  /// AuthBloc.
  AuthBloc get authBloc;
}
