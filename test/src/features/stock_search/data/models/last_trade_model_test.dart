import 'package:flutter_test/flutter_test.dart';
import 'package:investlink/src/features/stock_search/data/models/last_trade_model.dart';

void main() {
  group('LastTradeModel >', () {
    test('fromJson creates correct model', () {
      final json = {
        'c': [1.0, 2.0],
        'i': 'TRADE123',
        'p': 150.5,
        's': 100.0,
        't': 1623456789.0,
        'x': 3.0,
      };
      final model = LastTradeModel.fromJson(json);

      expect(model.c, equals([1.0, 2.0]));
      expect(model.i, equals('TRADE123'));
      expect(model.p, equals(150.5));
      expect(model.s, equals(100.0));
      expect(model.t, equals(1623456789.0));
      expect(model.x, equals(3.0));
    });

    test('toJson returns correct map', () {
      const model = LastTradeModel(
        c: [1.0, 2.0],
        i: 'TRADE123',
        p: 150.5,
        s: 100,
        t: 1623456789,
        x: 3,
      );
      final json = model.toJson();

      expect(json['c'], equals([1.0, 2.0]));
      expect(json['i'], equals('TRADE123'));
      expect(json['p'], equals(150.5));
      expect(json['s'], equals(100.0));
      expect(json['t'], equals(1623456789.0));
      expect(json['x'], equals(3.0));
    });
  });
}
