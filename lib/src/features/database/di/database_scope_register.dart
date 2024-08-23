import 'dart:async';

import 'package:investlink/src/features/database/data/repositories/database_repository.dart';
import 'package:investlink/src/features/database/di/database_scope.dart';
import 'package:investlink/src/features/database/presentation/cubit/tickers_cubit.dart';
import 'package:investlink/src/features/stock_search/domain/entities/tickers_entity.dart';

/// {@template database_scope_register.class}
/// Creates and initializes DatabaseScope.
/// {@endtemplate}
final class DatabaseScopeRegister {
  /// {@macro database_scope_register.class}
  const DatabaseScopeRegister();

  /// Create scope.
  Future<IDatabaseScope> createScope() async {
    final databaseRepository = DatabaseRepository(
      tickersStreamController: StreamController<List<TickersEntity>>.broadcast(),
    );
    await databaseRepository.initialize();

    return DatabaseScope(
      tickersCubit: TickersCubit(
        databaseRepository: databaseRepository,
      ),
    );
  }
}
