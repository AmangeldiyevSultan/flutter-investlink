import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_message_model.g.dart';

/// {@template send_message_model.class}
/// Model for SendMessageModel.
/// {@endtemplate}
@JsonSerializable()
class SendMessageModel {
  /// {@macro day_model.class}
  const SendMessageModel({
    required this.action,
    required this.tickers,
    required this.requestId,
    required this.userId,
  });

  /// SendMessageModel
  final String? action;
  final String tickers;
  @JsonKey(name: 'request_id')
  final int requestId;
  @JsonKey(name: 'user_id')
  final int userId;

  /// Convert a Model object to json.
  Map<String, dynamic> toJson() => _$SendMessageModelToJson(this);
}
