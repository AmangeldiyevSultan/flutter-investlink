import 'package:flutter_test/flutter_test.dart';
import 'package:investlink/src/features/stock_search/data/models/min_model.dart';

void main() {
  group('MinModel >', () {
    test('fromJson creates correct model', () {
      final json = {
        'av': 5000.0,
        't': 1623456789.0,
        'n': 100.0,
        'o': 100.0,
        'h': 110.0,
        'l': 95.0,
        'c': 105.0,
        'v': 10000.0,
        'vw': 102.5,
      };
      final model = MinModel.fromJson(json);

      expect(model.av, equals(5000.0));
      expect(model.t, equals(1623456789.0));
      expect(model.n, equals(100.0));
      expect(model.o, equals(100.0));
      expect(model.h, equals(110.0));
      expect(model.l, equals(95.0));
      expect(model.c, equals(105.0));
      expect(model.v, equals(10000.0));
      expect(model.vw, equals(102.5));
    });

    test('toJson returns correct map', () {
      const model = MinModel(
        av: 5000,
        t: 1623456789,
        n: 100,
        o: 100,
        h: 110,
        l: 95,
        c: 105,
        v: 10000,
        vw: 102.5,
      );
      final json = model.toJson();

      expect(json['av'], equals(5000.0));
      expect(json['t'], equals(1623456789.0));
      expect(json['n'], equals(100.0));
      expect(json['o'], equals(100.0));
      expect(json['h'], equals(110.0));
      expect(json['l'], equals(95.0));
      expect(json['c'], equals(105.0));
      expect(json['v'], equals(10000.0));
      expect(json['vw'], equals(102.5));
    });

    test('handles null values correctly', () {
      const model = MinModel();
      expect(model.av, isNull);
      expect(model.t, isNull);
      expect(model.n, isNull);
      expect(model.o, isNull);
      expect(model.h, isNull);
      expect(model.l, isNull);
      expect(model.c, isNull);
      expect(model.v, isNull);
      expect(model.vw, isNull);

      final json = model.toJson();
      expect(json['av'], isNull);
      expect(json['t'], isNull);
      expect(json['n'], isNull);
      expect(json['o'], isNull);
      expect(json['h'], isNull);
      expect(json['l'], isNull);
      expect(json['c'], isNull);
      expect(json['v'], isNull);
      expect(json['vw'], isNull);
    });
  });
}
