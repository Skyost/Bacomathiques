import 'package:admob_flutter/admob_flutter.dart';
import 'package:bacomathiques/app/theme/theme.dart';
import 'package:bacomathiques/credentials.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Allows to load and set required AdMob information.
class SettingsModel extends ChangeNotifier {
  /// The banner ad identifier.
  String _adMobBannerId = 'ca-app-pub-3940256099942544/6300978111';

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
  AdmobBanner? createAdMobBanner(BuildContext context, bool nonPersonalizedAds) => _adMobEnabled
      ? AdmobBanner(
          adUnitId: _adMobBannerId,
          adSize: _getAdMobBannerSize(context),
          nonPersonalizedAds: nonPersonalizedAds,
        )
      : null;

  /// Calculates the banner size.
  Future<Size> calculateAdMobBannerSize(BuildContext context) => !adMobEnabled ? Future<Size>.value(Size.zero) : Admob.bannerSize(_getAdMobBannerSize(context));

  /// Returns the AdMob banner size.
  AdmobBannerSize _getAdMobBannerSize(BuildContext context) => AdmobBannerSize.ADAPTIVE_BANNER(width: MediaQuery.of(context).size.width.ceil());

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
