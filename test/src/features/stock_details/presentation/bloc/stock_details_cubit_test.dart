import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:investlink/src/core/common/entity/query_params_entity.dart';
import 'package:investlink/src/core/common/utils/endpoints/api_endpoints.dart';
import 'package:investlink/src/core/components/rest_client/rest_client_dio.dart';
import 'package:investlink/src/features/stock_details/data/repositories/stock_details_repository.dart';
import 'package:investlink/src/features/stock_details/domain/entities/ticker_result_entity.dart';
import 'package:investlink/src/features/stock_details/domain/repositories/i_stock_details_repository.dart';
import 'package:investlink/src/features/stock_details/presentation/bloc/stock_details_cubit.dart';
import 'package:investlink/src/features/stock_details/presentation/screens/stock_details_screen.dart';

import '../../../../../mock_http_adapter.dart';

void main() {
  late StockDetailsCubit cubit;
  late IStockDetailsRepository mockRepository;
  late RestClientDio restClient;
  late MockHttpAdapter mockAdapter;

  setUp(() {
    mockAdapter = MockHttpAdapter();
    final dio = Dio()..httpClientAdapter = mockAdapter;
    restClient = RestClientDio(baseUrl: '', dio: dio);
    mockRepository = StockDetailsRepository(restClient);
    cubit = StockDetailsCubit(stockDetailsRepository: mockRepository);
  });

  test('initial state is processing', () {
    expect(cubit.state, const StockDetailsState.processing());
  });

  group('getStockDetails', () {
    const tickerResult = TickerResultEntity(); // Provide a mock or real instance if needed

    blocTest<StockDetailsCubit, StockDetailsState>(
      'emits [processing, idle] when data is successfully fetched',
      build: () {
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
          ApiPath.tickerHistory,
          (req) => ResponseBody.fromString(
            jsonEncode(mockResponse),
            200,
          ),
          query: 'ticker=AAPL&timePeriod=1%2Fday%2F2024-07-24%2F2024-08-24',
        );

        mockRepository.getStockDetails(_queryParams());

        return cubit;
      },
      act: (cubit) => cubit.getStockDetails(DateRange.month, 'AAPL'),
      expect: () => [
        const StockDetailsState.processing(),
        const StockDetailsState.idle(
          tickerResult: tickerResult,
          dateRange: DateRange.month,
        ),
      ],
    );
  });
}

QueryParamsEntity _queryParams() {
  return const QueryParamsEntity(
    ticker: 'AAPL',
    timePeriod: '1/day/2024-07-24/2024-08-24',
  );
}
