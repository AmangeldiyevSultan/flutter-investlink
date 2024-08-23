import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'last_trade_model.g.dart';

/// {@template last_trade_model.class}
/// Model for LastTradeModel.
/// {@endtemplate}
@JsonSerializable()
@HiveType(typeId: 3)
class LastTradeModel {
  /// {@macro last_trade_model.class}
  const LastTradeModel({
    this.c,
    this.i,
    this.p,
    this.s,
    this.t,
    this.x,
  });

  /// Get Model object from json.
  factory LastTradeModel.fromJson(Map<String, dynamic> json) => _$LastTradeModelFromJson(json);

  /// LastTradeModel
  @HiveField(0)
  final List<double>? c;
  @HiveField(1)
  final String? i;
  @HiveField(2)
  final double? p;
  @HiveField(3)
  final double? s;
  @HiveField(4)
  final double? t;
  @HiveField(5)
  final double? x;

  /// Convert a Model object to json.
  Map<String, dynamic> toJson() => _$LastTradeModelToJson(this);
}
