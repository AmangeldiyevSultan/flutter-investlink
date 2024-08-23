import 'package:flutter/material.dart';
import 'package:investlink/src/core/common/widgets/di_scope.dart';
import 'package:investlink/src/features/stock/di/stock_scope.dart';
import 'package:investlink/src/features/stock/presentation/screens/stock_screen.dart';

/// {@template stock_flow.class}
/// Entry point to feature .
/// {@endtemplate}
class StockFlow extends StatelessWidget {
  /// {@macro stock_flow.class}
  const StockFlow({super.key});

  static const String routePath = '/stock';
  static const String routeName = 'stock';

  @override
  Widget build(BuildContext context) {
    return DiScope<IStockScope>(
      factory: (_) => StockScope.create(context),
      onDispose: (scope) => scope.dispose(),
      child: const StockScreen(),
    );
  }
}
