import 'package:bacomathiques/model/settings.dart';
import 'package:bacomathiques/widgets/centered_circular_progress_indicator.dart';
import 'package:bacomathiques/widgets/dialogs/app_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The theme mode dialog.
class ThemeModeDialog extends ConsumerWidget {
  /// Creates a theme mode dialog.
  const ThemeModeDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(settingsModelProvider)
        .when(
          data: (settingsModel) => AppAlertDialog(
            title: 'Thème de l\'application',
            actions: const [
              AppAlertDialogCloseButton(),
            ],
            children: [
              InkWell(
                onTap: () => toggleSystemChoice(context, ref, settingsModel),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: settingsModel.themeMode == ThemeMode.system,
                      onChanged: (value) => toggleSystemChoice(context, ref, settingsModel, value!),
                    ),
                    const Text('Laisser le système décider'),
                  ],
                ),
              ),
              if (settingsModel.themeMode != ThemeMode.system)
                LayoutBuilder(
                  builder: (context, constraints) => DropdownMenu<ThemeMode>(
                    width: constraints.maxWidth,
                    initialSelection: settingsModel.themeMode,
                    onSelected: (theme) => theme == null ? null : setThemeMode(ref, theme),
                    dropdownMenuEntries: const [
                      DropdownMenuEntry<ThemeMode>(
                        value: ThemeMode.dark,
                        label: 'Sombre',
                      ),
                      DropdownMenuEntry<ThemeMode>(
                        value: ThemeMode.light,
                        label: 'Clair',
                      ),
                    ],
                  ),
                ),
            ],
          ),
          loading: () => AppAlertDialog.oneChild(
            title: 'Thème de l\'application',
            child: const CenteredCircularProgressIndicator(message: 'Chargement…'),
          ),
          error: (error, stackTrace) => AppAlertDialog.oneChild(
            title: 'Thème de l\'application',
            child: const Text('Impossible de charger les préférences.'),
          ),
        );
  }

  /// Toggles the system theme choice.
  void toggleSystemChoice(BuildContext context, WidgetRef ref, AppSettings settings, [bool? value]) {
    if (settings.themeMode == ThemeMode.system) {
      setThemeMode(ref, MediaQuery.platformBrightnessOf(context) == Brightness.light ? ThemeMode.light : ThemeMode.dark);
    } else {
      setThemeMode(ref, ThemeMode.system);
    }
  }

  /// Changes the theme mode.
  void setThemeMode(WidgetRef ref, ThemeMode themeMode) {
    ref.read(settingsModelProvider.notifier).setThemeMode(themeMode);
  }

  /// Shows the dialog.
  static void show(BuildContext context) => showDialog(
        context: context,
    builder: (context) => const ThemeModeDialog(),
  );
}
