import 'dart:async';

import 'package:bacomathiques/widgets/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The settings provider.
final settingsModelProvider = AsyncNotifierProvider<SettingsController, AppSettings>(SettingsController.new);

/// User settings.
class AppSettings {
  /// The app theme mode.
  final ThemeMode themeMode;

  /// The comments username.
  final String commentsUsername;

  /// Creates user settings.
  const AppSettings({
    this.themeMode = ThemeMode.system,
    this.commentsUsername = 'Anonyme',
  });

  /// Creates a copy with updated values.
  AppSettings copyWith({
    ThemeMode? themeMode,
    String? commentsUsername,
  }) => AppSettings(
    themeMode: themeMode ?? this.themeMode,
    commentsUsername: commentsUsername ?? this.commentsUsername,
  );

  /// Resolves the theme from the specified context.
  AppTheme resolveTheme(BuildContext context) {
    switch (themeMode) {
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

/// Controls user settings.
class SettingsController extends AsyncNotifier<AppSettings> {
  static const _themeModeKey = 'app.themeMode';
  static const _commentsUsernameKey = 'comments.username';
  static const _legacyCommentsUsernameKey = 'app.commentsUsername';

  @override
  Future<AppSettings> build() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final themeModeIndex = preferences.getInt(_themeModeKey);
    final themeMode = themeModeIndex == null || themeModeIndex >= ThemeMode.values.length ? ThemeMode.system : ThemeMode.values[themeModeIndex];
    final commentsUsername = preferences.getString(_commentsUsernameKey) ?? preferences.getString(_legacyCommentsUsernameKey) ?? 'Anonyme';
    return AppSettings(
      themeMode: themeMode,
      commentsUsername: commentsUsername,
    );
  }

  /// Updates the app theme mode.
  Future<void> setThemeMode(ThemeMode themeMode) async {
    state = AsyncData((await future).copyWith(themeMode: themeMode));
    await flush();
  }

  /// Updates the comments username.
  Future<void> setCommentsUsername(String commentsUsername) async {
    state = AsyncData((await future).copyWith(commentsUsername: commentsUsername));
    await flush();
  }

  /// Flushes the data to the shared preferences.
  Future<void> flush() async {
    AppSettings settings = await future;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt(_themeModeKey, settings.themeMode.index);
    await preferences.setString(_commentsUsernameKey, settings.commentsUsername);
  }
}
