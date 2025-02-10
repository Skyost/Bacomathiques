import 'package:bacomathiques/widgets/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The settings model provider.
final settingsModelProvider = ChangeNotifierProvider((ref) {
  SettingsModel settingsModel = SettingsModel();
  settingsModel.load();
  return settingsModel;
});

/// Allows to load user preferences.
class SettingsModel extends ChangeNotifier {
  /// The app theme mode.
  ThemeMode _themeMode = ThemeMode.system;

  /// The comments username.
  String _commentsUsername = 'Anonyme';

  /// Loads the class data.
  Future<void> load() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _themeMode = ThemeMode.values[preferences.getInt('app.themeMode') ?? ThemeMode.system.index];
    _commentsUsername = preferences.getString('comments.username') ?? 'Anonyme';

    notifyListeners();
  }

  /// Returns the theme mode.
  ThemeMode get themeMode => _themeMode;

  /// Sets the theme mode.
  set themeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }

  /// Returns the comments username.
  String get commentsUsername => _commentsUsername;

  /// Sets the comments username.
  set commentsUsername(String commentsUsername) {
    _commentsUsername = commentsUsername;
    notifyListeners();
  }

  /// Flushes the data to the shared preferences.
  Future<void> flush() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt('app.themeMode', _themeMode.index);
    await preferences.setString('app.commentsUsername', _commentsUsername);
  }

  /// Resolves the theme from the specified context.
  AppTheme resolveTheme(BuildContext context) {
    switch (_themeMode) {
      case ThemeMode.light:
        return getThemeFromBrightness(Brightness.light);
      case ThemeMode.dark:
        return getThemeFromBrightness(Brightness.dark);
      default:
        return getThemeFromBrightness(MediaQuery.platformBrightnessOf(context));
    }
  }

  /// Returns the theme corresponding to the specified brightness.
  AppTheme getThemeFromBrightness(Brightness brightness) => brightness == Brightness.light ? AppTheme.light : AppTheme.dark;
}
