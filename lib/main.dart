import 'package:bacomathiques/app/admob.dart';
import 'package:bacomathiques/app/app.dart';
import 'package:bacomathiques/screen/home.dart';
import 'package:bacomathiques/screen/html.dart';
import 'package:bacomathiques/util/util.dart' as Util;
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

/// The AdMob instance.
AdMob adMob = AdMob();

/// Hello world !
void main() {
  runApp(BacomathiquesApp());

  if (!Util.isInDebugMode) {
    adMob.load();
  }

  FlutterStatusbarcolor.setNavigationBarColor(App.ACTION_BAR_COLOR);
  FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
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
        },
      );
}
