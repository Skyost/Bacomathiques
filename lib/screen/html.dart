import 'dart:convert';

import 'package:bacomathiques/app/api/common.dart';
import 'package:bacomathiques/app/api/content.dart';
import 'package:bacomathiques/main.dart';
import 'package:bacomathiques/utils/server.dart';
import 'package:bacomathiques/utils/utils.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// A screen that is able to display some HTML content.
class HTMLPage extends StatefulWidget {
  /// The endpoint to display.
  final APIEndpoint<APIEndpointResultHTML> _endpoint;

  /// The current anchor.
  final String _anchor;

  /// Creates a new HTML screen instance.
  HTMLPage(this._endpoint, this._anchor);

  @override
  State<StatefulWidget> createState() => HTMLPageState(_endpoint);
}

/// State of HTML screens.
class HTMLPageState extends RequestScaffold<HTMLPage, APIEndpointResultHTML> {
  /// The banner ad.
  BannerAd _ad;

  /// Creates a new HTML screen state instance.
  HTMLPageState(
    APIEndpoint<APIEndpointResultHTML> endpoint,
  ) : super(
          endpoint: endpoint,
          failMessage: 'Impossible de charger ce contenu et aucune sauvegarde n\'est disponible.',
        );

  @override
  void initState() {
    super.initState();

    if (adMob.isEnabled()) {
      BannerAd ad = adMob.createBannerAd();
      ad.load().then((loaded) => _showBanner(ad, loaded));
    }
  }

  @override
  Widget createBody(BuildContext context) {
    List<JavascriptChannel> channels = [
      JavascriptChannel(
        name: 'Navigation',
        onMessageReceived: (message) {
          Map<String, dynamic> object = json.decode(message.message);
          Navigator.pushReplacementNamed(
            context,
            '/html',
            arguments: {
              'endpoint': LessonContentEndpoint.fromLevelAndLesson(
                level: object['level'],
                lesson: object['lesson'],
              ),
              'anchor': object['hash'],
            },
          );
        },
      )
    ];

    return WebView(
      initialUrl: 'http://localhost:$LOCAL_SERVER_PORT/assets/webview/content.html',
      javascriptMode: JavascriptMode.unrestricted,
      javascriptChannels: channels.toSet(),
      navigationDelegate: (navigation) {
        if (navigation.url.startsWith('http') && !navigation.url.startsWith('http://localhost:$LOCAL_SERVER_PORT/')) {
          openURL(navigation.url);
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    );
  }

  @override
  void deactivate() {
    _disposeAd();
    super.deactivate();
  }

  /// Disposes the ad.
  Future<void> _disposeAd() async {
    try {
      if (_ad != null) {
        await _ad.dispose();
      }
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
    }
  }

  @override
  void updateObject(APIEndpointResultHTML result) {
    localServer.formatArguments = {
      'assets/webview/content.html': [
        FormatArgument('content', result.html),
      ],
      'assets/webview/js/lesson.js': [
        FormatArgument('base_url', API.BASE_URL),
        FormatArgument('level', result.lesson.level),
        FormatArgument('lesson', result.lesson.id.replaceAll('-', '_')),
        FormatArgument('anchor', widget._anchor ?? ''),
      ],
      'assets/webview/css/lesson.css': [
        FormatArgument('margin_bottom', (adMob.isEnabled() ? 60 : 0).toString()),
      ]
    };
    super.updateObject(result);
  }

  /// Shows the ad banner.
  void _showBanner(BannerAd ad, bool loaded) {
    if (!loaded) {
      return;
    }

    _ad = ad;
    ad.show();
  }
}
