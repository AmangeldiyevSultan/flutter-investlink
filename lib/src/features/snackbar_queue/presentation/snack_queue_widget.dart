import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:investlink/src/features/snackbar_queue/presentation/default_snack_controller.dart';
import 'package:investlink/src/features/snackbar_queue/presentation/snack_message_type.dart';
import 'package:investlink/src/features/snackbar_queue/presentation/snack_queue_controller.dart';
import 'package:investlink/src/features/snackbar_queue/presentation/top_snack_bar.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

/// We display a success snack for 4 seconds.
/// We display an error snack indefinitely until the user leaves the screen where the snack is displayed.
/// Any snack can be hidden by swiping up.
const _topSnackDuration = Duration(milliseconds: 3000);

/// {@template snack_queue_widget.class}
/// SnackQueueWidget.
/// {@endtemplate}
class SnackQueueWidget extends StatefulWidget {
  /// {@macro snack_queue_widget.class}
  const SnackQueueWidget({
    required this.child,
    required this.snackController,
    required this.router,
    super.key,
  });

  /// Child.
  final Widget child;
  final DefaultSnackController snackController;
  final GoRouter router;

  @override
  State<SnackQueueWidget> createState() => _SnackQueueWidgetState();
}

class _SnackQueueWidgetState extends State<SnackQueueWidget> {
  /// Controller for displaying dialogs.
  late final DefaultSnackController _snackController;

  /// Queue of snacks.
  final _snackQueue = Queue<TopSnackBar>();

  /// Stream with snacks.
  late final BehaviorSubject<TopSnackBar> _snackStream;

  final _currentRouterSubject = BehaviorSubject<String>();
  late final StreamSubscription<List<String>> _currentRouterSubscription;

  /// Controller for displaying dialogs.
  Completer<void>? _completer;

  late final GoRouter _router;

  bool _hasOpenedSnack = false;

  @override
  void initState() {
    super.initState();
    _snackController = widget.snackController;
    _router = widget.router;
    _router.routeInformationProvider.addListener(_listenRouter);
    _currentRouterSubscription = _currentRouterSubject.pairwise().listen(_currentRouterListener);
    _snackStream = BehaviorSubject<TopSnackBar>()
      // ignore: no-empty-block
      ..stream.asyncMap(_showSnackBarDelayed).listen((_) {});
  }

  @override
  void dispose() {
    super.dispose();
    _router.routeInformationProvider.removeListener(_listenRouter);
    unawaited(_currentRouterSubscription.cancel());
    unawaited(_currentRouterSubject.close());
    unawaited(_snackStream.close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<SnackQueueController>.value(
      value: SnackQueueControllerImpl(_snackStream, _snackQueue),
      child: widget.child,
    );
  }

  /// When the router changes, we clear the snack queue.
  void _currentRouterListener(List<String> pair) {
    final list = pair.nonNulls;
    if (list.isEmpty) return;

    final areObjectsEqual = list.every((obj) {
      final first = list.firstOrNull;
      if (first == null) return false;

      return obj == first;
    });

    if (areObjectsEqual) return;
    _clearSnackQueue();
  }

  /// Clears the snack queue.
  /// When the screen is closed, all snacks should be closed.
  void _clearSnackQueue() {
    if (_snackQueue.isEmpty) return;
    _snackQueue.clear();
    if (_hasOpenedSnack) {
      unawaited(_snackController.hideSnack());
    }
  }

  void _listenRouter() {
    _currentRouterSubject.add(_router.routerDelegate.currentConfiguration.last.matchedLocation);
  }

  Future<void> _showSnackBarDelayed(TopSnackBar snack) async {
    await _completer?.future;

    if (_snackQueue.isEmpty || _snackQueue.firstOrNull != snack) return;

    _completer = Completer()
      ..complete(
        Future.any<void>([
          _showTopSnack(snack),
        ]).whenComplete(() {
          _hasOpenedSnack = false;
          if (_snackQueue.isNotEmpty) {
            final _ = _updateSnackQueue();
          }
        }),
      );
  }

  /// Removes the displayed snack from the snack queue.
  TopSnackBar _updateSnackQueue() {
    return _snackQueue.removeFirst();
  }

  /// Calls the controller to show a snack.
  Future<void> _showTopSnack(TopSnackBar snackBar) async {
    _hasOpenedSnack = true;

    /// If the snack is an error, then we do not hide it automatically.
    final autoHideDuration =
        snackBar.messageType == SnackMessageType.error ? null : _topSnackDuration;
    await _snackController.showSnack(
      messageType: snackBar.messageType,
      message: snackBar.message,
      dialogDecoration: snackBar.dialogDecoration,
      animationConfiguration: snackBar.animationConfiguration,
      autoHideDuration: autoHideDuration,
      context: context,
    );
  }
}
