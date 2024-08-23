import 'dart:async';
import 'dart:convert';

import 'package:investlink/src/core/common/utils/endpoints/api_endpoints.dart';
import 'package:investlink/src/core/common/utils/logger/logger.dart';
import 'package:investlink/src/features/socket/data/converters/send_message_converter.dart';
import 'package:investlink/src/features/socket/domain/entities/send_message_entity.dart';
import 'package:investlink/src/features/socket/domain/repositories/i_socket_repository.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// {@template socket_repository.class}
/// Implementation of [ISocketRepository].
/// {@endtemplate}
final class SocketRepository implements ISocketRepository {
  /// {@macro socket_repository.class}
  SocketRepository(
    this.baseSocketUrl, {
    required StreamController<dynamic>? listener,
  }) : _listener = listener;

  final String baseSocketUrl;

  late final StreamController<dynamic>? _listener;

  WebSocketChannel? _ws;

  final _sendMessageConverter = const SendMessageConverter();

  @override
  Future<void> connect() async {
    await close();
    _ws = WebSocketChannel.connect(Uri.parse(baseSocketUrl + WebSocketPath.connection));
    await _ws!.ready;
  }

  @override
  Future<void> close() async {
    // Cancel the noop timeout if it's set

    // Check if there's an active connection
    if (_ws != null) {
      await _ws?.sink.close();
      _ws = null;
    }
  }

  @override
  void send(SendMessageEntity sendMessage) {
    _ws?.sink.add(jsonEncode(_sendMessageConverter.convert(sendMessage).toJson()));
  }

  @override
  Stream<dynamic> listen() {
    _ws?.stream.listen(
      (msg) {
        logger.info('Socket message: $msg');
        _listener?.add(msg);
      },
    );

    return _listener!.stream;
  }
}
