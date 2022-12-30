import 'package:bacomathiques/model/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A centered circular progress indicator.
class CenteredCircularProgressIndicator extends ConsumerWidget {
  /// The message to show.
  final String? message;

  /// Creates a new centered circular progress indicator instance.
  const CenteredCircularProgressIndicator({
    this.message,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget progressIndicator = CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(ref.watch(settingsModelProvider).resolveTheme(context).progressIndicatorColor),
    );

    return Center(
      child: message == null
          ? progressIndicator
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: progressIndicator,
                ),
                Text(
                  message!,
                  style: const TextStyle(fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                )
              ],
            ),
    );
  }
}
