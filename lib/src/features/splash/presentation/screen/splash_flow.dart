import 'package:flutter/material.dart';
import 'package:investlink/src/core/common/widgets/di_scope.dart';
import 'package:investlink/src/features/splash/di/splash_scope.dart';
import 'package:investlink/src/features/splash/presentation/screen/splash_screen.dart';

class SplashFlow extends StatelessWidget {
  const SplashFlow({
    super.key,
  });

  static const String routePath = '/';
  static const String routeName = 'splash';

  @override
  Widget build(BuildContext context) {
    return DiScope<ISplashScope>(
      factory: (_) => SplashScope.create(context),
      onDispose: (scope) => scope.dispose(),
      child: const SplashScreen(),
    );
  }
}
