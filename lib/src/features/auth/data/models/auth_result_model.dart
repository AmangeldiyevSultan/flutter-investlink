import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:investlink/src/features/auth/data/models/token_pair_model.dart';

part 'auth_result_model.g.dart';

/// {@template auth_result_model.class}
/// Model for AuthResultModel.
/// {@endtemplate}
@JsonSerializable()
class AuthResultModel {
  /// {@macro auth_result_model.class}
  const AuthResultModel({
    required this.email,
    required this.tokens,
  });

  /// Get Model object from json.
  factory AuthResultModel.fromJson(Map<String, dynamic> json) => _$AuthResultModelFromJson(json);

  /// AuthResultModel
  final String email;
  final TokenPairModel tokens;

  /// Convert a Model object to json.
  Map<String, dynamic> toJson() => _$AuthResultModelToJson(this);
}
