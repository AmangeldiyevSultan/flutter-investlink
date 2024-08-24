import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:investlink/src/core/common/utils/endpoints/api_endpoints.dart';
import 'package:investlink/src/core/components/exception/network_exception.dart';
import 'package:investlink/src/core/components/rest_client/rest_client_dio.dart';
import 'package:investlink/src/features/auth/data/repositories/auth_repository.dart';
import 'package:investlink/src/features/auth/domain/entities/auth_result_entity.dart';
import 'package:investlink/src/features/auth/domain/repositories/i_auth_repository.dart';

import '../../../../../mock_http_adapter.dart';

void main() {
  group('AuthRepository >', () {
    late IAuthRepository repository;
    late RestClientDio restClient;
    late MockHttpAdapter mockAdapter;

    setUp(() {
      mockAdapter = MockHttpAdapter();
      final dio = Dio()..httpClientAdapter = mockAdapter;
      restClient = RestClientDio(baseUrl: '', dio: dio);
      repository = AuthRepository(restClient);
    });

    test('getStocks returns AuthResultEntity on successful request', () async {
      final mockResponse = <String, dynamic>{
        'email': 'test@mail.ru',
        'tokens': {
          'access': 'access',
          'refresh': 'refresh',
        },
      };

      mockAdapter.registerResponse(
        '/auth_db/login',
        (req) => ResponseBody.fromString(
          jsonEncode(mockResponse),
          200,
        ),
      );

      final result = await repository.signIn(email: 'test@mail.ru', password: 'test');

      expect(result, isA<AuthResultEntity>());
      expect(result.email, equals('test@mail.ru'));
      expect(result.tokens.access, equals('access'));
      expect(result.tokens.refresh, equals('refresh'));
    });

    test('getStocks throws exception on error response', () async {
      final errorResponse = {
        'error': {'message': 'Invalid ticker'},
      };

      mockAdapter.registerResponse(
        '/auth_db/login',
        (req) => ResponseBody.fromString(
          jsonEncode(errorResponse),
          400,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        ),
      );

      expect(
        () => repository.signIn(email: 'test@mail.ru', password: 'test'),
        throwsA(
          isA<CustomBackendException>(),
        ),
      );
    });

    test('getStocks throws ConnectionException on network error', () async {
      mockAdapter.registerResponse(
        '/auth_db/login',
        (req) => throw DioException.connectionError(
          requestOptions: RequestOptions(path: ApiPath.stockSearch),
          reason: 'No Internet!',
        ),
      );

      expect(
        () => repository.signIn(email: 'test@mail.ru', password: 'test'),
        throwsA(isA<ConnectionException>()),
      );
    });
  });
}
