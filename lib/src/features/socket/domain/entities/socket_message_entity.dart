import 'package:freezed_annotation/freezed_annotation.dart';

part 'socket_message_entity.freezed.dart';

/// {@template socket_message_entity.class}
/// socket message entity.
/// {@endtemplate}
@freezed
class SocketMessageEntity with _$SocketMessageEntity {
  /// {@macro socket_message_entity.class}
  const factory SocketMessageEntity({
    String? ev,
    String? sym,
    String? v,
    String? av,
    String? op,
    String? vw,
    String? o,
    String? c,
    String? h,
    String? l,
    String? a,
    String? z,
    String? s,
    String? e,
  }) = _SocketMessageEntity;
}
