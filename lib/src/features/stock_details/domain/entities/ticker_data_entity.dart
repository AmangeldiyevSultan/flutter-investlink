import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticker_data_entity.freezed.dart';

/// {@template ticker_data_entity.class}
/// Day quote entity.
/// {@endtemplate}
@freezed
class TickerDataEntity with _$TickerDataEntity {
  /// {@macro ticker_data_entity.class}
  const factory TickerDataEntity({
    double? v,
    double? vw,
    double? o,
    double? c,
    double? h,
    double? l,
    double? t,
    double? n,
  }) = _TickerDataEntity;
}
