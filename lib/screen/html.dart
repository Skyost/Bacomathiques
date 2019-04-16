import 'package:bacomathiques/app/lesson.dart';
import 'package:bacomathiques/main.dart' as Main;
import 'package:bacomathiques/util/server.dart';
import 'package:bacomathiques/util/util.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// A screen that is able to display some HTML content.
class HTMLScreen extends StatefulWidget {
  /// The relative URL to display.
  final String _relativeURL;

  /// The function that is able to request objects from the given URL.
  final Function(String) _requestObjectFunction;

  /// The current anchor.
  final String _anchor;

  /// Creates a new HTML screen instance.
  HTMLScreen(this._relativeURL, this._requestObjectFunction, this._anchor);

  @override
  State<StatefulWidget> createState() => HTMLScreenState(() => _requestObjectFunction(_relativeURL));
}

/// State of HTML screens.
class HTMLScreenState extends RequestScaffold<HTMLScreen, APIObject> {
  /// The port to open for local servers.
  static const int _PORT = 8080;

  /// The local server.
  Server _server;

  /// The banner ad.
  BannerAd _ad;

  /// Creates a new HTML screen state instance.
  HTMLScreenState(Function() _requestObjectFunction) : super(_requestObjectFunction, 'Impossible de charger ce contenu et aucune sauvegarde n\'est disponible.');

  @override
  void initState() {
    super.initState();

    if (Main.adMob.isEnabled()) {
      BannerAd ad = Main.adMob.createBannerAd();
      ad.load().then((loaded) => _showBanner(ad, loaded));
    }
  }

  @override
  AppBar createAppBar(BuildContext context) => AppBar(
        title: Text(object == null ? 'Chargement…' : object.title),
        actions: object?.createActions(context),
      );

  @override
  Widget createBody(BuildContext context) => WebView(
        initialUrl: "http://localhost:$_PORT/assets/webview/content.html",
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (navigation) {
          if (navigation.url.startsWith("http://localhost:$_PORT/") && !navigation.url.contains('/webview/') && (navigation.url.contains('/#') || navigation.url.endsWith('/'))) {
            final List<String> parts = navigation.url.split("/#");

            final String id = parts[0].replaceAll("http://localhost:$_PORT/assets", '').replaceAll('/', '').replaceAll('-', '_');
            Map<String, dynamic> arguments = {
              'relativeURL': APIObject.API_PATH.substring(APIObject.WEBSITE.length) + 'content/' + id + '.json',
              'requestObjectFunction': Lesson.request,
            };
            if (parts.length > 1) {
              arguments['anchor'] = parts[1];
            }

            _disposeAd();
            Navigator.pop(context);
            Navigator.pushNamed(context, '/html', arguments: arguments);
            return NavigationDecision.prevent;
          }
          if (navigation.url.startsWith('http') && !navigation.url.startsWith("http://localhost:$_PORT/")) {
            openURL(navigation.url);
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      );

  @override
  void deactivate() {
    _disposeAd();
    if (_server != null) {
      _server.close().then((v) => super.deactivate());
    }
  }

  /// Disposes the ad.
  Future<void> _disposeAd() async {
    if (_ad != null) {
      await _ad.dispose();
    }
  }

  @override
  void updateObject(APIObject object) {
    _server = Server(_PORT, {
      'assets/webview/content.html': [
        FormatArgument('content', object.content),
      ],
      'assets/webview/script.js': [
        FormatArgument('base_url', APIObject.WEBSITE),
        FormatArgument('page_id', object.id),
        FormatArgument('anchor', widget._anchor ?? ''),
      ],
      'assets/webview/style.css': [
        FormatArgument('margin_bottom', (Main.adMob.isEnabled() ? 60 : 0).toString()),
      ]
    });

    _server.start().then((v) => super.updateObject(object));
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
