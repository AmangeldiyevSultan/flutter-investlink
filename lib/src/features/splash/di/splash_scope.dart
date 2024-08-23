import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investlink/src/core/common/utils/disposable_object/disposable_object.dart';
import 'package:investlink/src/core/common/utils/disposable_object/i_disposable_object.dart';
import 'package:investlink/src/core/persistence/tokens_storage/token_storage_impl.dart';
import 'package:investlink/src/features/app/di/app_scope.dart';
import 'package:investlink/src/features/splash/data/repositories/splash_repository.dart';
import 'package:investlink/src/features/splash/domain/repositories/i_splash_repository.dart';

/// {@template splash_scope.class}
/// Implementation of [ISplashScope].
/// {@endtemplate}
final class SplashScope extends DisposableObject implements ISplashScope {
  /// {@macro splash_scope.class}
  /// Factory constructor for [ISplashScope].
  SplashScope({
    required ISplashRepository splashRepository,
  }) : _splashRepository = splashRepository;

  /// Factory constructor for [ISplashScope].
  factory SplashScope.create(BuildContext context) {
    final scope = context.read<IAppScope>();

    final tokenStorage = TokenStorageImpl(scope.secureStorage);

    return SplashScope(
      splashRepository: SplashRepository(
        tokenStorage,
      ),
    );
  }

  /// Private field to hold the rep instance.
  final ISplashRepository _splashRepository;

  @override
  late final ISplashRepository splashRepository = _splashRepository;
}

/// Scope dependencies of the ISplashRepository feature.
abstract interface class ISplashScope implements IDisposableObject {
  /// Cubit for the ISplashRepository feature.
  ISplashRepository get splashRepository;
}
