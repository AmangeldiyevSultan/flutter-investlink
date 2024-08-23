import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:investlink/src/features/database/data/converters/ticker_converter.dart';
import 'package:investlink/src/features/database/domain/repositories/i_database_repository.dart';
import 'package:investlink/src/features/stock_search/data/models/day_model.dart';
import 'package:investlink/src/features/stock_search/data/models/last_quote_model.dart';
import 'package:investlink/src/features/stock_search/data/models/last_trade_model.dart';
import 'package:investlink/src/features/stock_search/data/models/min_model.dart';
import 'package:investlink/src/features/stock_search/data/models/prevday_model.dart';
import 'package:investlink/src/features/stock_search/data/models/tickers_model.dart';
import 'package:investlink/src/features/stock_search/domain/entities/tickers_entity.dart';

/// {@template database_repository.class}
/// Implementation of [IDatabaseRepository].
/// {@endtemplate}
final class DatabaseRepository implements IDatabaseRepository {
  /// {@macro database_repository.class}
  DatabaseRepository({
    required StreamController<List<TickersEntity>> tickersStreamController,
  }) : _tickersStreamController = tickersStreamController;

  final StreamController<List<TickersEntity>> _tickersStreamController;

  late Box<TickersModel> _tickersBox;

  static const _tickerConverter = TickerConverter();

  /// Initialize database
  @override
  Future<void> initialize() async {
    await _init();
    await _openBox();
    _initialOperation();
  }

  /// Delete database
  @override
  Future<void> delete() async {
    await Hive.deleteFromDisk();
  }

  /// Open your database connection
  /// Now using [Hive]
  Future<void> _init() async {
    await Hive.initFlutter();
    Hive
      ..registerAdapter(TickersModelAdapter())
      ..registerAdapter(PrevdayModelAdapter())
      ..registerAdapter(DayModelAdapter())
      ..registerAdapter(LastQuoteModelAdapter())
      ..registerAdapter(LastTradeModelAdapter())
      ..registerAdapter(MinModelAdapter());
  }

  /// Open your database connection
  /// Now using [Hive]
  Future<void> _openBox() async {
    _tickersBox = await Hive.openBox<TickersModel>(DatabaseStorageKeys.hiveInvestLink.keyName);
    _tickersBox.listenable().addListener(_onTickersChanged);
  }

  /// Register your generic model or make your operation before start
  void _initialOperation() {}

  /// Add ticker to favorites
  @override
  Future<void> addTickerToFavorites(TickersEntity ticker) async {
    final tickerModel = _tickerConverter.convert(ticker);
    await _tickersBox.put(ticker.ticker, tickerModel);
  }

  /// Load favorite tickers
  @override
  Future<List<TickersEntity>> loadFavouriteTickers(TickersSorting sortBy, SortOrder order) async {
    final tickerList = _tickersBox.values.toList()
      ..sort((a, b) {
        double aValue;
        double bValue;

        // Determine the value to sort by
        switch (sortBy) {
          case TickersSorting.price:
            aValue = a.prevDay?.o ?? double.infinity; // Handle null values
            bValue = b.prevDay?.o ?? double.infinity;
          case TickersSorting.changes:
            aValue = a.todaysChangePerc ?? double.infinity; // Handle null values
            bValue = b.todaysChangePerc ?? double.infinity;
        }

        // Perform comparison based on sorting order
        final comparison = aValue.compareTo(bValue);
        return order == SortOrder.ascending ? comparison : -comparison;
      });
    return tickerList.map((e) => _tickerConverter.convertReverse(e)).toList();
  }

  ///  Remove ticker from favorites
  @override
  Future<void> removeTickerFromFavorites(String symbol) async {
    await _tickersBox.delete(symbol);
  }

  void dispose() {
    _tickersStreamController.close();
  }

  void _onTickersChanged() {
    _tickersStreamController
        .add(_tickersBox.values.map((e) => _tickerConverter.convertReverse(e)).toList());
  }

  @override
  Stream<List<TickersEntity>> get tickersStream => _tickersStreamController.stream;
}

/// Keys for [DatabaseRepository].
enum DatabaseStorageKeys {
  /// Theme mode.
  hiveInvestLink('investlink-stock');

  const DatabaseStorageKeys(this.keyName);

  /// Key Name.
  final String keyName;
}

enum TickersSorting { price, changes }

enum SortOrder { ascending, descending }
