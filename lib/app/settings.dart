import 'package:bacomathiques/app/theme/theme.dart';
import 'package:bacomathiques/credentials.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Allows to load and set required AdMob information.
class SettingsModel extends ChangeNotifier {
  /// The banner ad identifier.
  String _adMobBannerId = BannerAd.testAdUnitId;

  /// The app theme mode.
  ThemeMode _themeMode = ThemeMode.system;

  /// Whether AdMob is enabled.
  bool _adMobEnabled = false;

  /// Creates a new AdMob instance.
  SettingsModel({
    String? adMobBannerId,
  }) {
    if (adMobBannerId != null) {
      _adMobBannerId = adMobBannerId;
    }
  }

  /// Loads the class data.
  Future<void> load(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _themeMode = ThemeMode.values[preferences.getInt('app.themeMode') ?? ThemeMode.system.index];
    _adMobEnabled = preferences.getBool('admob.enable') ?? true;

    if (kDebugMode || !_adMobEnabled) {
      notifyListeners();
      return;
    }

    _adMobBannerId = Credentials.adUnit;
    notifyListeners();
  }

  /// Creates the banner ad.
  BannerAd? createAdMobBanner(BuildContext context, bool nonPersonalizedAds, { Function(Ad ad)? onAdLoaded }) => _adMobEnabled
      ? BannerAd(
          adUnitId: _adMobBannerId,
          size: AdSize.getSmartBanner(MediaQuery.of(context).orientation),
          request: AdRequest(nonPersonalizedAds: nonPersonalizedAds),
          listener: AdListener(
            onAdLoaded: onAdLoaded,
            onAdFailedToLoad: (Ad ad, LoadAdError error) => ad.dispose(),
            onAdClosed: (Ad ad) => ad.dispose(),
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
  AppTheme getThemeFromBrightness(Brightness brightness) => brightness == Brightness.light ? AppTheme.LIGHT : AppTheme.DARK;
}
