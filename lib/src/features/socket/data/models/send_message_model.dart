import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_message_model.g.dart';

/// {@template send_message_model.class}
/// Model for SendMessageModel.
/// {@endtemplate}
@JsonSerializable()
class SendMessageModel {
  /// {@macro day_model.class}
  const SendMessageModel({
    this.action,
    this.tickers,
  });

  /// SendMessageModel
  final String? action;
  final List<String>? tickers;

  /// Convert a Model object to json.
  Map<String, dynamic> toJson() => _$SendMessageModelToJson(this);
}
