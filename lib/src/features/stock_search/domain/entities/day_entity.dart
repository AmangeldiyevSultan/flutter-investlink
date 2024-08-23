import 'package:freezed_annotation/freezed_annotation.dart';

part 'day_entity.freezed.dart';

/// {@template day_entity.class}
/// Day quote entity.
/// {@endtemplate}
@freezed
class DayEntity with _$DayEntity {
  /// {@macro day_entity.class}
  const factory DayEntity({
    double? o,
    double? h,
    double? l,
    double? c,
    double? v,
    double? vw,
  }) = _DayEntity;
}
