import 'package:investlink/src/core/architecture/data/converter/converter.dart';
import 'package:investlink/src/features/socket/data/models/send_message_model.dart';
import 'package:investlink/src/features/socket/domain/entities/send_message_entity.dart';

/// Converter for [SendMessageModel].
typedef ISendMessageConverter = Converter<SendMessageModel, SendMessageEntity>;

/// {@template send_message_converter.class}
/// Implementation of [ISendMessageConverter].
/// {@endtemplate}
final class SendMessageConverter extends ISendMessageConverter {
  /// {@macro send_message_converter.class}
  const SendMessageConverter();

  @override
  SendMessageModel convert(SendMessageEntity input) {
    return SendMessageModel(
      action: input.action,
      tickers: input.tickers,
    );
  }
}
