import 'package:investlink/src/core/architecture/data/converter/converter.dart';
import 'package:investlink/src/features/auth/data/model/auth_result_model.dart';
import 'package:investlink/src/features/auth/domain/entities/auth_result_entity.dart';
import 'package:investlink/src/features/auth/domain/entities/token_pair_entity.dart';

/// Converter for [AuthResultEntity].
typedef IAuthResultConverter = Converter<AuthResultEntity, AuthResultModel>;

/// {@template auth_result_converter.class}
/// Implementation of [IAuthResultConverter].
/// {@endtemplate}
final class AuthResultConverter extends IAuthResultConverter {
  /// {@macro category_converter.class}
  const AuthResultConverter();

  @override
  AuthResultEntity convert(AuthResultModel input) {
    return AuthResultEntity(
      email: input.email,
      tokens: TokenPairEntity(
        access: input.tokens.access,
        refresh: input.tokens.refresh,
      ),
    );
  }
}
