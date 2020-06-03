import 'dart:convert';
import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:bacomathiques/app/app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Allows to load and set required AdMob information.
class SettingsModel extends ChangeNotifier {
  /// The banner ad identifier.
  String _adMobBannerId;

  /// The app theme.
  final AppTheme appTheme = AppTheme();

  /// Whether AdMob is enabled.
  bool _adMobEnabled = false;

  /// Whether the app is in dark mode.
  bool _darkModeEnabled = false;

  /// Creates a new AdMob instance.
  SettingsModel({
    String adMobBannerId = 'ca-app-pub-3940256099942544/6300978111',
  }) : _adMobBannerId = adMobBannerId;

  /// Loads the class data.
  Future<void> load(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _adMobEnabled = preferences.getBool('admob.enable') ?? true;
    _darkModeEnabled = preferences.getBool('app.dark-mode') ?? false;
    appTheme.load(!_darkModeEnabled);

    if (kDebugMode || !_adMobEnabled) {
      notifyListeners();
      return;
    }

    try {
      _adMobBannerId = jsonDecode(await rootBundle.loadString('assets/admob.json'))[Platform.isAndroid ? 'android' : 'ios'];
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
    }

    notifyListeners();
  }

  /// Creates the banner ad.
  AdmobBanner createAdMobBanner(BuildContext context) => !_adMobEnabled || _adMobBannerId == null
      ? null
      : AdmobBanner(
          adUnitId: _adMobBannerId,
          adSize: _getAdMobBannerSize(context),
        );

  /// Calculates the banner size.
  Future<Size> calculateAdMobBannerSize(BuildContext context) => !adMobEnabled || _adMobBannerId == null ? Future<Size>.value(Size.zero) : Admob.bannerSize(_getAdMobBannerSize(context));

  /// Returns the AdMob banner size.
  AdmobBannerSize _getAdMobBannerSize(BuildContext context) => AdmobBannerSize.ADAPTIVE_BANNER(width: MediaQuery.of(context).size.width.ceil());

  /// Returns whether AdMob should be enabled.
  bool get adMobEnabled => _adMobEnabled;

  /// Sets whether AdMob should be enabled.
  set adMobEnabled(isEnabled) {
    _adMobEnabled = isEnabled;
    notifyListeners();
  }

  /// Returns whether the dark mode is enabled.
  bool get darkModeEnabled => _darkModeEnabled;

  /// Enables or disables the dark mode.
  set darkModeEnabled(bool isDarkMode) {
    _darkModeEnabled = isDarkMode;
    appTheme.load(!isDarkMode);
    notifyListeners();
  }

  /// Flushes the data to the shared preferences.
  Future<void> flush() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('admob.enable', _adMobEnabled);
    await preferences.setBool('app.dark-mode', _darkModeEnabled);
  }
}
