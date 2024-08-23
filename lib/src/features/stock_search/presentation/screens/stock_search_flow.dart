import 'package:flutter/material.dart';
import 'package:investlink/src/core/common/widgets/di_scope.dart';
import 'package:investlink/src/features/stock_search/di/stock_search_scope.dart';
import 'package:investlink/src/features/stock_search/presentation/screens/stock_search_screen.dart';

/// {@template stock_search_flow.class}
/// Entry point to feature .
/// {@endtemplate}
class StockSearchFlow extends StatelessWidget {
  /// {@macro stock_search_flow.class}
  const StockSearchFlow({super.key});

  static const String routePath = '/stockSearch';
  static const String routeName = 'stockSearch';

  @override
  Widget build(BuildContext context) {
    return DiScope<IStockSearchScope>(
      factory: (_) => StockSearchScope.create(context),
      onDispose: (scope) => scope.dispose(),
      child: const StockSearchScreen(),
    );
  }
}
