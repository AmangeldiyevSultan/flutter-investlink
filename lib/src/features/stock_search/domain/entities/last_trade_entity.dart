import 'package:freezed_annotation/freezed_annotation.dart';

part 'last_trade_entity.freezed.dart';

/// {@template last_trade_entity.class}
/// Last trade entity.
/// {@endtemplate}
@freezed
class LastTradeEntity with _$LastTradeEntity {
  /// {@macro last_trade_entity.class}
  const factory LastTradeEntity({
    List<double>? c,
    String? i,
    double? p,
    double? s,
    double? t,
    double? x,
  }) = _LastTradeEntity;
}
