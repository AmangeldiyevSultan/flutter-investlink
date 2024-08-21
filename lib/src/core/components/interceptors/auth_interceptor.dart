import 'package:dio/dio.dart';
import 'package:investlink/src/core/common/utils/logger/logger.dart';
import 'package:investlink/src/core/components/exception/network_exception.dart';
import 'package:investlink/src/core/persistence/tokens_storage/auth_token_pair.dart';
import 'package:investlink/src/core/persistence/tokens_storage/i_token_storage.dart';

DioException _dioException(DioException err, Exception ex) {
  return DioException(
    requestOptions: err.requestOptions,
    error: ex,
  );
}

class AuthInterceptor<T> extends QueuedInterceptor {
  AuthInterceptor({
    required ITokenStorage<AuthTokenPair> tokenStorage,
  }) : _tokenStorage = tokenStorage;

  final ITokenStorage<AuthTokenPair> _tokenStorage;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final authTokenPair = await _tokenStorage.read();

    final token = authTokenPair?.accessToken;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      final statusCode = err.response!.statusCode;
      if (statusCode != null) {
        if (statusCode >= 400 && statusCode <= 499) {
          logger.error('${err.response?.data}');

          /// Handle client errors
          handler.reject(
            _dioException(
              err,
              ClientException(
                message: 'Client error occurred ',
                statusCode: statusCode,
              ),
            ),
          );
        } else if (statusCode >= 500 && statusCode <= 599) {
          /// Handle client errors
          handler.reject(
            _dioException(
              err,
              CustomBackendException(
                message: 'Server error occurred ',
                statusCode: statusCode,
                error: err.response?.data as Map<String, dynamic>,
              ),
            ),
          );
        }
      }
    }
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: 'The user has been deleted or the session is expired',
      ),
    );
    // Continue with default error handling for other errors
    super.onError(err, handler);
  }
}
