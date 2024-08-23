import 'package:freezed_annotation/freezed_annotation.dart';

part 'prevday_entity.freezed.dart';

/// {@template prevday_entity.class}
/// Prev day entity.
/// {@endtemplate}
@freezed
class PrevdayEntity with _$PrevdayEntity {
  /// {@macro prevday_entity.class}
  const factory PrevdayEntity({
    double? o,
    double? h,
    double? l,
    double? c,
    double? v,
    double? vw,
  }) = _PrevdayEntity;
}
