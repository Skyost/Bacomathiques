import 'package:bacomathiques/app/admob.dart';
import 'package:bacomathiques/app/app.dart';
import 'package:bacomathiques/screen/comments.dart';
import 'package:bacomathiques/screen/home.dart';
import 'package:bacomathiques/screen/html.dart';
import 'package:bacomathiques/screen/lessons.dart';
import 'package:bacomathiques/screen/levels.dart';
import 'package:bacomathiques/utils/server.dart';
import 'package:bacomathiques/utils/utils.dart' as utils;
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

/// The port to open for local servers.
const int LOCAL_SERVER_PORT = 8080;

/// The AdMob instance.
AdMob adMob = AdMob();

/// The local server.
Server localServer = Server(LOCAL_SERVER_PORT);

/// Hello world !
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (!utils.isInDebugMode) {
    adMob.load();
  }

  FlutterStatusbarcolor.setNavigationBarColor(App.ACTION_BAR_COLOR);
  FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);

  localServer.start();

  runApp(BacomathiquesApp());
}

/// The app main class.
class BacomathiquesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: App.APP_NAME,
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
          '/': (context) => HomePage(),
          '/levels': (context) => LevelsPage(),
          '/lessons': (context) {
            Map<String, dynamic> arguments = ModalRoute.of(context).settings.arguments;
            return LessonsPage(arguments['endpoint']);
          },
          '/html': (context) {
            Map<String, dynamic> arguments = ModalRoute.of(context).settings.arguments;
            return HTMLPage(arguments['endpoint'], arguments['anchor']);
          },
          '/comments': (context) {
            Map<String, dynamic> arguments = ModalRoute.of(context).settings.arguments;
            return CommentsPage(arguments['endpoint']);
          },
        },
      );
}
