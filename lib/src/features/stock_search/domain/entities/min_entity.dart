import 'package:freezed_annotation/freezed_annotation.dart';

part 'min_entity.freezed.dart';

/// {@template min_entity.class}
/// Min entity.
/// {@endtemplate}
@freezed
class MinEntity with _$MinEntity {
  /// {@macro min_entity.class}
  const factory MinEntity({
    double? av,
    double? t,
    double? n,
    double? o,
    double? h,
    double? l,
    double? c,
    double? v,
    double? vw,
  }) = _MinEntity;
}
