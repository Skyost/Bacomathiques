import 'dart:convert';
import 'dart:io';

import 'package:bacomathiques/app/theme/theme.dart';
import 'package:bacomathiques/credentials.dart';
import 'package:bacomathiques/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// Contains the user consent info.
class ConsentInformation {
  /// Cached consent information instance.
  static ConsentInformation? _cached;

  /// The preferences key for the "should display" parameter.
  static const String PREFERENCES_SHOULD_DISPLAY = 'consent.should-display';

  /// Whether the user wants (or no) personalized ads.
  static const String PREFERENCES_WANTS_NON_PERSONALIZED_ADS = 'consent.wants-non-personalized-ads';

  /// Whether an explicit consent should be given.
  final bool isRequestLocationInEeaOrUnknown;

  /// Whether the explicit consent has been given for personalized ads.
  final bool wantsNonPersonalizedAds;

  /// Creates a new consent information instance.
  const ConsentInformation._internal({
    this.isRequestLocationInEeaOrUnknown = true,
    this.wantsNonPersonalizedAds = true,
  });

  /// Reads the consent information from the shared preferences.
  static Future<ConsentInformation?> read() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey(PREFERENCES_SHOULD_DISPLAY) && preferences.containsKey(PREFERENCES_WANTS_NON_PERSONALIZED_ADS)) {
      _cached = ConsentInformation._internal(
        isRequestLocationInEeaOrUnknown: preferences.getBool(PREFERENCES_SHOULD_DISPLAY)!,
        wantsNonPersonalizedAds: preferences.getBool(PREFERENCES_WANTS_NON_PERSONALIZED_ADS)!,
      );
      return _cached;
    }
    return null;
  }

  /// Asks for the consent information if required.
  static Future<ConsentInformation?> ask({
    required BuildContext context,
    required String appMessage,
    required String question,
    required String privacyPolicyMessage,
    required String personalizedAdsButton,
    required String nonPersonalizedAdsButton,
  }) async {
    Uri uri = Uri.https('adservice.google.com', '/getconfig/pubvendors', {
      'pubs': Credentials.PUBLISHER_ID,
      'es': '2',
      'plat': Platform.isAndroid ? 'android' : 'ios',
      'v': '1.0.8', // Should be v1.0.5 on iOS.
      if (kDebugMode) 'debug_geo': '1'
    });
    Map<String, dynamic> data = jsonDecode(await http.read(uri));
    bool needToAsk = data['is_request_in_eea_or_unknown'] ?? false;
    bool wantsNonPersonalizedAds = needToAsk
        ? (await showDialog<bool>(
            context: context,
            builder: (context) => _PersonalizedAdsConsentDialog(
              appMessage: appMessage,
              questionMessage: question,
              privacyPolicyMessage: privacyPolicyMessage,
              personalizedAdsButton: personalizedAdsButton,
              nonPersonalizedAdsButton: nonPersonalizedAdsButton,
            ),
            barrierDismissible: false,
          ))!
        : false;

    _cached = ConsentInformation._internal(
      isRequestLocationInEeaOrUnknown: needToAsk,
      wantsNonPersonalizedAds: wantsNonPersonalizedAds,
    );
    await _cached?.write();
    return _cached;
  }

  /// Reads or asks for the consent information if required.
  static Future<ConsentInformation?> askIfNeeded({
    required BuildContext context,
    required String appMessage,
    required String question,
    required String privacyPolicyMessage,
    required String personalizedAdsButton,
    required String nonPersonalizedAdsButton,
  }) async {
    try {
      if (_cached != null) {
        return _cached!;
      }

      ConsentInformation? result = (await read()) ??
          (await ask(
            context: context,
            appMessage: appMessage,
            question: question,
            privacyPolicyMessage: privacyPolicyMessage,
            personalizedAdsButton: personalizedAdsButton,
            nonPersonalizedAdsButton: nonPersonalizedAdsButton,
          ));

      if (result != null) {
        return result;
      }
    } catch (exception, stacktrace) {
      print(exception);
      print(stacktrace);
    }
    return const ConsentInformation._internal();
  }

  /// Writes the current data to shared preferences.
  Future<void> write() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(PREFERENCES_SHOULD_DISPLAY, isRequestLocationInEeaOrUnknown);
    await preferences.setBool(PREFERENCES_WANTS_NON_PERSONALIZED_ADS, wantsNonPersonalizedAds);
  }

  /// Resets the data that was stored into shared preferences.
  static Future<void> reset() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(PREFERENCES_SHOULD_DISPLAY);
    await preferences.remove(PREFERENCES_WANTS_NON_PERSONALIZED_ADS);
  }
}

/// The personalized ads consent dialog widget.
class _PersonalizedAdsConsentDialog extends StatelessWidget {
  /// The app message.
  final String appMessage;

  /// The question message.
  final String questionMessage;

  /// The privacy policy HTML message.
  final String privacyPolicyMessage;

  /// The personalized ads button.
  final String personalizedAdsButton;

  /// The non personalized ads button.
  final String nonPersonalizedAdsButton;

  /// Creates a new personalized ads consent dialog instance.
  const _PersonalizedAdsConsentDialog({
    required this.appMessage,
    required this.questionMessage,
    required this.privacyPolicyMessage,
    required this.personalizedAdsButton,
    required this.nonPersonalizedAdsButton,
  });

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.resolveTheme();
    return WillPopScope(
      onWillPop: () => Future<bool>.value(false),
      child: AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(24),
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: _createLogo(),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _createAppMessage(),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _createQuestionMessage(),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: _createPrivacyPolicyMessage(),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: _createPersonalizedAdsButton(context, theme),
              ),
              _createNonPersonalizedAdsButton(context, theme),
            ],
          ),
        ),
      ),
    );
  }

  /// Creates the logo widget.
  Widget _createLogo() => Align(
        alignment: Alignment.center,
        child: SvgPicture.asset(
          'assets/images/logo.svg',
          semanticsLabel: 'Logo',
          width: 70,
        ),
      );

  /// Creates the app message widget.
  Widget _createAppMessage() => Text(
        appMessage,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 12),
      );

  /// Creates the question message widget.
  Widget _createQuestionMessage() => Text(
        questionMessage,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.bold),
      );

  /// Creates the privacy policy message widget.
  Widget _createPrivacyPolicyMessage() => HtmlWidget(
        '<div style="text-align: center;">$privacyPolicyMessage</div>',
        textStyle: const TextStyle(fontSize: 12),
      );

  /// Creates the personalized ads button widget.
  Widget _createPersonalizedAdsButton(BuildContext context, AppTheme theme) => SizedBox(
        width: double.infinity,
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(theme.blueButtonColor),
            overlayColor: MaterialStateProperty.all(Colors.white12),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder()),
            padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
          ),
          onPressed: () => Navigator.pop(context, false),
          child: Text(
            personalizedAdsButton,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );

  /// Creates the non personalized ads button widget.
  Widget _createNonPersonalizedAdsButton(BuildContext context, AppTheme theme) => SizedBox(
        width: double.infinity,
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(theme.blueButtonColor),
            overlayColor: MaterialStateProperty.all(Colors.white12),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder()),
            padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
          ),
          onPressed: () => Navigator.pop(context, true),
          child: Text(
            nonPersonalizedAdsButton,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
}
