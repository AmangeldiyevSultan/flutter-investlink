import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'min_model.g.dart';

/// {@template min_model.class}
/// Model for MinModel.
/// {@endtemplate}
@JsonSerializable()
@HiveType(typeId: 2)
class MinModel {
  /// {@macro min_model.class}
  const MinModel({
    this.av,
    this.t,
    this.n,
    this.o,
    this.h,
    this.l,
    this.c,
    this.v,
    this.vw,
  });

  /// Get Model object from json.
  factory MinModel.fromJson(Map<String, dynamic> json) => _$MinModelFromJson(json);

  /// MinModel
  @HiveField(0)
  final double? av;
  @HiveField(1)
  final double? t;
  @HiveField(2)
  final double? n;
  @HiveField(3)
  final double? o;
  @HiveField(4)
  final double? h;
  @HiveField(5)
  final double? l;
  @HiveField(6)
  final double? c;
  @HiveField(7)
  final double? v;
  @HiveField(8)
  final double? vw;

  /// Convert a Model object to json.
  Map<String, dynamic> toJson() => _$MinModelToJson(this);
}
