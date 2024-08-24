import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:investlink/src/core/common/utils/endpoints/api_endpoints.dart';
import 'package:investlink/src/core/components/exception/network_exception.dart';
import 'package:investlink/src/core/components/rest_client/rest_client_dio.dart';
import 'package:investlink/src/features/stock_search/data/repositories/stock_search_repository.dart';
import 'package:investlink/src/features/stock_search/domain/entities/tickers_result_entity.dart';

import '../../../../../mock_http_adapter.dart';

void main() {
  group('StockSearchRepository >', () {
    late StockSearchRepository repository;
    late RestClientDio restClient;
    late MockHttpAdapter mockAdapter;

    setUp(() {
      mockAdapter = MockHttpAdapter();
      final dio = Dio()..httpClientAdapter = mockAdapter;
      restClient = RestClientDio(baseUrl: '', dio: dio);
      repository = StockSearchRepository(restClient);
    });

    test('getStocks returns TickersResultEntity on successful request', () async {
      const query = 'AAPL';
      final mockResponse = <String, dynamic>{
        'status': 'OK',
        'count': 1,
        'request_id': '1234',
        'tickers': [
          {
            'ticker': 'AAPL',
            'todaysChangePerc': 1.5,
            'todaysChange': 2.5,
            'updated': 1623456789.0,
            'day': null,
            'lastQuote': null,
            'lastTrade': null,
            'min': null,
            'prevDay': null,
          }
        ],
      };

      mockAdapter.registerResponse(
        ApiPath.stockSearch,
        (req) => ResponseBody.fromString(
          jsonEncode(mockResponse),
          200,
        ),
        query: 'tickers=$query',
      );

      final result = await repository.getStocks(query);

      expect(result, isA<TickersResultEntity>());
      expect(result.status, equals('OK'));
      expect(result.count, equals(1));
      expect(result.requestId, equals('1234'));
      expect(result.tickers!.length, equals(1));
      expect(result.tickers![0].ticker, equals('AAPL'));
      expect(result.tickers![0].todaysChangePerc, equals(1.5));
      expect(result.tickers![0].todaysChange, equals(2.5));
      expect(result.tickers![0].updated, equals(1623456789.0));
    });

    test('getStocks throws exception on error response', () async {
      const query = 'INVALID';
      final errorResponse = {
        'error': {'message': 'Invalid ticker'},
      };

      mockAdapter.registerResponse(
        ApiPath.stockSearch,
        (req) => ResponseBody.fromString(
          jsonEncode(errorResponse),
          400,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        ),
        query: 'tickers=$query',
      );

      expect(() => repository.getStocks(query), throwsA(isA<CustomBackendException>()));
    });

    test('getStocks throws ConnectionException on network error', () async {
      const query = 'AAPL';

      mockAdapter.registerResponse(
        ApiPath.stockSearch,
        (req) => throw DioException.connectionError(
          requestOptions: RequestOptions(path: ApiPath.stockSearch),
          reason: 'No Internet!',
        ),
        query: 'tickers=$query',
      );

      expect(() => repository.getStocks(query), throwsA(isA<ConnectionException>()));
    });
  });
}
