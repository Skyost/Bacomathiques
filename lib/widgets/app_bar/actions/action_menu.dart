import 'package:bacomathiques/widgets/settings_loader.dart';
import 'package:bacomathiques/widgets/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// An action menu with text, icon and callback.
class ActionMenu {
  /// The menu icon.
  final IconData icon;

  /// The menu label.
  final String label;

  /// Creates a new action menu.
  const ActionMenu({
    required this.icon,
    required this.label,
  });

  /// Triggered when tapped on.
  void onTap(BuildContext context) {}
}

/// Allows to display action menus in a popup menu.
class PopupActionMenu extends ConsumerWidget {
  /// The actions menu.
  final List<ActionMenu> actionMenus;

  /// Creates a new popup action menu instance.
  const PopupActionMenu({
    super.key,
    required this.actionMenus,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (actionMenus.isEmpty) {
      return const SizedBox.shrink();
    }

    return SettingsLoader(
      builder: (context, settings) {
        AppTheme theme = settings.resolveTheme(context);
        return PopupMenuButton<ActionMenu>(
          color: theme.scaffoldBackgroundColor,
          // onSelected: (action) => action.onTap(context),
          itemBuilder: (context) =>
          [
            for (ActionMenu actionMenu in actionMenus)
              PopupMenuItem<ActionMenu>(
                value: actionMenu,
                onTap: () {
                  WidgetsBinding.instance.addPostFrameCallback((_) => actionMenu.onTap(context));
                },
                child: _ActionMenuWidget(actionMenu: actionMenu),
              )
          ],
        );
      },
    );
  }
}

/// Allows to draw an [ActionMenu].
class _ActionMenuWidget extends ConsumerWidget {
  /// The action menu.
  final ActionMenu actionMenu;

  /// Creates a new action menu widget instance.
  const _ActionMenuWidget({
    required this.actionMenu,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SettingsLoader(
      builder: (context, settings) {
        AppTheme appTheme = settings.resolveTheme(context);
        return Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 5,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Icon(
                actionMenu.icon,
                color: appTheme.textColor ?? Colors.black,
              ),
            ),
            Text(
              actionMenu.label,
              style: TextStyle(color: appTheme.textColor),
            ),
          ],
        );
      },
    );
  }
}
