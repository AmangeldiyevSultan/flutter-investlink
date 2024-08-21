import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:investlink/src/core/common/utils/logger/logger.dart';
import 'package:investlink/src/features/auth/domain/entities/auth_result_entity.dart';
import 'package:investlink/src/features/auth/domain/repositories/i_auth_repository.dart';

part 'auth_bloc.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.signIn({
    required String email,
    required String password,
  }) = _SignInAuthEvent;
}

@freezed
class AuthState with _$AuthState {
  const AuthState._();

  const factory AuthState.idle({
    AuthResultEntity? authResult,
    Object? error,
  }) = _IdleAuthState;

  /// Processing state.
  const factory AuthState.processing() = _ProcessingAuthState;

  /// Initial state
  const factory AuthState.initial() = _InitialAuthState;

  /// Returns whether the state is processing or not.
  bool get isProcessing => maybeMap(
        orElse: () => false,
        processing: (_) => true,
      );
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required IAuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const AuthState.initial()) {
    on<_SignInAuthEvent>(_loginHandler);
  }

  final IAuthRepository _authRepository;

  Future<void> _loginHandler(
    _SignInAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.processing());

    try {
      final authResult = await _authRepository.signIn(email: event.email, password: event.password);

      emit(AuthState.idle(authResult: authResult));
    } catch (e, stackTrace) {
      logger.error('Error while sign in: $e, $stackTrace');
      emit(AuthState.idle(error: e.toString()));
    }
  }
}
