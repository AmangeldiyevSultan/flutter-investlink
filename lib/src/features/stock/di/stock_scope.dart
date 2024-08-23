import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investlink/src/core/common/utils/disposable_object/disposable_object.dart';
import 'package:investlink/src/core/common/utils/disposable_object/i_disposable_object.dart';
import 'package:investlink/src/core/components/rest_client/rest_client_dio.dart';
import 'package:investlink/src/features/app/di/app_scope.dart';
import 'package:investlink/src/features/stock/data/repositories/stock_repository.dart';
import 'package:investlink/src/features/stock/presentation/bloc/stock_bloc.dart';

/// {@template stock_scope.class}
/// Implementation of [IStockScope].
/// {@endtemplate}
final class StockScope extends DisposableObject implements IStockScope {
  /// {@macro stock_scope.class}
  /// Factory constructor for [IStockScope].
  StockScope({
    required StockBloc stockBloc,
  }) : _stockBloc = stockBloc;

  /// Factory constructor for [IStockScope].
  factory StockScope.create(BuildContext context) {
    final scope = context.read<IAppScope>();

    final stockRepository = StockRepository(
      RestClientDio(
        baseUrl: scope.appConfig.url.value,
        dio: scope.dio,
      ),
    );

    return StockScope(
      stockBloc: StockBloc(
        stockRepository: stockRepository,
      ),
    );
  }

  /// Private field to hold the bloc instance.
  final StockBloc _stockBloc;

  @override
  late final StockBloc stockBloc = _stockBloc;
}

/// Scope dependencies of the Stock feature.
abstract interface class IStockScope implements IDisposableObject {
  /// StockBloc.
  StockBloc get stockBloc;
}
