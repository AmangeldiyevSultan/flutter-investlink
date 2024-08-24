import 'package:investlink/src/features/socket/data/repositories/socket_repository.dart';
import 'package:investlink/src/features/socket/domain/entities/send_message_entity.dart';
import 'package:investlink/src/features/socket/domain/entities/socket_message_entity.dart';

/// Interface for [SocketRepository].
abstract interface class ISocketRepository {
  Future<void> connect();

  void send(SendMessageEntity sendMessage);

  Stream<List<SocketMessageEntity>> listen();

  Future<void> close();
}
