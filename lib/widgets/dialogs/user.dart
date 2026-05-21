import 'package:bacomathiques/model/settings.dart';
import 'package:bacomathiques/widgets/centered_circular_progress_indicator.dart';
import 'package:bacomathiques/widgets/dialogs/app_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The user dialog.
class UserDialog extends ConsumerStatefulWidget {
  /// Creates a user dialog.
  const UserDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserDialogState();

  /// Shows the dialog.
  static void show(BuildContext context) => showDialog(
        context: context,
    builder: (context) => const UserDialog(),
  );
}

/// The user dialog state.
class _UserDialogState extends ConsumerState<UserDialog> {
  /// A text editing controller.
  TextEditingController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ref
      .watch(settingsModelProvider)
      .when(
        data: (settings) {
          controller ??= TextEditingController(text: settings.commentsUsername);
          return AppAlertDialog.oneChild(
            title: 'Utilisateur',
            actions: [
              AppAlertDialogOkButton(
                onPressed: () async {
                  await ref.read(settingsModelProvider.notifier).setCommentsUsername(controller!.text);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
              ),
              const AppAlertDialogCloseButton(
                cancel: true,
              ),
            ],
            child: TextField(
              controller: controller,
              onSubmitted: (username) => Navigator.pop(context),
              decoration: const InputDecoration(
                hintText: 'Nom d\'utilisateur',
              ),
            ),
          );
        },
        loading: () => AppAlertDialog.oneChild(
          title: 'Utilisateur',
          child: const CenteredCircularProgressIndicator(message: 'Chargement…'),
        ),
        error: (error, stackTrace) => AppAlertDialog.oneChild(
          title: 'Utilisateur',
          child: const Text('Impossible de charger les préférences.'),
        ),
      );
}
