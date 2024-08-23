import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:investlink/src/core/router/custom_router.dart';
import 'package:investlink/src/features/auth/presentation/screens/auth_flow.dart';
import 'package:investlink/src/features/pincode/presentation/screens/pincode_flow.dart';
import 'package:investlink/src/features/splash/presentation/screen/splash_flow.dart';
import 'package:investlink/src/features/stock/presentation/screens/stock_flow.dart';
import 'package:investlink/src/features/stock_details/presentation/screens/stock_details_flow.dart';
import 'package:investlink/src/features/stock_search/domain/entities/tickers_entity.dart';
import 'package:investlink/src/features/stock_search/presentation/screens/stock_search_flow.dart';

part 'routes.g.dart';

@TypedGoRoute<SplashRoute>(path: SplashFlow.routePath, name: SplashFlow.routeName)
class SplashRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) => const SplashFlow();
}

@TypedGoRoute<AuthRoute>(path: AuthFlow.routePath, name: AuthFlow.routeName)
class AuthRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) => const AuthFlow();
}

@TypedGoRoute<StockSearchRoute>(
  path: StockSearchFlow.routePath,
  name: StockSearchFlow.routeName,
)
class StockSearchRoute extends GoRouteData {
  @override
  RightTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) =>
      RightTransitionPage<void>(
        key: state.pageKey,
        transitionDuration: const Duration(milliseconds: 200),
        child: const StockSearchFlow(),
      );
}

@TypedGoRoute<StockRoute>(path: StockFlow.routePath, name: StockFlow.routeName)
class StockRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) => const StockFlow();
}

@TypedGoRoute<PincodeRoute>(path: PincodeFlow.routePath, name: PincodeFlow.routeName)
class PincodeRoute extends GoRouteData {
  const PincodeRoute(this.$extra);

  final bool? $extra;
  @override
  Widget build(BuildContext context, GoRouterState state) => PincodeFlow(
        isPincodeCreationRequired: $extra ?? false,
      );
}

@TypedGoRoute<StockDetailsRoute>(path: StockDetailsFlow.routePath, name: StockDetailsFlow.routeName)
class StockDetailsRoute extends GoRouteData {
  const StockDetailsRoute(this.$extra);

  final TickersEntity? $extra;
  @override
  Widget build(BuildContext context, GoRouterState state) => StockDetailsFlow(
        tickersEntity: $extra!,
      );
}
