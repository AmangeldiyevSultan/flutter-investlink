import 'package:investlink/src/core/architecture/data/converter/converter.dart';
import 'package:investlink/src/features/stock_search/data/models/tickers_result_model.dart';
import 'package:investlink/src/features/stock_search/domain/entities/day_entity.dart';
import 'package:investlink/src/features/stock_search/domain/entities/last_quote_entity.dart';
import 'package:investlink/src/features/stock_search/domain/entities/last_trade_entity.dart';
import 'package:investlink/src/features/stock_search/domain/entities/min_entity.dart';
import 'package:investlink/src/features/stock_search/domain/entities/prevday_entity.dart';
import 'package:investlink/src/features/stock_search/domain/entities/tickers_entity.dart';
import 'package:investlink/src/features/stock_search/domain/entities/tickers_result_entity.dart';

/// Converter for [TickersResultModel].
typedef ITickersResultConverter = Converter<TickersResultEntity, TickersResultModel>;

/// {@template tickers_result_converter.class}
/// Implementation of [ITickersResultConverter].
/// {@endtemplate}
final class TickersResultConverter extends ITickersResultConverter {
  /// {@macro tickers_result_converter.class}
  const TickersResultConverter();

  @override
  TickersResultEntity convert(TickersResultModel input) {
    final tickers = input.tickers;
    return TickersResultEntity(
      tickers: tickers == null
          ? []
          : tickers
              .map(
                (tickers) => TickersEntity(
                  ticker: tickers.ticker,
                  todaysChangePerc: tickers.todaysChangePerc,
                  todaysChange: tickers.todaysChange,
                  updated: tickers.updated,
                  day: DayEntity(
                    o: tickers.day?.o,
                    h: tickers.day?.h,
                    l: tickers.day?.l,
                    c: tickers.day?.c,
                    v: tickers.day?.v,
                    vw: tickers.day?.vw,
                  ),
                  lastQuote: LastQuoteEntity(
                    P: tickers.lastQuote?.P,
                    S: tickers.lastQuote?.S,
                    p: tickers.lastQuote?.p,
                    s: tickers.lastQuote?.s,
                    t: tickers.lastQuote?.t,
                  ),
                  lastTrade: LastTradeEntity(
                    c: tickers.lastTrade?.c,
                    i: tickers.lastTrade?.i,
                    p: tickers.lastTrade?.p,
                    s: tickers.lastTrade?.s,
                    t: tickers.lastTrade?.t,
                    x: tickers.lastTrade?.x,
                  ),
                  min: MinEntity(
                    av: tickers.min?.av,
                    t: tickers.min?.t,
                    n: tickers.min?.n,
                    o: tickers.min?.o,
                    h: tickers.min?.h,
                    l: tickers.min?.l,
                    c: tickers.min?.c,
                    v: tickers.min?.v,
                    vw: tickers.min?.vw,
                  ),
                  prevDay: PrevdayEntity(
                    o: tickers.prevDay?.o,
                    h: tickers.prevDay?.h,
                    l: tickers.prevDay?.l,
                    c: tickers.prevDay?.c,
                    v: tickers.prevDay?.v,
                    vw: tickers.prevDay?.vw,
                  ),
                ),
              )
              .toList(),
      status: input.status,
      requestId: input.requestId,
      count: input.count,
    );
  }
}
