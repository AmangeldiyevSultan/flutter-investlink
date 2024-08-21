import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_pair_entity.freezed.dart';

/// {@template token_pair_entity.class}
/// Token Pair address.
/// {@endtemplate}
@freezed
class TokenPairEntity with _$TokenPairEntity {
  /// {@macro ip_entity.class}
  const factory TokenPairEntity({
    required String access,
    required String refresh,
  }) = _TokenPairEntity;
}
