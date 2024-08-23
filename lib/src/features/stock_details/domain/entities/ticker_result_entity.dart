import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:investlink/src/features/stock_details/domain/entities/ticker_data_entity.dart';

part 'ticker_result_entity.freezed.dart';

/// {@template ticker_result_entity.class}
/// Day quote entity.
/// {@endtemplate}
@freezed
class TickerResultEntity with _$TickerResultEntity {
  /// {@macro ticker_result_entity.class}
  const factory TickerResultEntity({
    String? ticker,
    int? queryCount,
    int? resultsCount,
    bool? adjusted,
    List<TickerDataEntity>? results,
  }) = _TickerResultEntity;
}
