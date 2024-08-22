import 'dart:collection';

import 'package:flutter_easy_dialogs/flutter_easy_dialogs.dart';
import 'package:investlink/src/features/snackbar_queue/presentation/snack_message_type.dart';
import 'package:investlink/src/features/snackbar_queue/presentation/top_snack_bar.dart';
import 'package:rxdart/subjects.dart';

/// The controller for displaying snacks.
/// Will be available to descendants.
abstract interface class SnackQueueController {
  /// Add Snack to Queue.
  void addSnack(
    String message, {
    required SnackMessageType messageType,
    EasyDialogDecoration? dialogDecoration,
    EasyDialogAnimationConfiguration? animationConfiguration,
  });

  /// Clears the snack queue from potential displays that were queued before [closeTime].
  void clearSnackQueue(DateTime closeTime);
}

class SnackQueueControllerImpl implements SnackQueueController {
  SnackQueueControllerImpl(this._snackStream, this._snackQueue);

  /// Queue of snacks.
  final Queue<TopSnackBar> _snackQueue;

  /// Stream with snacks.
  final BehaviorSubject<TopSnackBar> _snackStream;

  @override
  void addSnack(
    String message, {
    required SnackMessageType messageType,
    EasyDialogDecoration? dialogDecoration,
    EasyDialogAnimationConfiguration? animationConfiguration,
  }) {
    _addToQueue(
      TopSnackBar(
        message: message,
        messageType: messageType,
        dialogDecoration: dialogDecoration,
        animationConfiguration: animationConfiguration,
      ),
    );
  }

  /// Clears the snack queue from possible display, which were put in the queue before [closeTime].
  @override
  void clearSnackQueue(DateTime closeTime) {
    _snackQueue.removeWhere(
      /// Subtract a second so that snacks are displayed when the screen is closed.
      (snackData) => snackData.showTime.isBefore(closeTime.add(const Duration(seconds: -1))),
    );
  }

  void _addToQueue(TopSnackBar snack) {
    _snackStream.add(snack);
    _snackQueue.add(snack);
  }
}
