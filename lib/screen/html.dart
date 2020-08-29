import 'dart:convert';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:bacomathiques/app/api/common.dart';
import 'package:bacomathiques/app/api/content.dart';
import 'package:bacomathiques/app/settings.dart';
import 'package:bacomathiques/utils/server.dart';
import 'package:bacomathiques/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Allows to display the html content with an AdMob banner.
class AdMobHTMLPage extends StatelessWidget {
  /// The endpoint to display.
  final APIEndpoint<APIEndpointResultHTML> endpoint;

  /// The current anchor.
  final String anchor;

  /// Creates a new AdMob HTML screen instance.
  const AdMobHTMLPage({
    @required this.endpoint,
    this.anchor,
  });

  @override
  Widget build(BuildContext context) {
    SettingsModel settingsModel = Provider.of<SettingsModel>(context);
    Widget htmlPage = _HTMLPage(
      endpoint: endpoint,
      anchor: anchor,
    );
    AdmobBanner banner = settingsModel.createAdMobBanner(context);
    if (banner == null) {
      return htmlPage;
    }

    return FutureBuilder<Size>(
      initialData: Size.zero,
      future: settingsModel.calculateAdMobBannerSize(context),
      builder: (context, sizeSnapshot) => Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: sizeSnapshot.data.height),
            child: htmlPage,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: banner,
          ),
        ],
      ),
    );
  }
}

/// A screen that is able to display some HTML content.
class _HTMLPage extends StatefulWidget {
  /// The endpoint to display.
  final APIEndpoint<APIEndpointResultHTML> endpoint;

  /// The current anchor.
  final String anchor;

  /// Creates a new HTML screen instance.
  const _HTMLPage({
    @required this.endpoint,
    this.anchor,
  });

  @override
  State<StatefulWidget> createState() => HTMLPageState(endpoint: endpoint);
}

/// State of HTML screens.
class HTMLPageState extends RequestScaffold<_HTMLPage, APIEndpointResultHTML> {
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
            initialUrl: 'http://${server.address}:${server.port}/assets/webview/content.html',
            onPageStarted: (_) {
              setState(() => stackToView = 1);
            },
            onPageFinished: (_) {
              setState(() => stackToView = 0);
            },
            javascriptMode: JavascriptMode.unrestricted,
            javascriptChannels: channels.toSet(),
            navigationDelegate: (navigation) {
              if (navigation.url.startsWith('http') && !navigation.url.startsWith('http://${server.address}:${server.port}/')) {
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
  set result(APIEndpointResultHTML result) {
    if (mounted) {
      SettingsModel settingsModel = Provider.of<SettingsModel>(context, listen: false);
      Server server = Provider.of<Server>(context, listen: false);

      String address = 'http://${server.address}:${server.port}';
      server.formatArguments = {
        'assets/webview/content.html': [
          FormatArgument('address', address),
          FormatArgument('content', result.html),
          FormatArgument('dark_theme_css', settingsModel.darkModeEnabled ? '<link rel="stylesheet" href="$address/assets/webview/css/dark.css">' : ''),
          FormatArgument('dark_theme_js', settingsModel.darkModeEnabled ? '<script src="$address/assets/webview/js/dark.js"></script>' : ''),
        ],
        'assets/webview/js/lesson.js': [
          FormatArgument('base_url', API.BASE_URL),
          FormatArgument('level', result.lesson.level),
          FormatArgument('lesson', result.lesson.id.replaceAll('-', '_')),
          FormatArgument('anchor', widget.anchor ?? ''),
        ],
      };
    }
    super.result = result;
  }
}
