import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:investlink/src/features/auth/presentation/screens/auth_flow.dart';
import 'package:investlink/src/features/splash/screens/splash_screen.dart';

part 'routes.g.dart';

@TypedGoRoute<InitialRoute>(path: '/', name: 'initial')
class InitialRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) => const SplashScreen();
}

@TypedGoRoute<AuthRoute>(path: AuthFlow.routePath, name: AuthFlow.routeName)
class AuthRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) => const AuthFlow();
}
