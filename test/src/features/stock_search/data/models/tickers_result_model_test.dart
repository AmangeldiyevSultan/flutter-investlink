// ignore_for_file: avoid_dynamic_calls

import 'package:flutter_test/flutter_test.dart';
import 'package:investlink/src/features/stock_search/data/models/tickers_model.dart';
import 'package:investlink/src/features/stock_search/data/models/tickers_result_model.dart';

void main() {
  group('TickersResultModel >', () {
    test('fromJson creates correct model', () {
      final json = {
        'tickers': [
          {
            'ticker': 'AAPL',
            'todaysChangePerc': 1.5,
            'todaysChange': 2.5,
            'updated': 1623456789.0,
          }
        ],
        'status': 'OK',
        'request_id': 'REQUEST123',
        'count': 1,
      };
      final model = TickersResultModel.fromJson(json);

      expect(model.tickers, isA<List<TickersModel>>());
      expect(model.tickers!.length, equals(1));
      expect(model.status, equals('OK'));
      expect(model.requestId, equals('REQUEST123'));
      expect(model.count, equals(1));
    });

    test('toJson returns correct map', () {
      const model = TickersResultModel(
        tickers: [
          TickersModel(
            ticker: 'AAPL',
            todaysChangePerc: 1.5,
            todaysChange: 2.5,
            updated: 1623456789,
          ),
        ],
        status: 'OK',
        requestId: 'REQUEST123',
        count: 1,
      );
      final json = model.toJson();

      expect(json['tickers'], isA<List<dynamic>>());
      expect(json['tickers'].length, equals(1));
      expect(json['status'], equals('OK'));
      expect(json['request_id'], equals('REQUEST123'));
      expect(json['count'], equals(1));
    });
  });
}
