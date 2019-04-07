import 'package:bacomathiques/app/lesson.dart';
import 'package:bacomathiques/main.dart' as Main;
import 'package:bacomathiques/util/server.dart';
import 'package:bacomathiques/util/util.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
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
  State<StatefulWidget> createState() => HTMLScreenState();
}

/// State of HTML screens.
class HTMLScreenState extends State<HTMLScreen> {
  /// The port to open for local servers.
  static const int _PORT = 8080;

  /// The local server.
  Server _server;

  /// Whether the current screen is loading.
  bool _loading;

  /// The banner ad.
  BannerAd _ad;

  /// The API object.
  APIObject _object;

  /// Creates a new HTML screen state instance.
  HTMLScreenState() : _loading = true;

  @override
  Widget build(BuildContext context) {
    Widget body = _loading ? CenteredCircularProgressIndicator() : _createWebViewWidget();
    List<Widget> actions = _object != null && _object.actions.isNotEmpty ? _createActionsWidgets() : [];

    return Scaffold(
      appBar: AppBar(
        title: Text(_object == null ? 'Chargement…' : _object.title),
        actions: actions,
      ),
      body: body,
    );
  }

  @override
  void initState() {
    super.initState();

    int marginBottom = Main.adMob.isEnabled() ? 60 : 0;
    widget._requestObjectFunction(widget._relativeURL).then((object) {
      if (object != null) {
        _updateObject(object, marginBottom);
        return;
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text('Impossible de charger ce contenu et aucune sauvegarde n\'est disponible.\nVeuillez vérifier votre connexion internet et réessayer.'),
              actions: [
                FlatButton(
                  child: Text('Ok'.toUpperCase()),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
      );
    });

    if (Main.adMob.isEnabled()) {
      BannerAd ad = Main.adMob.createBannerAd();
      ad.load().then((loaded) => _showBanner(ad, loaded));
    }
  }

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

  /// Updates the current object.
  void _updateObject(APIObject object, int marginBottom) {
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
        FormatArgument('margin_bottom', marginBottom.toString()),
      ]
    });

    _server.start().then((v) => setState(() {
          _loading = false;
          _object = object;
        }));
  }

  /// Shows the ad banner.
  void _showBanner(BannerAd ad, bool loaded) {
    if (!loaded) {
      return;
    }

    _ad = ad;
    ad.show();
  }

  /// Creates the webview widget.
  Widget _createWebViewWidget() => WebView(
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
          } if (navigation.url.startsWith('http') && !navigation.url.startsWith("http://localhost:$_PORT/")) {
            openURL(navigation.url);
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      );

  /// Creates action bar actions widgets.
  List<Widget> _createActionsWidgets() => [
        IconButton(
          icon: Icon(
            Icons.share,
            color: Colors.white,
          ),
          onPressed: () => Share.share('Lisez le cours intitulé « ' + _object.title + ' » en téléchargeant l\'application Bacomathiques !\n' + storePage),
        ),
        PopupMenuButton<ActionMenu>(
          onSelected: (action) => action.callback(context, _object),
          itemBuilder: (context) => _object.actions
              .map(
                (action) => PopupMenuItem<ActionMenu>(
                      value: action,
                      child: action.createWidget(),
                    ),
              )
              .toList(),
        )
      ];
}
