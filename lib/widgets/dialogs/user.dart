import 'package:bacomathiques/model/settings.dart';
import 'package:bacomathiques/widgets/dialogs/app_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The user dialog.
class UserDialog extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserDialogState();

  /// Shows the dialog.
  static void show(BuildContext context) => showDialog(
        context: context,
        builder: (context) => UserDialog(),
      );
}

/// The user dialog state.
class _UserDialogState extends ConsumerState<UserDialog> {
  /// A text editing controller.
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: ref.read(settingsModelProvider).commentsUsername);
  }

  @override
  Widget build(BuildContext context) => AppAlertDialog.oneChild(
        title: 'Utilisateur',
        actions: [
          AppAlertDialogOkButton(
            onPressed: () async {
              SettingsModel settingsModel = ref.read(settingsModelProvider);
              settingsModel.commentsUsername = controller.text;
              await settingsModel.flush();
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
}
