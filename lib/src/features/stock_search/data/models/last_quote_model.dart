import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'last_quote_model.g.dart';

/// {@template last_quote_model.class}
/// Model for LastQuoteModel.
/// {@endtemplate}
@JsonSerializable()
@HiveType(typeId: 4)
class LastQuoteModel {
  /// {@macro last_quote_model.class}
  const LastQuoteModel({
    this.P,
    this.S,
    this.p,
    this.s,
    this.t,
  });

  /// Get Model object from json.
  factory LastQuoteModel.fromJson(Map<String, dynamic> json) => _$LastQuoteModelFromJson(json);

  /// LastQuoteModel
  @HiveField(0)
  final double? P;
  @HiveField(1)
  final double? S;
  @HiveField(2)
  final double? p;
  @HiveField(3)
  final double? s;
  @HiveField(4)
  final double? t;

  /// Convert a Model object to json.
  Map<String, dynamic> toJson() => _$LastQuoteModelToJson(this);
}
