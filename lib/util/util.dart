import 'dart:io';
import 'dart:math';

import 'package:bacomathiques/app/app.dart';
import 'package:bacomathiques/app/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:url_launcher/url_launcher.dart';

/// The app store page.
final String storePage = Platform.isAndroid ? 'https://play.google.com/store/apps/details?id=fr.bacomathiques' : 'http://itunes.apple.com/app/id1458503418';

/// Returns whether we're in debug mode.
bool get isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}

/// Opens an URL with the default browser.
void openURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  }
}

/// Gets the content from the specified url and saves it to the local storage.
Future<String> getAndSave(String file, String key, String url) async {
  LocalStorage storage = LocalStorage(file);
  await storage.ready;

  String content;
  try {
    content = await http.read(url);
    storage.setItem(key, content);
  } catch (ignored) {
    content = storage.getItem(key);
  }

  return content;
}

/// Returns whether the current screen is a tablet.
bool isTablet(Size screenSize) {
  double diagonal = sqrt(pow(screenSize.width, 2) + pow(screenSize.height, 2));
  return diagonal > 1100 || screenSize.shortestSide >= 600;
}

/// A centered circular progress indicator.
class CenteredCircularProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(App.PRIMARY_COLOR),
        ),
      );
}

/// A scaffold that allows to request remote objects.
abstract class RequestScaffold<W extends StatefulWidget, O> extends State<W> {
  /// Whether the screen is currently loading.
  bool _loading;

  /// The function that allows to load objects.
  Function() _requestObjectFunction;

  /// The object.
  O object;

  /// When the request fails.
  String _failMessage;

  /// Triggered when the fail dialog is closed.
  VoidCallback _failDialogClosedCallback;

  /// Creates a new loading scaffold instance.
  RequestScaffold(this._requestObjectFunction, this._failMessage, [this._failDialogClosedCallback]) : this._loading = true;

  @override
  void initState() {
    super.initState();
    triggerRequest();
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if(_loading) {
      body = CenteredCircularProgressIndicator();
    }
    else if(object == null) {
      body = createNoObjectBody(context);
    }
    else {
      body = createBody(context);
    }

    return Scaffold(
      appBar: createAppBar(context),
      body: body,
    );
  }

  /// Sets whether the screen is currently loading.
  set loading(bool loading) => setState(() {
        _loading = loading;
      });

  /// Returns whether the current screen is loading.
  bool get loading => _loading;

  /// Triggers a request.
  void triggerRequest() {
    _requestObjectFunction().then((object) {
      if (object != null) {
        updateObject(object);
        return;
      }

      MessageDialog.show(
        context,
        _failMessage + '\nVeuillez vérifier votre connexion internet et réessayer.',
        () => Navigator.pop(context),
        _failDialogClosedCallback ?? () => Navigator.pop(context),
      );
      loading = false;
    });
  }

  /// Creates the app bar.
  AppBar createAppBar(BuildContext context);

  /// Creates the body with a non-null object.
  Widget createBody(BuildContext context);

  /// Creates the body with a null object.
  Widget createNoObjectBody(BuildContext context) => null;

  /// Updates the current object.
  void updateObject(O object) => setState(() {
        _loading = false;
        this.object = object;
      });
}
