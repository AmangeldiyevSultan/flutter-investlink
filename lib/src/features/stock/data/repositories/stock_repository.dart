import 'package:investlink/src/core/components/rest_client/rest_client.dart';
import 'package:investlink/src/features/stock/domain/repositories/i_stock_repository.dart';

/// {@template stock_repository.class}
/// Implementation of [IStockRepository].
/// {@endtemplate}
final class StockRepository implements IStockRepository {
  /// {@macro stock_repository.class}
  const StockRepository(this._client);

  // ignore: unused_field
  final RestClient _client;
}
