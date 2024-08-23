import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'prevday_model.g.dart';

/// {@template prevday_model.class}
/// Model for PrevdayModel.
/// {@endtemplate}
@JsonSerializable()
@HiveType(typeId: 1)
class PrevdayModel {
  /// {@macro prevday_model.class}
  const PrevdayModel({
    this.o,
    this.h,
    this.l,
    this.c,
    this.v,
    this.vw,
  });

  /// Get Model object from json.
  factory PrevdayModel.fromJson(Map<String, dynamic> json) => _$PrevdayModelFromJson(json);

  /// PrevdayModel
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
  Map<String, dynamic> toJson() => _$PrevdayModelToJson(this);
}
