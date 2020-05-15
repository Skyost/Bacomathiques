import 'dart:convert';

import 'package:bacomathiques/app/api/common.dart';
import 'package:bacomathiques/app/api/content.dart';
import 'package:bacomathiques/app/settings.dart';
import 'package:bacomathiques/utils/server.dart';
import 'package:bacomathiques/utils/utils.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// A screen that is able to display some HTML content.
class HTMLPage extends StatefulWidget {
  /// The endpoint to display.
  final APIEndpoint<APIEndpointResultHTML> endpoint;

  /// The current anchor.
  final String anchor;

  /// Creates a new HTML screen instance.
  const HTMLPage({
    this.endpoint,
    this.anchor,
  });

  @override
  State<StatefulWidget> createState() => HTMLPageState(endpoint: endpoint);
}

/// State of HTML screens.
class HTMLPageState extends RequestScaffold<HTMLPage, APIEndpointResultHTML> {
  /// The banner ad.
  BannerAd ad;

  /// Current stack to view.
  int stackToView = 1;

  /// Creates a new HTML screen state instance.
  HTMLPageState({
    @required APIEndpoint<APIEndpointResultHTML> endpoint,
  }) : super(
          endpoint: endpoint,
          failMessage: 'Impossible de charger ce contenu et aucune sauvegarde n\'est disponible.',
        );

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SettingsModel settingsModel = Provider.of<SettingsModel>(context, listen: false);
      if (settingsModel.adMobEnabled) {
        BannerAd ad = settingsModel.createBannerAd();
        bool loaded = await ad.load();
        _showBanner(ad, loaded);
      }
    });
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

    Server server = Provider.of<Server>(context);
    return IndexedStack(
      index: stackToView,
      children: [
        SizedBox.expand(
          child: WebView(
            initialUrl: 'http://localhost:${server.port}/assets/webview/content.html',
            onPageStarted: (_) {
              setState(() => stackToView = 1);
            },
            onPageFinished: (_) {
              setState(() => stackToView = 0);
            },
            javascriptMode: JavascriptMode.unrestricted,
            javascriptChannels: channels.toSet(),
            navigationDelegate: (navigation) {
              if (navigation.url.startsWith('http') && !navigation.url.startsWith('http://localhost:${server.port}/')) {
                openURL(navigation.url);
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          ),
        ),
        Container(
          color: Provider.of<SettingsModel>(context).appTheme.themeData.scaffoldBackgroundColor,
          child: CenteredCircularProgressIndicator(),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _disposeAd();
    super.dispose();
  }

  /// Disposes the ad.
  Future<void> _disposeAd() async {
    try {
      if (ad != null) {
        await ad.dispose();
      }
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
    }
  }

  @override
  set result(APIEndpointResultHTML result) {
    if (mounted) {
      SettingsModel settingsModel = Provider.of<SettingsModel>(context, listen: false);
      Server server = Provider.of<Server>(context, listen: false);

      server.formatArguments = {
        'assets/webview/content.html': [
          FormatArgument('content', result.html),
          FormatArgument('dark_theme_css', settingsModel.darkModeEnabled ? '<link rel="stylesheet" href="http://localhost:8080/assets/webview/css/dark.css">' : ''),
          FormatArgument('dark_theme_js', settingsModel.darkModeEnabled ? '<script src="http://localhost:8080/assets/webview/js/dark.js"></script>' : ''),
        ],
        'assets/webview/js/lesson.js': [
          FormatArgument('base_url', API.BASE_URL),
          FormatArgument('level', result.lesson.level),
          FormatArgument('lesson', result.lesson.id.replaceAll('-', '_')),
          FormatArgument('anchor', widget.anchor ?? ''),
        ],
        'assets/webview/css/lesson.css': [
          FormatArgument('margin_bottom', (settingsModel.adMobEnabled ? 60 : 0).toString()),
        ],
      };
    }
    super.result = result;
  }

  /// Shows the ad banner.
  void _showBanner(BannerAd ad, bool loaded) {
    if (!loaded || !mounted) {
      return;
    }

    this.ad = ad;
    this.ad.show();
  }
}
