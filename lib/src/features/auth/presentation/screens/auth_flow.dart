import 'package:flutter/widgets.dart';
import 'package:investlink/src/core/common/widgets/di_scope.dart';
import 'package:investlink/src/features/auth/di/auth_scope.dart';
import 'package:investlink/src/features/auth/presentation/screens/auth_screen.dart';

class AuthFlow extends StatelessWidget {
  const AuthFlow({
    super.key,
  });

  static const String routePath = '/auth';
  static const String routeName = 'auth';

  @override
  Widget build(BuildContext context) {
    return DiScope<IAuthScope>(
      factory: (_) => AuthScope.create(context),
      onDispose: (scope) => scope.dispose(),
      child: const AuthScreen(),
    );
  }
}
