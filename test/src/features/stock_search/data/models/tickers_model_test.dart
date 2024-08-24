import 'package:flutter_test/flutter_test.dart';
import 'package:investlink/src/features/stock_search/data/models/day_model.dart';
import 'package:investlink/src/features/stock_search/data/models/last_quote_model.dart';
import 'package:investlink/src/features/stock_search/data/models/last_trade_model.dart';
import 'package:investlink/src/features/stock_search/data/models/min_model.dart';
import 'package:investlink/src/features/stock_search/data/models/prevday_model.dart';
import 'package:investlink/src/features/stock_search/data/models/tickers_model.dart';

void main() {
  group('TickersModel >', () {
    test('fromJson creates correct model', () {
      final json = {
        'ticker': 'AAPL',
        'todaysChangePerc': 1.5,
        'todaysChange': 2.5,
        'updated': 1623456789.0,
        'day': {'o': 100.0, 'h': 110.0, 'l': 95.0, 'c': 105.0, 'v': 1000000.0, 'vw': 102.5},
        'lastQuote': {'P': 100.5, 'S': 1000.0, 'p': 99.5, 's': 500.0, 't': 1623456789.0},
        'lastTrade': {
          'c': [1.0, 2.0],
          'i': 'TRADE123',
          'p': 150.5,
          's': 100.0,
          't': 1623456789.0,
          'x': 3.0,
        },
        'min': {
          'av': 5000.0,
          'c': 105.0,
          'h': 110.0,
          'l': 95.0,
          'o': 100.0,
          'v': 10000.0,
          'vw': 102.5,
        },
        'prevDay': {'o': 98.0, 'h': 108.0, 'l': 93.0, 'c': 103.0, 'v': 900000.0, 'vw': 100.5},
      };
      final model = TickersModel.fromJson(json);

      expect(model.ticker, equals('AAPL'));
      expect(model.todaysChangePerc, equals(1.5));
      expect(model.todaysChange, equals(2.5));
      expect(model.updated, equals(1623456789.0));
      expect(model.day, isA<DayModel>());
      expect(model.lastQuote, isA<LastQuoteModel>());
      expect(model.lastTrade, isA<LastTradeModel>());
      expect(model.min, isA<MinModel>());
      expect(model.prevDay, isA<PrevdayModel>());
    });

    test('toJson returns correct map', () {
      const model = TickersModel(
        ticker: 'AAPL',
        todaysChangePerc: 1.5,
        todaysChange: 2.5,
        updated: 1623456789,
        day: DayModel(o: 100, h: 110, l: 95, c: 105, v: 1000000, vw: 102.5),
        lastQuote: LastQuoteModel(P: 100.5, S: 1000, p: 99.5, s: 500, t: 1623456789),
        lastTrade:
            LastTradeModel(c: [1.0, 2.0], i: 'TRADE123', p: 150.5, s: 100, t: 1623456789, x: 3),
        min: MinModel(av: 5000, c: 105, h: 110, l: 95, o: 100, v: 10000, vw: 102.5),
        prevDay: PrevdayModel(o: 98, h: 108, l: 93, c: 103, v: 900000, vw: 100.5),
      );
      final json = model.toJson();

      expect(json['ticker'], equals('AAPL'));
      expect(json['todaysChangePerc'], equals(1.5));
      expect(json['todaysChange'], equals(2.5));
      expect(json['updated'], equals(1623456789.0));
      expect(json['day'], isA<DayModel>());
      expect(json['lastQuote'], isA<LastQuoteModel>());
      expect(json['lastTrade'], isA<LastTradeModel>());
      expect(json['min'], isA<MinModel>());
      expect(json['prevDay'], isA<PrevdayModel>());
    });
  });
}
