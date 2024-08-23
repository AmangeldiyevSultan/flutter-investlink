import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investlink/src/core/common/utils/disposable_object/disposable_object.dart';
import 'package:investlink/src/core/common/utils/disposable_object/i_disposable_object.dart';
import 'package:investlink/src/core/components/rest_client/rest_client_dio.dart';
import 'package:investlink/src/features/app/di/app_scope.dart';
import 'package:investlink/src/features/stock_details/data/repositories/stock_details_repository.dart';
import 'package:investlink/src/features/stock_details/presentation/cubit/stock_details_cubit.dart';

/// {@template stock_details_scope.class}
/// Implementation of [IStockDetailsScope].
/// {@endtemplate}
final class StockDetailsScope extends DisposableObject implements IStockDetailsScope {
  /// {@macro stock_details_scope.class}
  /// Factory constructor for [IStockDetailsScope].
  StockDetailsScope({
    required StockDetailsCubit stockDetailsCubit,
  }) : _stockDetailsCubit = stockDetailsCubit;

  /// Factory constructor for [IStockDetailsScope].
  factory StockDetailsScope.create(BuildContext context) {
    final scope = context.read<IAppScope>();

    final stockDetailsRepository = StockDetailsRepository(
      RestClientDio(
        baseUrl: scope.appConfig.url.value,
        dio: scope.dio,
      ),
    );

    return StockDetailsScope(
      stockDetailsCubit: StockDetailsCubit(
        stockDetailsRepository: stockDetailsRepository,
      ),
    );
  }

  /// Private field to hold the cubit instance.
  final StockDetailsCubit _stockDetailsCubit;

  @override
  late final StockDetailsCubit stockDetailsCubit = _stockDetailsCubit;
}

/// Scope dependencies of the StockDetails feature.
abstract interface class IStockDetailsScope implements IDisposableObject {
  /// StockDetailsCubit.
  StockDetailsCubit get stockDetailsCubit;
}
