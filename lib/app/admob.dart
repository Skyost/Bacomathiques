import 'dart:convert';
import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Allows to load and set required AdMob information.
class AdMob {
  /// The AdMob preference key.
  static const String _PREFERENCE_KEY = 'ads';

  /// The AdMob app identifier.
  String appId;

  /// The banner ad identifier.
  String adId;

  /// Whether AdMob is enabled.
  bool _isEnabled = true;

  /// Creates a new AdMob instance.
  AdMob([this.appId = 'ca-app-pub-7167241518798106~9455148387', this.adId = 'ca-app-pub-3940256099942544/6300978111']);

  /// Loads the class data.
  Future<void> load() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool isEnabled = preferences.getBool(_PREFERENCE_KEY);
    if (isEnabled != null) {
      _isEnabled = isEnabled;
    }

    if (!_isEnabled) {
      return;
    }

    try {
      Map<String, dynamic> data = json.decode(await rootBundle.loadString('assets/admob.json', cache: false));
      String key = Platform.isAndroid ? 'android' : 'ios';
      Map<String, dynamic> platformData = data[key];

      if(platformData['appId'] != null) {
        appId = platformData['appId'];
      }
      if(platformData['bannerId'] != null) {
        adId = platformData['bannerId'];
      }
    } catch (ignored) {}

    FirebaseAdMob.instance.initialize(appId: appId);
  }

  /// Creates the banner ad.
  BannerAd createBannerAd() => BannerAd(
        adUnitId: adId,
        size: AdSize.smartBanner,
      );

  /// Returns whether AdMob should be enabled.
  bool isEnabled() => _isEnabled;

  /// Sets whether AdMob should be enabled.
  void setEnabled(isEnabled) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(_PREFERENCE_KEY, isEnabled);
    _isEnabled = isEnabled;
  }
}
