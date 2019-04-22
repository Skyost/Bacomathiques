import 'package:bacomathiques/app/admob.dart';
import 'package:bacomathiques/app/app.dart';
import 'package:bacomathiques/screen/comments.dart';
import 'package:bacomathiques/screen/home.dart';
import 'package:bacomathiques/screen/html.dart';
import 'package:bacomathiques/util/server.dart';
import 'package:bacomathiques/util/util.dart' as Util;
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:rate_my_app/rate_my_app.dart';

/// The port to open for local servers.
const int LOCAL_SERVER_PORT = 8080;

/// The AdMob instance.
AdMob adMob = AdMob();

/// The RateMyApp instance.
RateMyApp rateMyApp = RateMyApp();

/// The local server.
Server localServer = Server(LOCAL_SERVER_PORT);

/// Hello world !
void main() {
  rateMyApp.init().then((v) => runApp(BacomathiquesApp()));

  if (!Util.isInDebugMode) {
    adMob.load();
  }

  FlutterStatusbarcolor.setNavigationBarColor(App.ACTION_BAR_COLOR);
  FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);

  localServer.start();
}

/// The app main class.
class BacomathiquesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: App.APP_NAME,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: App.PRIMARY_COLOR,
            primaryColorDark: App.PRIMARY_COLOR_DARK,
            accentColor: App.ACCENT_COLOR,
            appBarTheme: AppBarTheme(color: App.ACTION_BAR_COLOR),
            textTheme: TextTheme(
              button: TextStyle(color: App.ACCENT_COLOR),
            )),
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/html': (context) {
            Map<String, dynamic> arguments = ModalRoute.of(context).settings.arguments;
            return HTMLScreen(arguments['relativeURL'], arguments['requestObjectFunction'], arguments['anchor']);
          },
          '/comments': (context) {
            Map<String, dynamic> arguments = ModalRoute.of(context).settings.arguments;
            return CommentsScreen(arguments['relativeURL']);
          },
        },
      );
}
