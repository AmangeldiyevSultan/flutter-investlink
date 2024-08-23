import 'package:investlink/src/features/socket/presentation/bloc/socket_bloc.dart';

/// {@template socket_scope.class}
/// Implementation of [ISocketScope].
/// {@endtemplate}
final class SocketScope implements ISocketScope {
  /// {@macro socket_scope.class}
  /// Factory constructor for [ISocketScope].
  SocketScope({
    required this.socketBloc,
  });

  @override
  late final SocketBloc socketBloc;
}

/// Scope dependencies of the Socket feature.
abstract interface class ISocketScope {
  /// SocketBloc.
  SocketBloc get socketBloc;
}
