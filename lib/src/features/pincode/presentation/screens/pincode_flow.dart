import 'package:flutter/material.dart';
import 'package:investlink/src/core/common/widgets/di_scope.dart';
import 'package:investlink/src/features/pincode/di/pincode_scope.dart';
import 'package:investlink/src/features/pincode/presentation/screens/pincode_screen.dart';

/// {@template pincode_flow.class}
/// Entry point to feature .
/// {@endtemplate}
class PincodeFlow extends StatelessWidget {
  /// {@macro pincode_flow.class}
  const PincodeFlow({
    this.isPincodeCreationRequired = false,
    super.key,
  });

  final bool isPincodeCreationRequired;

  static const String routePath = '/pincode';
  static const String routeName = 'pincode';

  @override
  Widget build(BuildContext context) {
    return DiScope<IPincodeScope>(
      factory: (_) => PincodeScope.create(context),
      onDispose: (scope) => scope.dispose(),
      child: PincodeScreen(isPincodeCreationRequired),
    );
  }
}
