import 'dart:io';
import 'dart:math';

import 'package:bacomathiques/app/api/common.dart';
import 'package:bacomathiques/app/app.dart';
import 'package:bacomathiques/app/dialogs.dart';
import 'package:flutter/material.dart';
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
abstract class RequestScaffold<W extends StatefulWidget, R extends APIEndpointResult> extends State<W> {
  /// Whether the screen is currently loading.
  bool _loading = true;

  /// The API endpoint.
  APIEndpoint<R> endpoint;

  /// The object.
  R result;

  /// When the request fails.
  String failMessage;

  /// The success callback.
  VoidCallback successCallback;

  /// Fail dialog options.
  FailDialogOptions failDialogOptions;

  /// Creates a new loading scaffold instance.
  RequestScaffold({
    @required this.endpoint,
    @required this.failMessage,
    this.successCallback,
    this.failDialogOptions = const FailDialogOptions(),
  });

  @override
  void initState() {
    super.initState();
    triggerRequest();
  }

  /// Creates the app bar.
  AppBar createAppBar(BuildContext context) {
    if (result == null) {
      return AppBar(
        title: Text(_loading ? 'Chargement…' : 'Erreur'),
      );
    }

    return result.createAppBar(context);
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (_loading) {
      body = CenteredCircularProgressIndicator();
    } else if (result == null) {
      body = createNoObjectBody(context);
    } else {
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
    endpoint.request().then((object) {
      if (object != null) {
        updateObject(object);
        if (successCallback != null) {
          successCallback();
        }
        return;
      }

      if (failDialogOptions.show) {
        MessageDialog.show(
          context,
          failMessage + '\nVeuillez vérifier votre connexion internet et réessayer plus tard.',
          () => Navigator.pop(context),
          failDialogOptions.callback ?? () => Navigator.pop(context),
        );
      }
      loading = false;
    });
  }

  /// Creates the body with a non-null object.
  Widget createBody(BuildContext context);

  /// Creates the body with a null object.
  Widget createNoObjectBody(BuildContext context) => null;

  /// Updates the current object.
  void updateObject(R object) {
    if (mounted) {
      setState(() {
        _loading = false;
        result = object;
      });
    }
  }
}

/// Options for the fail dialog.
class FailDialogOptions {
  /// Whether to show it.
  final bool show;

  /// The dialog callback.
  final VoidCallback callback;

  /// Creates a new fail dialog options instance.
  const FailDialogOptions({
    this.show = true,
    this.callback,
  });
}
