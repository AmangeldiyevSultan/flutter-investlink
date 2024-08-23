import 'package:investlink/src/core/architecture/data/converter/converter.dart';
import 'package:investlink/src/features/stock_search/data/models/day_model.dart';
import 'package:investlink/src/features/stock_search/data/models/last_quote_model.dart';
import 'package:investlink/src/features/stock_search/data/models/last_trade_model.dart';
import 'package:investlink/src/features/stock_search/data/models/min_model.dart';
import 'package:investlink/src/features/stock_search/data/models/prevday_model.dart';
import 'package:investlink/src/features/stock_search/data/models/tickers_model.dart';
import 'package:investlink/src/features/stock_search/domain/entities/day_entity.dart';
import 'package:investlink/src/features/stock_search/domain/entities/last_quote_entity.dart';
import 'package:investlink/src/features/stock_search/domain/entities/last_trade_entity.dart';
import 'package:investlink/src/features/stock_search/domain/entities/min_entity.dart';
import 'package:investlink/src/features/stock_search/domain/entities/prevday_entity.dart';
import 'package:investlink/src/features/stock_search/domain/entities/tickers_entity.dart';

/// Converter for [TickersEntity].
typedef ITickerConverter = ConverterToAndFrom<TickersModel, TickersEntity>;

/// {@template ticker_converter.class}
/// Implementation of [ITickerConverter].
/// {@endtemplate}
final class TickerConverter extends ITickerConverter {
  /// {@macro ticker_converter.class}
  const TickerConverter();

  @override
  Converter<TickersModel, TickersEntity> get converter => const _TickerConvert();

  @override
  Converter<TickersEntity, TickersModel> get reverseConverter => const _TickerReverseConverter();
}

final class _TickerConvert extends Converter<TickersModel, TickersEntity> {
  const _TickerConvert();

  @override
  TickersModel convert(TickersEntity input) {
    return TickersModel(
      ticker: input.ticker,
      todaysChangePerc: input.todaysChangePerc,
      todaysChange: input.todaysChange,
      updated: input.updated,
      day: DayModel(
        o: input.day?.o,
        h: input.day?.h,
        l: input.day?.l,
        c: input.day?.c,
        v: input.day?.v,
        vw: input.day?.vw,
      ),
      lastQuote: LastQuoteModel(
        P: input.lastQuote?.P,
        S: input.lastQuote?.S,
        p: input.lastQuote?.p,
        s: input.lastQuote?.s,
        t: input.lastQuote?.t,
      ),
      lastTrade: LastTradeModel(
        c: input.lastTrade?.c,
        i: input.lastTrade?.i,
        p: input.lastTrade?.p,
        s: input.lastTrade?.s,
        t: input.lastTrade?.t,
        x: input.lastTrade?.x,
      ),
      min: MinModel(
        av: input.min?.av,
        t: input.min?.t,
        n: input.min?.n,
        o: input.min?.o,
        h: input.min?.h,
        l: input.min?.l,
        c: input.min?.c,
        v: input.min?.v,
        vw: input.min?.vw,
      ),
      prevDay: PrevdayModel(
        o: input.prevDay?.o,
        h: input.prevDay?.h,
        l: input.prevDay?.l,
        c: input.prevDay?.c,
        v: input.prevDay?.v,
        vw: input.prevDay?.vw,
      ),
    );
  }
}

final class _TickerReverseConverter extends Converter<TickersEntity, TickersModel> {
  const _TickerReverseConverter();

  @override
  TickersEntity convert(TickersModel input) {
    return TickersEntity(
      ticker: input.ticker,
      todaysChangePerc: input.todaysChangePerc,
      todaysChange: input.todaysChange,
      updated: input.updated,
      day: DayEntity(
        o: input.day?.o,
        h: input.day?.h,
        l: input.day?.l,
        c: input.day?.c,
        v: input.day?.v,
        vw: input.day?.vw,
      ),
      lastQuote: LastQuoteEntity(
        P: input.lastQuote?.P,
        S: input.lastQuote?.S,
        p: input.lastQuote?.p,
        s: input.lastQuote?.s,
        t: input.lastQuote?.t,
      ),
      lastTrade: LastTradeEntity(
        c: input.lastTrade?.c,
        i: input.lastTrade?.i,
        p: input.lastTrade?.p,
        s: input.lastTrade?.s,
        t: input.lastTrade?.t,
        x: input.lastTrade?.x,
      ),
      min: MinEntity(
        av: input.min?.av,
        t: input.min?.t,
        n: input.min?.n,
        o: input.min?.o,
        h: input.min?.h,
        l: input.min?.l,
        c: input.min?.c,
        v: input.min?.v,
        vw: input.min?.vw,
      ),
      prevDay: PrevdayEntity(
        o: input.prevDay?.o,
        h: input.prevDay?.h,
        l: input.prevDay?.l,
        c: input.prevDay?.c,
        v: input.prevDay?.v,
        vw: input.prevDay?.vw,
      ),
    );
  }
}
