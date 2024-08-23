import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'day_model.g.dart';

/// {@template day_model.class}
/// Model for DayModel.
/// {@endtemplate}
@JsonSerializable()
@HiveType(typeId: 5)
class DayModel {
  /// {@macro day_model.class}
  const DayModel({
    this.o,
    this.h,
    this.l,
    this.c,
    this.v,
    this.vw,
  });

  /// Get Model object from json.
  factory DayModel.fromJson(Map<String, dynamic> json) => _$DayModelFromJson(json);

  /// DayModel
  @HiveField(0)
  final double? o;
  @HiveField(1)
  final double? h;
  @HiveField(2)
  final double? l;
  @HiveField(3)
  final double? c;
  @HiveField(4)
  final double? v;
  @HiveField(5)
  final double? vw;

  /// Convert a Model object to json.
  Map<String, dynamic> toJson() => _$DayModelToJson(this);
}
