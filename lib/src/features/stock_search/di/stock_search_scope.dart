import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investlink/src/core/common/utils/disposable_object/disposable_object.dart';
import 'package:investlink/src/core/common/utils/disposable_object/i_disposable_object.dart';
import 'package:investlink/src/core/components/rest_client/rest_client_dio.dart';
import 'package:investlink/src/features/app/di/app_scope.dart';
import 'package:investlink/src/features/stock_search/data/repositories/stock_search_repository.dart';
import 'package:investlink/src/features/stock_search/presentation/bloc/stock_search_bloc.dart';

/// {@template stock_search_scope.class}
/// Implementation of [IStockSearchScope].
/// {@endtemplate}
final class StockSearchScope extends DisposableObject implements IStockSearchScope {
  /// {@macro stock_search_scope.class}
  /// Factory constructor for [IStockSearchScope].
  StockSearchScope({
    required StockSearchBloc stockSearchBloc,
  }) : _stockSearchBloc = stockSearchBloc;

  /// Factory constructor for [IStockSearchScope].
  factory StockSearchScope.create(BuildContext context) {
    final scope = context.read<IAppScope>();

    final stockSearchRepository = StockSearchRepository(
      RestClientDio(
        baseUrl: scope.appConfig.url.value,
        dio: scope.dio,
      ),
    );

    return StockSearchScope(
      stockSearchBloc: StockSearchBloc(
        stockSearchRepository: stockSearchRepository,
      ),
    );
  }

  /// Private field to hold the bloc instance.
  final StockSearchBloc _stockSearchBloc;

  @override
  late final StockSearchBloc stockSearchBloc = _stockSearchBloc;
}

/// Scope dependencies of the StockSearch feature.
abstract interface class IStockSearchScope implements IDisposableObject {
  /// StockSearchBloc.
  StockSearchBloc get stockSearchBloc;
}
