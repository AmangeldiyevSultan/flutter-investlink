import 'package:flutter_test/flutter_test.dart';
import 'package:investlink/src/features/stock_search/data/models/prevday_model.dart';

void main() {
  group('PrevdayModel >', () {
    test('fromJson creates correct model', () {
      final json = {
        'o': 100.0,
        'h': 110.0,
        'l': 95.0,
        'c': 105.0,
        'v': 1000000.0,
        'vw': 102.5,
      };
      final model = PrevdayModel.fromJson(json);

      expect(model.o, equals(100.0));
      expect(model.h, equals(110.0));
      expect(model.l, equals(95.0));
      expect(model.c, equals(105.0));
      expect(model.v, equals(1000000.0));
      expect(model.vw, equals(102.5));
    });

    test('toJson returns correct map', () {
      const model = PrevdayModel(
        o: 100,
        h: 110,
        l: 95,
        c: 105,
        v: 1000000,
        vw: 102.5,
      );
      final json = model.toJson();

      expect(json['o'], equals(100.0));
      expect(json['h'], equals(110.0));
      expect(json['l'], equals(95.0));
      expect(json['c'], equals(105.0));
      expect(json['v'], equals(1000000.0));
      expect(json['vw'], equals(102.5));
    });
  });
}
