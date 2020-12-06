import 'package:bacomathiques/app/settings.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// The theme mode dialog.
class ThemeModeDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SettingsModel settings = context.watch<SettingsModel>();
    return AlertDialog(
      title: _createTitleWidget(),
      content: _createContentWidget(context, settings),
      actions: [
        Wrap(
          alignment: WrapAlignment.end,
          crossAxisAlignment: WrapCrossAlignment.end,
          children: createActionsWidgets(context, Provider.of<SettingsModel>(context)),
          direction: Axis.vertical,
        ),
      ],
    );
  }

  /// Creates a new title widget.
  Widget _createTitleWidget() => const Text('Thème de l\'application');

  /// Creates a new content widget.
  Widget _createContentWidget(BuildContext context, SettingsModel settings) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => toggleSystemChoice(context, settings),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: settings.themeMode == ThemeMode.system,
                  onChanged: (value) => toggleSystemChoice(context, settings, value),
                ),
                const Text('Laisser le système décider'),
              ],
            ),
          ),
          if (settings.themeMode != ThemeMode.system)
            DayNightSwitcher(
              isDarkModeEnabled: settings.themeMode == ThemeMode.dark,
              onStateChanged: (isDarkModeEnabled) => settings.themeMode = isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
            ),
        ],
      );

  /// Creates a new dialog actions widgets.
  List<Widget> createActionsWidgets(BuildContext context, SettingsModel settingsModel) => [
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Fermer'.toUpperCase()),
          textTheme: ButtonTextTheme.accent,
        ),
      ];

  /// Toggles the system theme choice.
  void toggleSystemChoice(BuildContext context, SettingsModel settings, [bool value]) {
    if (settings.themeMode == ThemeMode.system) {
      settings.themeMode = MediaQuery.platformBrightnessOf(context) == Brightness.light ? ThemeMode.light : ThemeMode.dark;
    } else {
      settings.themeMode = ThemeMode.system;
    }
  }

  /// Shows the dialog.
  static void show(BuildContext context) => showDialog(
        context: context,
        builder: (context) => ThemeModeDialog(),
      );
}
