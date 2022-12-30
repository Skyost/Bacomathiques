import 'dart:io';
import 'dart:math' as math;
import 'package:bacomathiques/model/settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// The app store page.
final String storePage = Platform.isAndroid ? 'https://play.google.com/store/apps/details?id=fr.bacomathiques' : 'http://itunes.apple.com/app/id1458503418';

/// Shows a transparent image.
Uint8List kTransparentImage = Uint8List.fromList(const [
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
]);

/// Opens an URL with the default browser.
Future<void> openUrl(String url) async {
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url);
  }
}

/// Returns whether the current screen is a tablet.
bool isTablet(Size screenSize) {
  double diagonal = math.sqrt(math.pow(screenSize.width, 2) + math.pow(screenSize.height, 2));
  return diagonal > 1100 || screenSize.shortestSide >= 600;
}

/// Returns the platform name.
String get platformName {
  if (kIsWeb) {
    return 'web';
  }
  switch(defaultTargetPlatform) {
    case TargetPlatform.android:
      return 'Android';
    case TargetPlatform.fuchsia:
      return 'Fuschia';
    case TargetPlatform.iOS:
      return 'iOS';
    case TargetPlatform.linux:
      return 'Linux';
    case TargetPlatform.macOS:
      return 'macOS';
    case TargetPlatform.windows:
      return 'Windows';
  }
}

/// Contains some useful methods for doubles.
extension DoubleUtils on double {
  /// Does a linear interpolation of two doubles, this one and another.
  double lerp(double? other, double t) {
    other ??= 0.0;
    return this + (other - this) * t;
  }
}

/// Contains some useful methods for integers.
extension IntUtils on int {
  /// The numerals.
  static const Map<String, int> _numerals = {
    'M': 1000,
    'CM': 900,
    'D': 500,
    'CD': 400,
    'C': 100,
    'XC': 90,
    'L': 50,
    'XL': 40,
    'X': 10,
    'IX': 9,
    'V': 5,
    'IV': 4,
    'I': 1,
  };

  /// Returns the roman writing of this integer.
  String romanize() {
    int number = this;
    String result = '';
    _numerals.forEach((key, value) {
      int quotient = (number / value).floor();
      number -= quotient * value;
      result += _repeatString(key, quotient);
    });
    return result;
  }

  /// Repeats the given string n times.
  String _repeatString(String input, int n) {
    String result = '';
    while (n-- > 0) {
      result += input;
    }
    return result;
  }
}

/// Contains some useful methods for colors.
extension ColorUtils on Color {
  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
