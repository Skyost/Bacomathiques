import 'package:bacomathiques/widgets/app_bar/actions/action_menu.dart';
import 'package:bacomathiques/widgets/dialogs/about.dart';
import 'package:flutter/material.dart' hide AboutDialog;

/// Action menu that allows to show the about dialog.
class AboutActionMenu extends ActionMenu {
  /// Creates a new "About" action menu instance.
  const AboutActionMenu()
      : super(
          icon: Icons.help,
          label: 'À propos…',
        );

  @override
  void onTap(BuildContext context) => AboutDialog.show(context);
}
