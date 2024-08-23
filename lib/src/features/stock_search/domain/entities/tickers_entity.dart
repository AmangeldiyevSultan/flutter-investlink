import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:investlink/src/features/stock_search/domain/entities/day_entity.dart';
import 'package:investlink/src/features/stock_search/domain/entities/last_quote_entity.dart';
import 'package:investlink/src/features/stock_search/domain/entities/last_trade_entity.dart';
import 'package:investlink/src/features/stock_search/domain/entities/min_entity.dart';
import 'package:investlink/src/features/stock_search/domain/entities/prevday_entity.dart';

part 'tickers_entity.freezed.dart';

/// {@template tickers_entity.class}
/// Tickers entity.
/// {@endtemplate}
@freezed
class TickersEntity with _$TickersEntity {
  /// {@macro tickers_entity.class}
  const factory TickersEntity({
    String? ticker,
    double? todaysChangePerc,
    double? todaysChange,
    double? updated,
    DayEntity? day,
    LastQuoteEntity? lastQuote,
    LastTradeEntity? lastTrade,
    MinEntity? min,
    PrevdayEntity? prevDay,
  }) = _TickersEntity;
}
