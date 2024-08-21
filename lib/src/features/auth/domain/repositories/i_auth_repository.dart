import 'package:investlink/src/features/auth/data/repositories/auth_repository.dart';
import 'package:investlink/src/features/auth/domain/entities/auth_result_entity.dart';

/// Interface for [AuthRepository].
abstract interface class IAuthRepository {
  Future<AuthResultEntity> signIn({
    required String email,
    required String password,
  });
}
