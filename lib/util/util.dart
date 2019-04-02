import 'dart:io';

import 'package:bacomathiques/app/app.dart';
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

/// A centered circular progress indicator.
class CenteredCircularProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(App.PRIMARY_COLOR),
        ),
      );
}
