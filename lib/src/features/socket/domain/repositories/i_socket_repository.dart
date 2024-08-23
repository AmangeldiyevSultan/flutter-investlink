import 'package:investlink/src/features/socket/data/repositories/socket_repository.dart';
import 'package:investlink/src/features/socket/domain/entities/send_message_entity.dart';

/// Interface for [SocketRepository].
abstract interface class ISocketRepository {
  Future<void> connect();

  void send(SendMessageEntity sendMessage);

  Stream<dynamic> listen();

  Future<void> close();
}
