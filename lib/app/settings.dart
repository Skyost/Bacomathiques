import 'package:bacomathiques/app/api/common.dart';
import 'package:bacomathiques/app/theme/theme.dart';
import 'package:bacomathiques/credentials.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The settings model provider.
final settingsModelProvider = ChangeNotifierProvider((ref) {
  SettingsModel settingsModel = SettingsModel();
  settingsModel.load();
  return settingsModel;
});

/// Allows to load and set required AdMob information.
class SettingsModel extends ChangeNotifier {
  /// The banner ad identifier.
  String _adMobBannerId = 'ca-app-pub-3940256099942544/6300978111';

  /// The app theme mode.
  ThemeMode _themeMode = ThemeMode.system;

  /// Whether AdMob is enabled.
  bool _adMobEnabled = false;

  /// Loads the class data.
  Future<void> load() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _themeMode = ThemeMode.values[preferences.getInt('app.themeMode') ?? ThemeMode.system.index];
    _adMobEnabled = preferences.getBool('admob.enable') ?? true;

    if (!kDebugMode && _adMobEnabled) {
      _adMobBannerId = Credentials.adUnit;
    }

    notifyListeners();
  }

  /// Creates the banner ad.
  BannerAd? createAdMobBanner(
    BuildContext context, {
    AdSize? size,
    bool? nonPersonalizedAds,
  }) =>
      _adMobEnabled && (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS)
          ? BannerAd(
              adUnitId: _adMobBannerId,
              size: size ?? AdSize.banner,
              request: AdRequest(
                keywords: ['math', 'cours', 'leçons'],
                contentUrl: API.baseUrl,
                nonPersonalizedAds: nonPersonalizedAds,
              ),
              listener: BannerAdListener(
                onAdFailedToLoad: (ad, error) {
                  ad.dispose();
                  if (kDebugMode) {
                    print(error);
                  }
                },
              ),
            )
          : null;

  /// Returns the theme mode.
  ThemeMode get themeMode => _themeMode;

  /// Sets the theme mode.
  set themeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }

  /// Returns whether AdMob should be enabled.
  bool get adMobEnabled => _adMobEnabled;

  /// Sets whether AdMob should be enabled.
  set adMobEnabled(bool isEnabled) {
    _adMobEnabled = isEnabled;
    notifyListeners();
  }

  /// Flushes the data to the shared preferences.
  Future<void> flush() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('admob.enable', _adMobEnabled);
    await preferences.setInt('app.themeMode', _themeMode.index);
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
