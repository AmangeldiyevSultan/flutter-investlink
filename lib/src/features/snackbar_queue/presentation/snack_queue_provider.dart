import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:investlink/src/features/snackbar_queue/presentation/default_snack_controller.dart';
import 'package:investlink/src/features/snackbar_queue/presentation/snack_queue_controller.dart';
import 'package:investlink/src/features/snackbar_queue/presentation/snack_queue_widget.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

/// {@template snack_queue_provider.class}
/// Provides [SnackQueueController] to its descendants.
/// {@endtemplate}
class SnackQueueProvider extends SingleChildStatelessWidget {
  /// {@macro snack_queue_provider.class}
  const SnackQueueProvider({required this.router, super.key});

  final GoRouter router;

  /// Get the [SnackQueueController] from the [BuildContext].
  // ignore: prefer-widget-private-members
  static SnackQueueController of(BuildContext context) =>
      Provider.of<SnackQueueController>(context, listen: false);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SnackQueueWidget(
      snackController: const DefaultSnackController(),
      router: router,
      child: child ?? const SizedBox.shrink(),
    );
  }
}
