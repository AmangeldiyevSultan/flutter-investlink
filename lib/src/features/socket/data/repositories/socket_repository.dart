import 'dart:async';
import 'dart:convert';

import 'package:investlink/src/core/common/utils/endpoints/api_endpoints.dart';
import 'package:investlink/src/core/common/utils/logger/logger.dart';
import 'package:investlink/src/features/socket/data/converters/send_message_converter.dart';
import 'package:investlink/src/features/socket/data/converters/socket_message_converter.dart';
import 'package:investlink/src/features/socket/data/models/socket_message_model.dart';
import 'package:investlink/src/features/socket/domain/entities/send_message_entity.dart';
import 'package:investlink/src/features/socket/domain/entities/socket_message_entity.dart';
import 'package:investlink/src/features/socket/domain/repositories/i_socket_repository.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// {@template socket_repository.class}
/// Implementation of [ISocketRepository].
/// {@endtemplate}
final class SocketRepository implements ISocketRepository {
  /// {@macro socket_repository.class}
  SocketRepository(
    this.baseSocketUrl, {
    required StreamController<List<SocketMessageEntity>>? listener,
  }) : _listener = listener;

  final String baseSocketUrl;

  late final StreamController<List<SocketMessageEntity>>? _listener;

  WebSocketChannel? _ws;

  final _sendMessageConverter = const SendMessageConverter();
  final _socketMessageConverter = const SocketMessageConverter();

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
    logger.info('Send message: ${_sendMessageConverter.convert(sendMessage).toJson()}');
    _ws?.sink.add(jsonEncode(_sendMessageConverter.convert(sendMessage).toJson()));
  }

  @override
  Stream<List<SocketMessageEntity>> listen() {
    _ws?.stream.listen(
      (msg) {
        logger.info('Socket message: $msg');

        final msgList = jsonDecode(msg as String) as List<dynamic>;

        // Map the List<dynamic> to List<SocketMessageModel>
        final socketMessages = msgList
            .map((item) => SocketMessageModel.fromJson(item as Map<String, dynamic>))
            .toList();

        final socketMessageEntity = socketMessages.map(_socketMessageConverter.convert).toList();
        _listener?.add(socketMessageEntity);
      },
    );

    return _listener!.stream;
  }
}
