import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:investlink/src/core/common/utils/logger/logger.dart';
import 'package:investlink/src/features/socket/domain/entities/send_message_entity.dart';
import 'package:investlink/src/features/socket/domain/repositories/i_socket_repository.dart';

part 'socket_bloc.freezed.dart';

@freezed
class SocketEvent with _$SocketEvent {
  const factory SocketEvent.connect() = _ConnectSocketEvent;

  const factory SocketEvent.listen() = _ListenSocketEvent;

  const factory SocketEvent.send({
    required List<String> tickers,
  }) = _SendSocketEvent;
}

@freezed
class SocketState with _$SocketState {
  const SocketState._();

  const factory SocketState.connected({
    Object? error,
  }) = _ConnectedSocketState;

  /// Initial state.
  const factory SocketState.initial() = _InitialSocketState;

  /// Processing state.
  const factory SocketState.processing() = _ProcessingSocketState;

  /// Message sended state.
  const factory SocketState.messageSended() = _MessageSendedSocketState;

  /// Returns whether the state is processing or not.
  bool get isProcessing => maybeMap(
        orElse: () => false,
        processing: (_) => true,
      );
}

class SocketBloc extends Bloc<SocketEvent, SocketState> {
  SocketBloc({
    required ISocketRepository socketRepository,
  })  : _socketRepository = socketRepository,
        super(const SocketState.initial()) {
    on<_ConnectSocketEvent>(_connectToSocketHandler);
    on<_ListenSocketEvent>(_listenMessagesFromSocketHandler);
    on<_SendSocketEvent>(_sendMessageToSocketHandler);
  }

  final ISocketRepository _socketRepository;

  Future<void> _connectToSocketHandler(
    _ConnectSocketEvent event,
    Emitter<SocketState> emit,
  ) async {
    emit(const SocketState.processing());
    try {
      await _socketRepository.connect();
      emit(const SocketState.connected());
    } catch (e) {
      emit(SocketState.connected(error: e));
    }
  }

  Future<void> _listenMessagesFromSocketHandler(
    _ListenSocketEvent event,
    Emitter<SocketState> emit,
  ) async {
    await for (final listener in _socketRepository.listen()) {
      logger.info(listener.toString());
    }
  }

  void _sendMessageToSocketHandler(
    _SendSocketEvent event,
    Emitter<SocketState> emit,
  ) {
    _socketRepository.send(
      SendMessageEntity(
        action: 'subscribe',
        tickers: event.tickers,
      ),
    );
    emit(const SocketState.messageSended());
  }
}
