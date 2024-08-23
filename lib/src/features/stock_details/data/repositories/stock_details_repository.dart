import 'package:investlink/src/core/common/entity/query_params_entity.dart';
import 'package:investlink/src/core/common/utils/endpoints/api_endpoints.dart';
import 'package:investlink/src/core/components/rest_client/rest_client.dart';
import 'package:investlink/src/features/stock_details/data/converters/tickers_result_converter.dart';
import 'package:investlink/src/features/stock_details/data/models/ticker_result_model.dart';
import 'package:investlink/src/features/stock_details/domain/entities/ticker_result_entity.dart';
import 'package:investlink/src/features/stock_details/domain/repositories/i_stock_details_repository.dart';

/// {@template stock_details_repository.class}
/// Implementation of [IStockDetailsRepository].
/// {@endtemplate}
final class StockDetailsRepository implements IStockDetailsRepository {
  /// {@macro stock_details_repository.class}
  const StockDetailsRepository(this._client);

  // ignore: unused_field
  final RestClient _client;

  final _tickerDetailResultConverter = const TickerDetailResultConverter();

  @override
  Future<TickerResultEntity> getStockDetails(QueryParamsEntity queryParams) async {
    final tickerData = await _client.get(ApiPath.tickerHistory, queryParams: queryParams.toQuery());

    return _tickerDetailResultConverter.convert(TickerResultModel.fromJson(tickerData!));
  }
}
