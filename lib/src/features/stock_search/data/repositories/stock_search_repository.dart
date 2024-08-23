import 'package:investlink/src/core/common/utils/endpoints/api_endpoints.dart';
import 'package:investlink/src/core/components/rest_client/rest_client.dart';
import 'package:investlink/src/features/stock_search/data/converters/tickers_result_converter.dart';
import 'package:investlink/src/features/stock_search/data/models/tickers_result_model.dart';
import 'package:investlink/src/features/stock_search/domain/entities/tickers_result_entity.dart';
import 'package:investlink/src/features/stock_search/domain/repositories/i_stock_search_repository.dart';

/// {@template stock_search_repository.class}
/// Implementation of [IStockSearchRepository].
/// {@endtemplate}
final class StockSearchRepository implements IStockSearchRepository {
  /// {@macro stock_search_repository.class}
  const StockSearchRepository(this._client);

  final RestClient _client;

  final _tickersResultConverter = const TickersResultConverter();

  @override
  Future<TickersResultEntity> getStocks(String query) async {
    final response = await _client.get(
      ApiPath.stockSearch,
      queryParams: {'tickers': query},
    );
    return _tickersResultConverter.convert(TickersResultModel.fromJson(response!));
  }
}
