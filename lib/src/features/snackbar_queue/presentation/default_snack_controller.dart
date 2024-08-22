// ignore_for_file: no-equal-arguments
import 'package:flutter/material.dart';
import 'package:flutter_easy_dialogs/flutter_easy_dialogs.dart';
import 'package:investlink/src/core/assets/colors/color_scheme.dart';
import 'package:investlink/src/core/assets/text/text_extension.dart';
import 'package:investlink/src/features/snackbar_queue/presentation/snack_message_type.dart';

/// Default controller for displaying messages.
class DefaultSnackController {
  /// Create an instance [DefaultSnackController].
  const DefaultSnackController();

  /// Show the message.
  Future<void> showSnack({
    required SnackMessageType messageType,
    required String message,
    required BuildContext context,
    required EasyDialogDecoration dialogDecoration,
    required EasyDialogAnimationConfiguration animationConfiguration,
    Duration? autoHideDuration,
  }) {
    final colorScheme = AppColorScheme.of(context);
    final textScheme = AppTextTheme.of(context);
    final topPadding = MediaQuery.of(context).viewPadding.top;
    return FlutterEasyDialogs.show(
      EasyDialog.positioned(
        decoration: dialogDecoration,
        content: SizedBox(
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: switch (messageType) {
                SnackMessageType.error => colorScheme.failureRed,
                SnackMessageType.success => colorScheme.successGreen,
                SnackMessageType.warning => colorScheme.warningYellow,
              },
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, topPadding + 8, 16, 16),
              child: Text(
                message,
                style: textScheme.medium16.copyWith(
                  color: switch (messageType) {
                    SnackMessageType.error => colorScheme.background,
                    SnackMessageType.success => colorScheme.background,
                    SnackMessageType.warning => colorScheme.background,
                  },
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        autoHideDuration: autoHideDuration,
        animationConfiguration: animationConfiguration,
      ).swipe(
        direction: DismissDirection.up,
        willDismiss: () => true,
      ),
    );
  }

  /// Hide Snack.
  Future<void> hideSnack() {
    return FlutterEasyDialogs.hide(
      PositionedDialog.identifier(
        position: EasyDialogPosition.top,
      ),
      instantly: true,
    );
  }
}
