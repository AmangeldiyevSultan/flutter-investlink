import 'package:investlink/src/core/common/utils/endpoints/api_endpoints.dart';
import 'package:investlink/src/core/components/rest_client/rest_client.dart';
import 'package:investlink/src/features/auth/data/converters/auth_result_converter.dart';
import 'package:investlink/src/features/auth/data/models/auth_result_model.dart';
import 'package:investlink/src/features/auth/domain/entities/auth_result_entity.dart';
import 'package:investlink/src/features/auth/domain/repositories/i_auth_repository.dart';

/// {@template auth_repository.class}
/// Implementation of [IAuthRepository].
/// {@endtemplate}
final class AuthRepository implements IAuthRepository {
  /// {@macro auth_repository.class}
  const AuthRepository(this._client);

  final RestClient _client;

  final _authResultConverter = const AuthResultConverter();

  @override
  Future<AuthResultEntity> signIn({
    required String email,
    required String password,
  }) async {
    final reponse = await _client.post(
      ApiPath.login,
      body: {
        'email': email,
        'password': password,
      },
    );

    final result = AuthResultModel.fromJson(reponse! as Map<String, dynamic>);

    return _authResultConverter.convert(result);
  }
}
