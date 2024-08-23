import 'package:investlink/src/features/stock_search/data/repositories/stock_search_repository.dart';
import 'package:investlink/src/features/stock_search/domain/entities/tickers_result_entity.dart';

/// Interface for [StockSearchRepository].
abstract interface class IStockSearchRepository {
  Future<TickersResultEntity> getStocks(String query);
}
