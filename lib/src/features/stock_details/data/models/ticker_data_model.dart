import 'package:json_annotation/json_annotation.dart';

part 'ticker_data_model.g.dart';

/// {@template ticker_data_model.class}
/// Model for TickerDataModel.
/// {@endtemplate}
@JsonSerializable()
class TickerDataModel {
  /// {@macro ticker_data_model.class}
  const TickerDataModel({
    this.v,
    this.vw,
    this.o,
    this.c,
    this.h,
    this.l,
    this.t,
    this.n,
  });

  /// Get Model object from json.
  factory TickerDataModel.fromJson(Map<String, dynamic> json) => _$TickerDataModelFromJson(json);

  /// TickerDataModel
  final double? v;
  final double? vw;
  final double? o;
  final double? c;
  final double? h;
  final double? l;
  final double? t;
  final double? n;

  /// Convert a Model object to json.
  Map<String, dynamic> toJson() => _$TickerDataModelToJson(this);
}
