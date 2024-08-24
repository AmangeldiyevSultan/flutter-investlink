import 'dart:async';

import 'package:investlink/src/features/app/di/app_scope.dart';
import 'package:investlink/src/features/socket/data/repositories/socket_repository.dart';
import 'package:investlink/src/features/socket/di/socket_scope.dart';
import 'package:investlink/src/features/socket/domain/entities/socket_message_entity.dart';
import 'package:investlink/src/features/socket/presentation/bloc/socket_bloc.dart';

/// {@template socket_scope_register.class}
/// Creates and initializes SocketScope.
/// {@endtemplate}
final class SocketScopeRegister {
  /// {@macro socket_scope_register.class}
  const SocketScopeRegister();

  /// Create scope.
  Future<ISocketScope> createScope(IAppScope appScope) async {
    final socketRepository = SocketRepository(
      appScope.appConfig.socketUrl.value,
      listener: StreamController<List<SocketMessageEntity>>.broadcast(),
    );

    return SocketScope(
      socketBloc: SocketBloc(
        socketRepository: socketRepository,
      ),
    );
  }
}
