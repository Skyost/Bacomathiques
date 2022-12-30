import 'package:bacomathiques/widgets/app_bar/actions/action_menu.dart';
import 'package:bacomathiques/widgets/dialogs/theme_mode.dart';
import 'package:flutter/material.dart';

/// Action menu that allows to change the app theme.
class ThemeActionMenu extends ActionMenu {
  /// Creates a new "Theme" action menu.
  const ThemeActionMenu()
      : super(
          icon: Icons.nightlight_round,
          label: 'Thème de l\'application…',
        );

  @override
  void onTap(BuildContext context) => ThemeModeDialog.show(context);
}
