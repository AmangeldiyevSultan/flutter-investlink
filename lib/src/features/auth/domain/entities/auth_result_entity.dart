import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:investlink/src/features/auth/domain/entities/token_pair_entity.dart';

part 'auth_result_entity.freezed.dart';

/// {@template auth_result_entity.class}
/// Token Pair address.
/// {@endtemplate}
@freezed
class AuthResultEntity with _$AuthResultEntity {
  /// {@macro ip_entity.class}
  const factory AuthResultEntity({
    required String email,
    required TokenPairEntity tokens,
  }) = _AuthResultEntity;
}
