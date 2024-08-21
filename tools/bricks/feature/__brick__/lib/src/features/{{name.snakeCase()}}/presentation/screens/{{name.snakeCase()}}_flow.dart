import 'package:flutter/material.dart';
import 'package:investlink/src/core/common/widgets/di_scope.dart';
import 'package:investlink/src/features/{{{path}}}/di/{{name.snakeCase()}}_scope.dart';
import 'package:investlink/src/features/{{{path}}}/presentation/screens/{{name.snakeCase()}}_screen.dart';

/// {@template {{name.snakeCase()}}_flow.class}
/// Entry point to feature {{name.PascalCase()}}.
/// {@endtemplate}
class {{name.pascalCase()}}Flow extends StatelessWidget {
  /// {@macro {{name.snakeCase()}}_flow.class}
  const {{name.pascalCase()}}Flow({super.key});

  static const String routePath = '/{{name.camelCase()}}';
  static const String routeName = '{{name.camelCase()}}';

  @override
  Widget build(BuildContext context) {
    return DiScope<I{{name.pascalCase()}}Scope>(
      factory: (_) => {{name.pascalCase()}}Scope.create(context),
      onDispose: (scope) => scope.dispose(),
      child: const {{name.pascalCase()}}Screen(),
    );
  }
}
