import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:investlink/src/features/stock_search/domain/entities/tickers_entity.dart';

part 'tickers_result_entity.freezed.dart';

/// {@template tickers_result_entity.class}
/// Tickers Result entity.
/// {@endtemplate}
@freezed
class TickersResultEntity with _$TickersResultEntity {
  /// {@macro tickers_result_entity.class}
  const factory TickersResultEntity({
    List<TickersEntity>? tickers,
    String? status,
    String? requestId,
    int? count,
  }) = _TickersResultEntity;
}
