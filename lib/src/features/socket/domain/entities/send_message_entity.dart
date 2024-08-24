import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_message_entity.freezed.dart';

/// {@template day_entity.class}
/// Day quote entity.
/// {@endtemplate}
@freezed
class SendMessageEntity with _$SendMessageEntity {
  /// {@macro day_entity.class}
  const factory SendMessageEntity({
    required String action,
    required String tickers,
    required int requestId,
    required int userId,
  }) = _SendMessageEntity;
}
