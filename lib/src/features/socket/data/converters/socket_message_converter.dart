import 'package:investlink/src/core/architecture/data/converter/converter.dart';
import 'package:investlink/src/features/socket/data/models/socket_message_model.dart';
import 'package:investlink/src/features/socket/domain/entities/socket_message_entity.dart';

/// Converter for [SocketMessageEntity].
typedef ISocketMessageConverter = Converter<SocketMessageEntity, SocketMessageModel>;

/// {@template socket_message_converter.class}
/// Implementation of [ISocketMessageConverter].
/// {@endtemplate}
final class SocketMessageConverter extends ISocketMessageConverter {
  /// {@macro socket_message_converter.class}
  const SocketMessageConverter();

  @override
  SocketMessageEntity convert(SocketMessageModel input) {
    return SocketMessageEntity(
      ev: input.ev,
      sym: input.sym,
      v: input.v,
      av: input.av,
      op: input.op,
      vw: input.vw,
      o: input.o,
      c: input.c,
      h: input.h,
      l: input.l,
      a: input.a,
      z: input.z,
      s: input.s,
      e: input.e,
    );
  }
}
