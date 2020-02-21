import 'dart:convert';
import 'dart:io';

import 'package:bacomathiques/app/app.dart';
import 'package:bacomathiques/utils/utils.dart' as utils;
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Allows to load and set required AdMob information.
class SettingsModel extends ChangeNotifier {
  /// The AdMob app identifier.
  String adMobAppId;

  /// The banner ad identifier.
  String adMobBannerId;

  /// The app theme.
  final AppTheme appTheme = AppTheme();

  /// Whether AdMob is enabled.
  bool _adMobEnabled = false;

  /// Whether the app is in dark mode.
  bool _darkModeEnabled = false;

  /// Creates a new AdMob instance.
  SettingsModel({
    this.adMobAppId = 'ca-app-pub-7167241518798106~9455148387',
    this.adMobBannerId = 'ca-app-pub-3940256099942544/6300978111',
  });

  /// Loads the class data.
  Future<void> load(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _adMobEnabled = preferences.getBool('admob.enable') ?? true;
    _darkModeEnabled = preferences.getBool('app.dark-mode') ?? false;
    appTheme.load(!_darkModeEnabled);

    if (utils.isInDebugMode || !_adMobEnabled) {
      notifyListeners();
      return;
    }

    try {
      Map<String, dynamic> data = json.decode(await rootBundle.loadString('assets/admob.json', cache: false));
      String key = Platform.isAndroid ? 'android' : 'ios';
      Map<String, dynamic> platformData = data[key];

      if (platformData['appId'] != null) {
        adMobAppId = platformData['appId'];
      }
      if (platformData['bannerId'] != null) {
        adMobBannerId = platformData['bannerId'];
      }
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
    }

    await FirebaseAdMob.instance.initialize(appId: adMobAppId);
    notifyListeners();
  }

  /// Creates the banner ad.
  BannerAd createBannerAd() => BannerAd(
        adUnitId: adMobBannerId,
        size: AdSize.smartBanner,
      );

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
