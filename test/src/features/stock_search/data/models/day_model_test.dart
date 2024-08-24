import 'package:flutter_test/flutter_test.dart';
import 'package:investlink/src/features/stock_search/data/models/day_model.dart';

void main() {
  group('DayModel >', () {
    const testData = {
      'o': 100.0,
      'h': 110.0,
      'l': 95.0,
      'c': 105.0,
      'v': 1000000.0,
      'vw': 102.5,
    };

    test('can be instantiated', () {
      const model = DayModel(
        o: 100,
        h: 110,
        l: 95,
        c: 105,
        v: 1000000,
        vw: 102.5,
      );

      expect(model.o, equals(100.0));
      expect(model.h, equals(110.0));
      expect(model.l, equals(95.0));
      expect(model.c, equals(105.0));
      expect(model.v, equals(1000000.0));
      expect(model.vw, equals(102.5));
    });

    test('can be instantiated with null values', () {
      const model = DayModel();

      expect(model.o, isNull);
      expect(model.h, isNull);
      expect(model.l, isNull);
      expect(model.c, isNull);
      expect(model.v, isNull);
      expect(model.vw, isNull);
    });

    test('fromJson creates correct model', () {
      final model = DayModel.fromJson(testData);

      expect(model.o, equals(100.0));
      expect(model.h, equals(110.0));
      expect(model.l, equals(95.0));
      expect(model.c, equals(105.0));
      expect(model.v, equals(1000000.0));
      expect(model.vw, equals(102.5));
    });

    test('toJson returns correct map', () {
      const model = DayModel(
        o: 100,
        h: 110,
        l: 95,
        c: 105,
        v: 1000000,
        vw: 102.5,
      );

      final json = model.toJson();

      expect(json, equals(testData));
    });
  });
}
