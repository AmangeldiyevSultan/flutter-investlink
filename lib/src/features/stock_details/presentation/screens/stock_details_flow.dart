import 'package:flutter/material.dart';
import 'package:investlink/src/core/common/widgets/di_scope.dart';
import 'package:investlink/src/features/stock_details/di/stock_details_scope.dart';
import 'package:investlink/src/features/stock_details/presentation/screens/stock_details_screen.dart';
import 'package:investlink/src/features/stock_search/domain/entities/tickers_entity.dart';

/// {@template stock_details_flow.class}
/// Entry point to feature .
/// {@endtemplate}
class StockDetailsFlow extends StatelessWidget {
  /// {@macro stock_details_flow.class}
  const StockDetailsFlow({
    required this.tickersEntity,
    super.key,
  });

  static const String routePath = '/stockDetails';
  static const String routeName = 'stockDetails';

  final TickersEntity tickersEntity;

  @override
  Widget build(BuildContext context) {
    return DiScope<IStockDetailsScope>(
      factory: (_) => StockDetailsScope.create(context),
      onDispose: (scope) => scope.dispose(),
      child: StockDetailsScreen(
        ticker: tickersEntity,
      ),
    );
  }
}
