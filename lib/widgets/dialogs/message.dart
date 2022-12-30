import 'package:bacomathiques/widgets/dialogs/app_alert_dialog.dart';
import 'package:flutter/material.dart';

/// A simple message dialog.
class MessageDialog extends StatelessWidget {
  /// The title.
  final String title;

  /// The message to show.
  final String message;

  /// Action to run when the ok button has been pressed.
  final VoidCallback? okButtonPressed;

  /// Creates a new message dialog instance.
  const MessageDialog({
    required this.title,
    required this.message,
    this.okButtonPressed,
  });

  @override
  Widget build(BuildContext context) => AppAlertDialog.oneChild(
        title: title,
        actions: [
          AppAlertDialogOkButton(
            onPressed: okButtonPressed ?? () => Navigator.pop(context),
          ),
        ],
        child: Text(message),
      );

  /// Shows the dialog.
  static Future<void> show(
    BuildContext context, {
    required String title,
    required String message,
    VoidCallback? okButtonPressed,
    VoidCallback? onCancelled,
  }) async {
    await showDialog(
      context: context,
      builder: (context) => MessageDialog(
        title: title,
        message: message,
        okButtonPressed: okButtonPressed,
      ),
      barrierDismissible: false,
    );
    if (onCancelled != null) {
      onCancelled();
    }
  }
}
