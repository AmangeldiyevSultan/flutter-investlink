import 'package:flutter_test/flutter_test.dart';
import 'package:investlink/src/features/stock_search/data/models/last_quote_model.dart';

void main() {
  group('LastQuoteModel >', () {
    test('fromJson creates correct model', () {
      final json = {
        'P': 100.5,
        'S': 1000.0,
        'p': 99.5,
        's': 500.0,
        't': 1623456789.0,
      };
      final model = LastQuoteModel.fromJson(json);

      expect(model.P, equals(100.5));
      expect(model.S, equals(1000.0));
      expect(model.p, equals(99.5));
      expect(model.s, equals(500.0));
      expect(model.t, equals(1623456789.0));
    });

    test('toJson returns correct map', () {
      const model = LastQuoteModel(
        P: 100.5,
        S: 1000,
        p: 99.5,
        s: 500,
        t: 1623456789,
      );
      final json = model.toJson();

      expect(json['P'], equals(100.5));
      expect(json['S'], equals(1000.0));
      expect(json['p'], equals(99.5));
      expect(json['s'], equals(500.0));
      expect(json['t'], equals(1623456789.0));
    });
  });
}
