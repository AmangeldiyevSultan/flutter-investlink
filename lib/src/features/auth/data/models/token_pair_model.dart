import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_pair_model.g.dart';

/// {@template token_pair_model.class}
/// Model for TokenPairModel.
/// {@endtemplate}
@JsonSerializable()
class TokenPairModel {
  /// {@macro token_pair_model.class}
  const TokenPairModel({
    required this.access,
    required this.refresh,
  });

  /// Get Model object from json.
  factory TokenPairModel.fromJson(Map<String, dynamic> json) => _$TokenPairModelFromJson(json);

  /// TokenPairModel
  final String access;
  final String refresh;

  /// Convert a Model object to json.
  Map<String, dynamic> toJson() => _$TokenPairModelToJson(this);
}
