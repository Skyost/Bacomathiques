import 'package:bacomathiques/model/settings.dart';
import 'package:bacomathiques/widgets/dialogs/app_alert_dialog.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The theme mode dialog.
class ThemeModeDialog extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SettingsModel settingsModel = ref.watch(settingsModelProvider);
    return AppAlertDialog(
      title: 'Thème de l\'application',
      actions: const [
        AppAlertDialogCloseButton(),
      ],
      children: [
        InkWell(
          onTap: () => toggleSystemChoice(context, settingsModel),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: settingsModel.themeMode == ThemeMode.system,
                onChanged: (value) => toggleSystemChoice(context, settingsModel, value!),
              ),
              const Text('Laisser le système décider'),
            ],
          ),
        ),
        if (settingsModel.themeMode != ThemeMode.system)
          DayNightSwitcher(
            isDarkModeEnabled: settingsModel.themeMode == ThemeMode.dark,
            onStateChanged: (isDarkModeEnabled) => setThemeMode(settingsModel, isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light),
          ),
      ],
    );
  }

  /// Toggles the system theme choice.
  void toggleSystemChoice(BuildContext context, SettingsModel settings, [bool? value]) {
    if (settings.themeMode == ThemeMode.system) {
      setThemeMode(settings, MediaQuery.platformBrightnessOf(context) == Brightness.light ? ThemeMode.light : ThemeMode.dark);
    } else {
      setThemeMode(settings, ThemeMode.system);
    }
  }

  /// Changes the theme mode.
  void setThemeMode(SettingsModel settings, ThemeMode themeMode) {
    settings.themeMode = themeMode;
    settings.flush();
  }

  /// Shows the dialog.
  static void show(BuildContext context) => showDialog(
        context: context,
        builder: (context) => ThemeModeDialog(),
      );
}
