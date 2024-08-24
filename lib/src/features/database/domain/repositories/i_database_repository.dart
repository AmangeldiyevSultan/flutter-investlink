import 'package:investlink/src/features/database/data/repositories/database_repository.dart';
import 'package:investlink/src/features/socket/domain/entities/socket_message_entity.dart';
import 'package:investlink/src/features/stock_search/domain/entities/tickers_entity.dart';

/// Interface for [DatabaseRepository].
abstract interface class IDatabaseRepository {
  Stream<List<TickersEntity>> get tickersStream;

  Future<void> initialize();

  Future<void> delete();

  Future<void> addTickerToFavorites(TickersEntity tickers);

  Future<void> removeTickerFromFavorites(String symbol);

  Future<List<TickersEntity>> loadFavouriteTickers(TickersSorting sortBy, SortOrder order);

  Future<void> changeFavoritesTicker(List<SocketMessageEntity> socketMessageList);
}
