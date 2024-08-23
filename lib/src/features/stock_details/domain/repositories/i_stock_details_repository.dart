import 'package:investlink/src/core/common/entity/query_params_entity.dart';
import 'package:investlink/src/features/stock_details/data/repositories/stock_details_repository.dart';
import 'package:investlink/src/features/stock_details/domain/entities/ticker_result_entity.dart';

/// Interface for [StockDetailsRepository].
abstract interface class IStockDetailsRepository {
  /// Get stock details.
  Future<TickerResultEntity> getStockDetails(QueryParamsEntity queryParams);
}
